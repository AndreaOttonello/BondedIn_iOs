

#import <UIKit/UIKit.h>
#import "OAuthLoginView.h"

@interface HomeTabView :UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>


@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) OAuthLoginView *oAuthLoginView;
@property (retain, nonatomic) IBOutlet UITextField *txtSelectorTecnology;
@property (retain, nonatomic) IBOutlet UITextField *txtSelectorProvince;
@property (retain, nonatomic) IBOutlet UITextField *txtSelectorCity;
@property (retain, nonatomic) IBOutlet UILabel *labelTecnology;
@property (retain, nonatomic) IBOutlet UILabel *labelProvince;
@property (retain, nonatomic) IBOutlet UILabel *labelCity;
@property (retain, nonatomic) IBOutlet UIButton *btnLoadListView;
@property (nonatomic, retain)  UIPickerView *pickerViewProvince;
@property (nonatomic, retain)  UIPickerView *pickerViewTecnology;
@property (retain) NSArray *pickerElemsProvince;
@property (retain) NSArray *pkProvinces;
@property (retain) NSArray *pickerElemsTecnology;
@property (retain) NSDictionary *provinces;
@property (retain) NSMutableArray *resultsDeveloperJSON;


- (IBAction)touchDown:(id)sender;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (IBAction)button_TouchUp:(UIButton *)sender;
- (NSArray*) existProvince;

@end
