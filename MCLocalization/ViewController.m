//
//  ViewController.m
//  MCLocalization
//
//  Created by Baglan on 3/14/13.
//  Copyright (c) 2013 MobileCreators. All rights reserved.
//

#import "ViewController.h"
#import "MCLocalization.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localize) name:MCLocalizationLanguageDidChangeNotification object:nil];
    
    [self localize];
}

- (void)localize
{
    _greetingLabel.text = [MCLocalization stringForKey:@"greeting"];
    _messageLabel.text = [MCLocalization stringForKey:@"message"];
    _placeholderLabel.text = [MCLocalization stringForKey:@"glory" withPlaceholders:@{@"%name%":@"Man United"}];
    _mustacheLabel.text = [MCLocalization stringForKey:@"lovely-mustache" withPlaceholders:@{@"{{mustache}}":[MCLocalization stringForKey:@"mustache"]}];
}

- (IBAction)switchToRussian:(id)sender
{
    [MCLocalization sharedInstance].language = @"ru";
}

- (IBAction)switchToEnglish:(id)sender
{
    [MCLocalization sharedInstance].language = @"en";
}

@end
