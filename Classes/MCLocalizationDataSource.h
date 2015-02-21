//
//  MCLocalizationDataSource.h
//  MCLocalization
//
//  Created by Baglan on 2/21/15.
//  Copyright (c) 2015 MobileCreators. All rights reserved.
//

@protocol MCLocalizationDataSource <NSObject>

- (NSArray *)supportedLanguages;
- (NSString *)defaultLanguage;
- (NSDictionary *)stringsForLanguage:(NSString *)language;

@end
