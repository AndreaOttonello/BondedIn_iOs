//
//  ContactViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 10/29/13.
//  Copyright (c) 2013 self. All rights reserved.
//

#import "ContactViewController.h"
#import "NoteViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

@synthesize cells;
@synthesize mail;
@synthesize phone;
@synthesize sections;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithTitle:(NSString*)aTitle andMail:mail andPhone:phone
{
    if (self = [super init])
    {
        self.title= @"Contact";
        self.mail=mail;
        self.phone=phone;
        self.cells=[NSMutableArray array];
        self.sections=[NSMutableArray array];
        
        //sections
        [self.sections addObject:@"Contact"];
        [self.sections addObject:@"Add Note"];

        //cell data
         NSMutableArray* section1 = [NSMutableArray array];
        [section1 addObject:@"Mail"];
        [section1 addObject:@"Phone"];
        [self.cells addObject:section1];
         NSMutableArray* section2 = [NSMutableArray array];
        [section2 addObject:@"Note"];
        [self.cells addObject:section2];

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
     return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.cells objectAtIndex:section] count];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
     return [self.sections objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewStyleGrouped reuseIdentifier:cellIdentifier];
        //Style text -detailText
        cell.contentView.backgroundColor = self.tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    cell.textLabel.text=[[self.cells objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
      
    return cell;
}

- (void)showEmail {
     // Email Subject
     NSString *emailTitle = @"Search Developer";
     // Email Content
     NSString *messageBody = @"Hi";
     // To address
     NSArray *toRecipents = [NSArray arrayWithObject:self.mail];
     
     MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
     mc.mailComposeDelegate = self;
     [mc setSubject:emailTitle];
     [mc setMessageBody:messageBody isHTML:NO];
     [mc setToRecipients:toRecipents];
     
     // Present mail view controller on screen
     [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *option=[[self.cells objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    
    //Option send an email
    if([option isEqualToString:@"Mail"]){
        [self showEmail];
    }
    //Option call phone
    else if([option isEqualToString:@"Phone"]){
        //call phone
        NSString *phoneStr = [[NSString alloc] initWithFormat:@"tel:%@",self.phone];
        NSURL *phoneURL = [[NSURL alloc] initWithString:phoneStr];
        [[UIApplication sharedApplication] openURL:phoneURL];
    }
    else{
        //Create the navigation controller
        NoteViewController *noteViewController = [[NoteViewController alloc] initWithNibName:nil bundle:nil];
        //Init the view controller
        //Allow the navigation to detailView
        [self.navigationController pushViewController:noteViewController animated:YES];

    }
    
     
}

@end
