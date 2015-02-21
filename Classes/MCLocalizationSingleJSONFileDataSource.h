//
//  MCLocalizationSingleJSONFileDataSource.h
//  MCLocalization
//
//  Created by Baglan on 2/21/15.
//  Copyright (c) 2015 MobileCreators. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCLocalizationDataSource.h"

@interface MCLocalizationSingleJSONFileDataSource : NSObject <MCLocalizationDataSource>

- (id)initWithURL:(NSURL *)URL defaultLanguage:(NSString *)defaultLanguage;

@end
