//
//  MCLocalization.h
//  MCLocalization
//
//  Created by Baglan on 3/14/13.
//  Copyright (c) 2013 MobileCreators. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MCLocalizationLanguageDidChangeNotification @"MCLocalizationLanguageDidChangeNotification"

@interface MCLocalization : NSObject

@property (nonatomic, copy) NSString * language;
@property (nonatomic, readonly) NSArray * supportedLanguages;
@property (nonatomic, readonly) NSString * systemLanguage;

+ (NSString *)stringForKey:(NSString *)key;
+ (NSString *)stringForKey:(NSString *)key withPlaceholders:(NSDictionary *)placeholders;
+ (MCLocalization *)sharedInstance;

+ (void)loadFromJSONFile:(NSString *)fileName defaultLanguage:(NSString *)defaultLanguage;

@end
