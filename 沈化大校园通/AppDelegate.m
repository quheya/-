//
//  AppDelegate.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/14.
//

//#import <IQKeyboardManager/IQKeyboardManager.h>
#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [[IQKeyboardManager sharedManager] setEnable:YES];
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    MainTabBarController *vc = [[MainTabBarController alloc] init];
    
    [self.window setRootViewController:vc];
    [self.window makeKeyAndVisible];
    return YES;
}
@end
