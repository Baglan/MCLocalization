//
//  MCLocalizationOneJSONFilePerLanguageDataSource.h
//  MCLocalization
//
//  Created by Baglan on 2/21/15.
//  Copyright (c) 2015 MobileCreators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCLocalizationDataSource.h"

@interface MCLocalizationOneJSONFilePerLanguageDataSource : NSObject <MCLocalizationDataSource>

- (id)initWithLanguageURLPairs:(NSDictionary *)languageURLPairs defaultLanguage:(NSString *)defaultLanguage;

@end
