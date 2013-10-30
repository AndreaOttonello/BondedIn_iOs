//
//  ListViewController.m
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "DeveloperModel.h"


@interface ListViewController ()

@end

@implementation ListViewController

@synthesize developerCells;
@synthesize selectedIndex;
@synthesize sections;
@synthesize rows;
@synthesize searchBar;
@synthesize filteredArray;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithTitle:(NSString*)aTitle andCells:cells andProvinces:provinces
{
    if (self = [super init])
    {
        self.title= aTitle;
        self.developerCells = cells;
        self.selectedIndex=-1;
       
        self.sections=[NSMutableArray array];
        self.rows = [NSMutableArray array];
        self.filteredArray = [NSMutableArray arrayWithCapacity:[self.developerCells count]];
       
        
        //Add sections (provinces)
        for (id province in provinces){
            [self.sections addObject:province];
        }
        
        //For each section add the rows
        for (id provinceResult in self.sections){
            NSString *province=provinceResult;
            NSMutableArray* section = [NSMutableArray array];
            for (id developerResult in self.developerCells ){
                DeveloperModel *developer = developerResult;
                if([developer.province isEqualToString:province]){
                    [section addObject:developer];
                }
            }
           [self.rows addObject:section];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{   [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return 1;
    else
        return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredArray count];
    } else {
       return [[self.rows objectAtIndex:section] count];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
    if (tableView == self.searchDisplayController.searchResultsTableView)
        return nil;
    else
        return [self.sections objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewStyleGrouped reuseIdentifier:cellIdentifier];
        //Style text -detailText
        cell.contentView.backgroundColor = self.tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    DeveloperModel *developer;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
          developer =  [self.filteredArray objectAtIndex:indexPath.row];
    } else {
          developer =  [[self.rows objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    }
    //Developers
    NSString *firstName = developer.firstName;
    NSString *lastName = developer.lastName;
    NSString *fullName=[NSString stringWithFormat:@"%@ %@.", firstName,lastName];
    NSString *city= [NSString stringWithFormat:@"%@ %@%",@"City:",developer.province];
    NSString *company= [NSString stringWithFormat:@"%@ %@%",@"Company:",developer.company];
    
    //Firts and Last Name
    UILabel *mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 200, 25.0)];
    mainLabel.text=fullName;
    mainLabel.font = [UIFont boldSystemFontOfSize:16];
    mainLabel.textColor = [UIColor blackColor];
    [cell.contentView addSubview:mainLabel];
    
    //City
    UILabel *secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 35.0, 200, 20.0)];
    secondLabel.text=city;
    secondLabel.font =  [UIFont boldSystemFontOfSize:12];
    secondLabel.textColor = [UIColor darkGrayColor];
    [cell.contentView addSubview:secondLabel];
    
    //Current Company
    UILabel *thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 55, 200, 15.0)];
    thirdLabel.text=company;
    thirdLabel.font =  [UIFont systemFontOfSize:12];
    thirdLabel.textColor = [UIColor lightGrayColor];
    [cell.contentView addSubview:thirdLabel];
    
    
    //Loading Asynchronous pictures
    cell.imageView.image=nil;
    NSURL* url = [NSURL URLWithString:developer.pictureUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   UIImage* image = [[UIImage alloc] initWithData:data];
                                   cell.imageView.image=image;
                               }
                               
                           }];
    CGSize itemSize = CGSizeMake(80, 80);
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect = CGRectMake(5.0, 5.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
     
    // Remove all objects from the filtered search array
	[self.filteredArray removeAllObjects];
    
	// Filter the array using NSPredicate FIRSTNAME
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.firstName contains[c] %@",searchText];
    NSArray *tempArray = [self.developerCells filteredArrayUsingPredicate:predicate];
    if (![scope isEqualToString:@"Name"]) {
        // Further filter the array with COMPANY
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.company contains[c] %@",searchText];
        tempArray = [self.developerCells filteredArrayUsingPredicate:scopePredicate];
    }
    self.filteredArray = [NSMutableArray arrayWithArray:tempArray];
    
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Developers
    DeveloperModel *developer;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        developer =  [self.filteredArray objectAtIndex:indexPath.row];
    } else {
        developer =  [[self.rows objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
    }
   
    //Create an instance of DetailViewController
    UIViewController *detailViewController=[[DetailViewController alloc] initWithTitle:@"Profile" andUrl:developer.publicProfileUrl ];

    //Allow the navigation to detailView
    [self.navigationController pushViewController:detailViewController animated:YES];
       
    
}

- (void)dealloc {
   [super dealloc];
}
@end
