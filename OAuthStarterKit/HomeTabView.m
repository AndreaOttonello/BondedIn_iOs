
//BondedIn

#import <Foundation/NSNotificationQueue.h>
#import "HomeTabView.h"
#import "ListViewController.h"
#import "AFNetworking.h"
#import "DeveloperClient.h"
#import "DeveloperModel.h"
#define tagTecnology 1
#define tagProvince 2
#define tagCity 3



@interface HomeTabView ()

@end


@implementation HomeTabView


@synthesize oAuthLoginView;
@synthesize pickerViewProvince;
@synthesize pickerViewTecnology;
@synthesize pickerElemsProvince ;
@synthesize pickerElemsTecnology;
@synthesize pkProvinces;
@synthesize txtSelectorProvince;
@synthesize labelTecnology;
@synthesize labelProvince;
@synthesize txtSelectorTecnology;
@synthesize labelCity;
@synthesize txtSelectorCity;
@synthesize activityIndicator;
@synthesize provinces;
@synthesize resultsDeveloperJSON;
@synthesize btnLoadListView;



-(void) loginViewDidFinish:(NSNotification*)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	NSDictionary *profile = [notification userInfo];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Selector";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iphonebackground.jpg"]];
    self.activityIndicator.hidden=TRUE;
    
    //Create picker to Province
    pickerViewProvince = [[UIPickerView alloc]init];
    pickerViewProvince.frame=CGRectMake(10, 75, 180,20);
    pickerViewProvince.delegate = self;
    pickerViewProvince.dataSource = self;
    pickerViewProvince.tag=2;
    pickerViewProvince.showsSelectionIndicator = YES;
    
    //Create picker to Tecnology
    pickerViewTecnology = [[UIPickerView alloc] init];
    pickerViewTecnology.frame=CGRectMake(10, 75, 180,20);
    pickerViewTecnology.delegate = self;
    pickerViewTecnology.tag=tagTecnology;
    pickerViewTecnology.dataSource = self;
    pickerViewTecnology.showsSelectionIndicator = YES;
    

    //Set data to pickers
    self.pickerElemsProvince = @[@"All",@"Buenos Aires F.D.",@"Buenos Aires", @"Catamarca", @"Chaco", @"Chubut", @"Cordoba" , @"Corrientes" , @"Entre Rios", @"Formosa", @"Jujuy", @"La Pampa", @"La Rioja", @"Mendoza", @"Misiones", @"Neuquen", @"Rio Negro", @"Salta", @"San Juan", @"San Luis", @"Santa Cruz", @"Santa Fe", @"Santiago del Estero", @"Tierra del Fuego", @"Tucuman"];
    
    
    self.pickerElemsTecnology = @[@"java", @"javascript", @"ios", @"android"];

    [self pickerView:pickerViewProvince didSelectRow:0 inComponent:0];
    [self pickerView:pickerViewTecnology didSelectRow:0 inComponent:0];
    
    //Dictonary to provinces and keys
    NSArray *pkProvinces=[@[@"",@"1",@"2", @"3", @"4", @"5", @"6" , @"7" , @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24"]retain];
    self.provinces = [NSDictionary dictionaryWithObjects:pkProvinces forKeys: self.pickerElemsProvince];
    
    //Create Toolbar
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.frame=CGRectMake(0,75,180,10);
    keyboardDoneButtonView.barStyle = UIBarStyleBlack;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //Create button "Done"
    UIBarButtonItem* doneButton = [[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(pickerDoneClicked:)] autorelease];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    
    //add a view with picker
    self.txtSelectorProvince.inputView = pickerViewProvince;
    self.txtSelectorTecnology.inputView = pickerViewTecnology;
    
    //add a Accessory with toolbar
    self.txtSelectorProvince.inputAccessoryView = keyboardDoneButtonView;
    self.txtSelectorTecnology.inputAccessoryView = keyboardDoneButtonView;
    
    self.txtSelectorProvince.tag= tagProvince;
    self.txtSelectorTecnology.tag = tagTecnology;
    self.txtSelectorCity.tag=tagCity;
    self.txtSelectorCity.enabled=FALSE;
    self.txtSelectorCity.backgroundColor=[UIColor lightGrayColor];
   oAuthLoginView = [[OAuthLoginView alloc] initWithNibName:nil bundle:nil];
    [oAuthLoginView retain];
    
    // register to be told when the login is finished
  /*  [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginViewDidFinish:)
                                                 name:@"loginViewDidFinish"
                                               object:oAuthLoginView];
    
    [self presentModalViewController:oAuthLoginView animated:YES];*/
   
    txtSelectorCity.delegate = self;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
   [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if(pickerView.tag==tagTecnology)
        return [self.pickerElemsTecnology count];
    
    return [self.pickerElemsProvince count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if(pickerView.tag==tagTecnology)
        return [self.pickerElemsTecnology objectAtIndex:row];
    
    return [self.pickerElemsProvince objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(pickerView.tag==tagTecnology){
        self.txtSelectorTecnology.text = [self.pickerElemsTecnology objectAtIndex:row];
    }
    else{
        self.txtSelectorProvince.text = [self.pickerElemsProvince objectAtIndex:row];
        //Disable-Enable option City
        if([self.txtSelectorProvince.text isEqualToString :@"All"]){
            self.txtSelectorCity.enabled=FALSE;
            self.txtSelectorCity.backgroundColor=[UIColor lightGrayColor];
            self.txtSelectorCity.text=@"All";
        }
        else{
            self.txtSelectorCity.enabled=TRUE;
            self.txtSelectorCity.backgroundColor=[UIColor whiteColor];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if(textField.tag==tagTecnology){
        [self.view addSubview:pickerViewTecnology];
    }
    else if(textField.tag==tagProvince){
        [self.view addSubview:pickerViewProvince];
    }
     
}

- (IBAction)pickerDoneClicked:(id)sender {
    
    [pickerViewProvince removeFromSuperview];
    [txtSelectorProvince resignFirstResponder];
    [pickerViewTecnology removeFromSuperview];
    [txtSelectorTecnology resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(txtSelectorCity.tag==tagCity)
        [txtSelectorCity resignFirstResponder];
    return YES;
}

-(NSArray *)existProvince{
    
    NSMutableArray *provincesSeleted=[[NSMutableArray alloc]init];
    for (id provinceResult in self.pickerElemsProvince){
        NSString *province=provinceResult;
        for (id developerResult in self.resultsDeveloperJSON){
            DeveloperModel *developer = developerResult;
            if([developer.province isEqualToString:province]){
                [provincesSeleted addObject:province];
                break;
            }
        }
    }
    return provincesSeleted;
}



- (IBAction)touchDown:(id)sender {
    
    self.activityIndicator.hidden=FALSE;
    [self.activityIndicator startAnimating];
    
    //Generate the path to request
    NSString *list=@"list/";
    NSString *tecnology=self.txtSelectorTecnology.text;
    NSString *city=self.txtSelectorCity.text;
    NSString *pkProvince= self.provinces[self.txtSelectorProvince.text];
    NSString *pk=@"/";
    NSString *empty=@"";
    NSString *path;
    
    //Path: xj: list/java
    if([pkProvince isEqualToString:empty]){
        path=[NSString stringWithFormat:@"%@%@%",list,tecnology];
    }
    //Path: xj: list/java/cordoba
    else{
        if([city isEqualToString:@"All"] || [city isEqualToString:@""]){
            path=[NSString stringWithFormat:@"%@%@%@%@%",list,tecnology,pk,pkProvince];
        }
        //Path: xj: list/java/cordoba/villa maria
        else{
            path=[NSString stringWithFormat:@"%@%@%@%@%@%@%",list,tecnology,pk,pkProvince, pk,city];
         }
    }
    NSMutableArray *results = [NSMutableArray array];
    NSDictionary *d1= @{
                        @"firstName" :  @"Esteban" ,
                        @"lastName" : @"Roodil" ,
                        @"company" : @"Devspark",
                        @"city" : @"Rosario" ,
                        @"province" : @"Entre Rios" ,
                        @"pictureUrl" : @"http://m.c.lnkd.licdn.com/mpr/mprx/0_9r8JGG3OmpMl-Jvn9nr6G8t1ayOgKJqnNtNQG88aAMoS7gi9s9Kzuhqhh-YC1Ozsc1CFDFtcxJTw" ,
                        @"publicProfileUrl" :@"http://www.linkedin.com/in/estebanrodil" ,
                        };
    NSDictionary *d2= @{
                        @"firstName" :  @"Facundo" ,
                        @"lastName" : @"Fumaneri" ,
                        @"company" : @"Devspark",
                        @"city" : @"Rosario" ,
                        @"province" : @"Entre Rios" ,
                        @"pictureUrl" : @"http://m.c.lnkd.licdn.com/mpr/mprx/0_OSEuUBVkcb9TW6m2yoH0UzHHv3Lfd5Y2pfY1Uqo4EXAO93Wutws8zNY9U75AECxh0metNPqZMX2m" ,
                        @"publicProfileUrl" :@"http://www.linkedin.com/pub/facundo-fumaneri/5/b11/70b" ,
                        };
    
    NSDictionary *d3= @{
                        @"firstName" :  @"Daniela" ,
                        @"lastName" : @"Sanchez" ,
                        @"company" : @"Devspark",
                        @"city" : @"Tandil" ,
                        @"province" : @"Buenos Aires" ,
                        @"pictureUrl" : @"http://m.c.lnkd.licdn.com/mpr/mprx/0_IdV5b2xkFSVkWe09deysb7d6bIxLImf9dSaVb7ZBZSwzqo4nbfoWdf2MW60VeWaVoo4UeH6H7m3O" ,
                        @"publicProfileUrl" :@"http://www.linkedin.com/pub/daniela-s%C3%A1nchez/b/779/27" ,
                        };
    
    NSDictionary *d4= @{
                        @"firstName" :  @"Jorge" ,
                        @"lastName" : @"Chiavaro" ,
                        @"company" : @"Devspark",
                        @"city" : @"Cordoba" ,
                        @"province" : @"Cordoba" ,
                        @"pictureUrl" : @"http://m.c.lnkd.licdn.com/mpr/mprx/0_ZPIPyQcCZNyfyLza41o8yXna4qEayQLaVA02yXkYFAY0_G-mqvRx-krK9sor0TXGMKdSP_9pHqto" ,
                        @"publicProfileUrl" :@"http://www.linkedin.com/in/jchiavaro" ,
                        };
    
    NSDictionary *d5= @{
                        @"firstName" :  @"Raul" ,
                        @"lastName" : @"Chiavaro" ,
                        @"company" : @"Devspark",
                        @"city" : @"Cordoba" ,
                        @"province" : @"Cordoba" ,
                        @"pictureUrl" : @"http://m.c.lnkd.licdn.com/mpr/mprx/0_ZPIPyQcCZNyfyLza41o8yXna4qEayQLaVA02yXkYFAY0_G-mqvRx-krK9sor0TXGMKdSP_9pHqto" ,
                        @"publicProfileUrl" :@"http://www.linkedin.com/in/jchiavaro" ,
                        };
    NSDictionary *d6= @{
                        @"firstName" :  @"Diego" ,
                        @"lastName" : @"Chiavaro" ,
                        @"company" : @"Devspark",
                        @"city" : @"Cordoba" ,
                        @"province" : @"Cordoba" ,
                        @"pictureUrl" : @"http://m.c.lnkd.licdn.com/mpr/mprx/0_ZPIPyQcCZNyfyLza41o8yXna4qEayQLaVA02yXkYFAY0_G-mqvRx-krK9sor0TXGMKdSP_9pHqto" ,
                        @"publicProfileUrl" :@"http://www.linkedin.com/in/jchiavaro" ,
                        };
    
    DeveloperModel *developer = [[DeveloperModel alloc] initWithDictionary:d1];
    [results addObject:developer];
    developer = [[DeveloperModel alloc] initWithDictionary:d2];
    [results addObject:developer];
    developer = [[DeveloperModel alloc] initWithDictionary:d3];
    [results addObject:developer];
    developer = [[DeveloperModel alloc] initWithDictionary:d4];
    [results addObject:developer];
    developer = [[DeveloperModel alloc] initWithDictionary:d5];
    [results addObject:developer];
    developer = [[DeveloperModel alloc] initWithDictionary:d6];
    [results addObject:developer];
       
    
    self.resultsDeveloperJSON=results;
    //If response has data
    if([results count]!=0){
        
        NSMutableArray *provincesSeleted=[self existProvince];
        UIViewController *listViewController=[[ListViewController alloc] initWithTitle:tecnology andCells:self.resultsDeveloperJSON andProvinces:provincesSeleted];
        
        
        //Allow the navigation to listView
        [self.navigationController pushViewController:listViewController animated:YES];
        self.activityIndicator.hidden=TRUE;
        [self.activityIndicator startAnimating];
    }
    //Show alert with message
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"No results were found for the search" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        self.activityIndicator.hidden=TRUE;
        [self.activityIndicator startAnimating];
    }

    
 /*   //Request list of Developer from server
    //-------------------------------------------------------------//
    self.activityIndicator.hidden=FALSE;
    [self.activityIndicator startAnimating];
    
    [[DeveloperClient sharedInstance] getPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"Response: %@", response);

        
        NSMutableArray *results = [NSMutableArray array];
        
        resultsDeveloperJSON=[NSMutableArray array];
        for (id developerDictionary in response) {
            DeveloperModel *developer = [[DeveloperModel alloc] initWithDictionary:developerDictionary];
            [results addObject:developer];
            [developer release];
        }
        resultsDeveloperJSON = results;
        //If response has data
        if([results count]!=0){
            
            NSMutableArray *provincesSeleted=[self existProvince];
            
            UIViewController *listViewController=[[ListViewController alloc] initWithTitle:tecnology andCells:self.resultsDeveloperJSON andProvinces:provincesSeleted];
            
            
            //Allow the navigation to listView
            [self.navigationController pushViewController:listViewController animated:YES];
            self.activityIndicator.hidden=TRUE;
            [self.activityIndicator startAnimating];
        }
        //Show alert with message
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"No results were found for the search" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            self.activityIndicator.hidden=TRUE;
            [self.activityIndicator startAnimating];
        }
    }
     //-------------------------------------------------------------//
     //Error in service response
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          NSLog(@"Error fetching developer!");
                                          NSLog(@"%@", error);
                                          self.activityIndicator.hidden=TRUE;
                                          [self.activityIndicator stopAnimating];
                                          
                                      }];*/
    
    
    
}
@end
