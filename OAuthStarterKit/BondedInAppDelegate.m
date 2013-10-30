//
//BondedIn
//

#import "BondedInAppDelegate.h"
#import "HomeTabView.h"
#import "OAuthLoginView.h"

@implementation BondedInAppDelegate


@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    HomeTabView *profileViewController = [[HomeTabView alloc] initWithNibName:nil bundle:nil];
    
    //Create the navigation controller
    UINavigationController *navigationViewController= [[UINavigationController alloc]initWithRootViewController:profileViewController];
    
    //Init the view controller
    [self.window setRootViewController : navigationViewController];
    [self.window makeKeyAndVisible];
    return YES;
    
}




- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)dealloc
{
   [super dealloc];
}

@end
