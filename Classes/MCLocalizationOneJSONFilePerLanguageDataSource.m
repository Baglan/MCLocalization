//
//  MCLocalizationOneJSONFilePerLanguageDataSource.m
//  MCLocalization
//
//  Created by Baglan on 2/21/15.
//  Copyright (c) 2015 MobileCreators. All rights reserved.
//

#import "MCLocalizationOneJSONFilePerLanguageDataSource.h"

@implementation MCLocalizationOneJSONFilePerLanguageDataSource {
    NSDictionary * _languageURLPairs;
    NSString * _defaultLanguage;
    NSArray * _supportedLanguages;
}

- (id)initWithLanguageURLPairs:(NSDictionary *)languageURLPairs defaultLanguage:(NSString *)defaultLanguage
{
    self = [super init];
    
    if (self) {
        _languageURLPairs = languageURLPairs;
        _supportedLanguages = [_languageURLPairs.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        _defaultLanguage = [defaultLanguage copy];
    }
    
    return self;
}

- (NSArray *)supportedLanguages
{
    return _supportedLanguages;
}

- (NSString *)defaultLanguage
{
    return _defaultLanguage;
}

- (NSDictionary *)stringsForLanguage:(NSString *)language
{
    NSURL * URL = _languageURLPairs[language];
    NSData * JSONData = [NSData dataWithContentsOfURL:URL];
    NSDictionary * strings = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    return strings;
}

@end
