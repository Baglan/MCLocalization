//
//  MCLocalization.m
//  MCLocalization
//
//  Created by Baglan on 3/14/13.
//  Copyright (c) 2013 MobileCreators. All rights reserved.
//

#import "MCLocalization.h"

#define MCLOCALIZATION_PREFERRED_LOCALE_KEY @"MCLOCALIZATION_PREFERRED_LOCALE_KEY"

@implementation MCLocalization {
    NSString * _language;
    NSDictionary * _strings;
    NSString * _defaultLanguage;
}

// Singleton
// Taken from http://lukeredpath.co.uk/blog/a-note-on-objective-c-singletons.html
+ (MCLocalization *)sharedInstance
{
    __strong static id _sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

#pragma mark -
#pragma mark Loading

- (void)loadFromJSONFile:(NSString *)fileName defaultLanguage:(NSString *)defaultLanguage
{
    _strings = nil;
    
    NSData * JSONData = [NSData dataWithContentsOfFile:fileName];
    _strings = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
    
    _defaultLanguage = defaultLanguage;
}

+ (void)loadFromJSONFile:(NSString *)fileName defaultLanguage:(NSString *)defaultLanguage
{
    [[self sharedInstance] loadFromJSONFile:fileName defaultLanguage:defaultLanguage];
}

#pragma mark -
#pragma mark Supported languages

- (NSArray *)supportedLanguages
{
    return [_strings allKeys];
}

#pragma mark -
#pragma mark Language

- (NSString *)sanitizeLanguage:(NSString *)language
{
    // Is language supported?
    if ([self.supportedLanguages indexOfObject:language] == NSNotFound) {
        language = nil;
    }
    
    // Try to figure out language from locale
    if (!language) {
        NSArray *preferredLanguages = [NSLocale preferredLanguages];
        language = [preferredLanguages firstObjectCommonWithArray:self.supportedLanguages];
    }
    
    // In the worst case, return default setting
    if (language == nil) {
        language = _defaultLanguage;
    }
    
    return language;
}

- (NSString *)language
{
    if (!_language) {
        NSString *preferredLanguage = [[NSUserDefaults standardUserDefaults] stringForKey:MCLOCALIZATION_PREFERRED_LOCALE_KEY];
        preferredLanguage = [self sanitizeLanguage:preferredLanguage];
        self.language = [preferredLanguage copy];
    }
    return _language;
}

- (void)setLanguage:(NSString *)language
{
    language = [self sanitizeLanguage:language];
    
    // Skip is the new setting is the same as the old one
    if (![language isEqual:_language]) {
        // Get rid of the current setting
        _language = nil;
        
        // Check if new setting is supported by localization
        if ([self.supportedLanguages indexOfObject:language] != NSNotFound) {
            _language = [language copy];
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:MCLocalizationLanguageDidChangeNotification object:nil]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:_language forKey:MCLOCALIZATION_PREFERRED_LOCALE_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark -
#pragma mark Strings

- (NSString *)stringForKey:(NSString *)key language:(NSString *)language
{
    NSDictionary * langugeStrings = _strings[language];
    NSString * string = langugeStrings[key];
    if (!string) {
        NSLog(@"MCLocalization: no string for key %@ in language %@", key, language);
    }
    return string;
}

- (NSString *)stringForKey:(NSString *)key
{
    return [self stringForKey:key language:self.language];
}

+ (NSString *)stringForKey:(NSString *)key
{
    return [[MCLocalization sharedInstance] stringForKey:key];
}

+ (NSString *)stringForKey:(NSString *)key withPlaceholders:(NSDictionary *)placeholders
{
    return [[MCLocalization sharedInstance] stringForKey:key withPlaceholders:placeholders];
}

- (NSString *)stringForKey:(NSString *)key withPlaceholders:(NSDictionary *)placeholders
{
    NSString * string = [self stringForKey:key];
    NSError *e;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"%\\w+%"
                                                                           options:0
                                                                             error:&e];
    
    NSArray *matches = [regex matchesInString:string
                                      options:0
                                        range:NSMakeRange(0, [string length])];
    
    if (matches) {
        for (NSTextCheckingResult *match in matches) {
            NSRange matchRange = [match range];
            NSString *placeholderKey = [string substringWithRange:matchRange];
            
            NSString *placeholderValue = (NSString *) [placeholders objectForKey:placeholderKey];
            
            if (!placeholderValue) {
                NSLog(@"MCLocalization: no value for placeholder %@ for key %@ in language %@", placeholderKey, key, self.language);
            }
            
            string = [string stringByReplacingOccurrencesOfString:placeholderKey withString:placeholderValue];
        }
    }
    
    return string;
    
}

@end
