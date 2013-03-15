//
//  ViewController.h
//  MCLocalization
//
//  Created by Baglan on 3/14/13.
//  Copyright (c) 2013 MobileCreators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    __weak IBOutlet UILabel *_greetingLabel;
    __weak IBOutlet UILabel *_messageLabel;
    __weak IBOutlet UILabel *_placeholderLabel;
}

- (IBAction)switchToRussian:(id)sender;
- (IBAction)switchToEnglish:(id)sender;

@end
