//
//  MailViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 10/28/13.
//  Copyright (c) 2013 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MailViewController : UIViewController  <MFMailComposeViewControllerDelegate>

- (IBAction)showEmail:(id)sender;

@end
