//
//  MCLocalizationSingleJSONFileDataSource.m
//  MCLocalization
//
//  Created by Baglan on 2/21/15.
//  Copyright (c) 2015 MobileCreators. All rights reserved.
//

#import "MCLocalizationSingleJSONFileDataSource.h"

@implementation MCLocalizationSingleJSONFileDataSource {
    NSDictionary * _strings;
    NSString * _defaultLanguage;
    NSArray * _supportedLanguages;
}

- (id)initWithStrings:(NSDictionary *)strings defaultLanguage:(NSString *)defaultLanguage {
    self = [super init];
    
    if (self) {
        _strings = strings;
        _supportedLanguages = [_strings.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        _defaultLanguage = [defaultLanguage copy];
    }

    return self;
}

- (id)initWithURL:(NSURL *)URL defaultLanguage:(NSString *)defaultLanguage
{
    NSData * JSONData = [NSData dataWithContentsOfURL:URL];
    _strings = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    _defaultLanguage = defaultLanguage;
    
    return [self initWithStrings:_strings defaultLanguage:_defaultLanguage];
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
    return _strings[language];
}

@end
