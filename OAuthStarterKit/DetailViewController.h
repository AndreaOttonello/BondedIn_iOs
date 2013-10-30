//
//  DetailViewController.h
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController <UIWebViewDelegate,  MFMailComposeViewControllerDelegate>

@property (retain) NSString *urlLinkedin;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activitityIndicator;
@property (retain, nonatomic) IBOutlet UIWebView *webView;

- (id)initWithTitle:(NSString*)aTitle andUrl:url;
- (void)loadProfileWebView;
- (void)contactDeveloper;


@end


