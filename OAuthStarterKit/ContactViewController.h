//
//  ContactViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 10/29/13.
//  Copyright (c) 2013 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (retain) NSString *mail;
@property (retain) NSString *phone;
@property (retain) NSMutableArray *cells;
@property (retain) NSMutableArray *sections;

- (void)showEmail;
- (id)initWithTitle:(NSString*)aTitle andMail:mail andPhone:phone;

@end
