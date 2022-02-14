//
//  AppDelegate.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/14.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    ViewController *v = [[ViewController alloc] init];
    UINavigationController *vc =
    [[UINavigationController alloc] initWithRootViewController:v];
    [self.window setRootViewController:vc];
    [self.window makeKeyAndVisible];
    return YES;
}
@end
