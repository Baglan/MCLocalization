//
//  MCLocalizationDummyDataSource.m
//  MCLocalization
//
//  Created by Baglan on 2/21/15.
//  Copyright (c) 2015 MobileCreators. All rights reserved.
//

#import "MCLocalizationDummyDataSource.h"

@implementation MCLocalizationDummyDataSource

- (NSArray *)supportedLanguages
{
    return @[@"en"];
}

- (NSString *)defaultLanguage
{
    return @"en";
}

- (NSDictionary *)stringsForLanguage:(NSString *)language
{
    return @{};
}

@end
