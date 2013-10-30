//
//  ListViewController.h
//

#import <UIKit/UIKit.h>

@interface ListViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, assign) int selectedIndex;
@property (retain) NSMutableArray *developerCells;
@property (retain) NSMutableArray *sections;
@property (retain) NSMutableArray *rows;
@property (retain) NSMutableArray *filteredArray;
- (id)initWithTitle:(NSString*)aTitle andCells:cells andProvinces:provinces;

@end

