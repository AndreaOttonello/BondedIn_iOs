//
//  NoteViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 10/29/13.
//  Copyright (c) 2013 self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteViewController : UIViewController  <UITextViewDelegate>

@property (retain, nonatomic) IBOutlet UITextView *noteText;
@property (retain, nonatomic) IBOutlet UIButton *buttonAddNote;
- (IBAction)onTouchDown:(id)sender;

@end
