//
//  NoteViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 10/29/13.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "NoteViewController.h"
#import "ContactViewController.h"
//NSUserDefaults - iCodeBlog

@interface NoteViewController ()

@end

@implementation NoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTitle:(NSString*)aTitle
{
    if (self = [super init])
    {
        self.title= aTitle;
       
    }
    
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_noteText release];
    [_buttonAddNote release];
    [super dealloc];
}
- (IBAction)onTouchDown:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Messagge"
                                                    message:@"Note has been successfully registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
