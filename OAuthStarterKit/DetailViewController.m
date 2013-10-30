//
//  DetailViewController.m
//

#import "DetailViewController.h"
#import "ContactViewController.h"


@implementation DetailViewController

@synthesize urlLinkedin;
@synthesize webView;
@synthesize activitityIndicator;

- (id)initWithTitle:(NSString*)aTitle andUrl:url
{
    if (self = [super init])
    {
        self.title= aTitle;
        self.urlLinkedin=url;
        
       UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Contact"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(contactDeveloper)];
        
        self.navigationItem.rightBarButtonItem = barButton;
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urlLinkedin]];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    [self loadProfileWebView];
   
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    self.activitityIndicator.hidden=FALSE;
    [self.activitityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.activitityIndicator.hidden=TRUE;
    [self.activitityIndicator stopAnimating];
}

- (void)loadProfileWebView
{
  
    NSURL * urlReq = [NSURL URLWithString:self.urlLinkedin];
    NSURLRequest *req = [NSURLRequest requestWithURL:urlReq];
    [self.webView loadRequest:req];
    
}

- (void)contactDeveloper
{
    //Create the navigation controller
    ContactViewController *contactViewController = [[ContactViewController alloc] initWithTitle:@"" andMail:@"and.ottonello@gmail.com" andPhone:@"15455845911"];
    
    //Init the view controller
    //Allow the navigation to detailView
    [self.navigationController pushViewController:contactViewController animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [super dealloc];
}
@end
