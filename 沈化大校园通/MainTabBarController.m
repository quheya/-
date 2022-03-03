//
//  MainTabBarController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/17.
//

#import "MainTabBarController.h"
#import "MainViewController.h"
#import "InterViewController.h"
#import "WelcomeViewController.h"
#import "MyViewController.h"
#import "NavigationViewController.h"
#import "DBObject.h"
#import "TimeViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    TimeViewController *mainVc = [[TimeViewController alloc] init];
    mainVc.tabBarItem.title = @"主页";
    mainVc.tabBarItem.image = [UIImage imageNamed:@"bar_item_main"];
    mainVc.view.backgroundColor = [UIColor whiteColor];
    NavigationViewController *mainNav = [[NavigationViewController alloc] initWithRootViewController:mainVc];
    [self addChildViewController:mainNav];
    
    WelcomeViewController *welcomeVc = [[WelcomeViewController alloc] init];
    welcomeVc.tabBarItem.title = @"迎新";
    welcomeVc.tabBarItem.image = [UIImage imageNamed:@"bar_item_new"];
    welcomeVc.view.backgroundColor = [UIColor whiteColor];
    NavigationViewController *welcomeNav = [[NavigationViewController alloc] initWithRootViewController:welcomeVc];
    [self addChildViewController:welcomeNav];
    
    InterViewController *interVc = [[InterViewController alloc] init];
    interVc.tabBarItem.title = @"事务";
    interVc.tabBarItem.image = [UIImage imageNamed:@"bar_item_inter"];
    interVc.view.backgroundColor = [UIColor whiteColor];
    NavigationViewController *interNav = [[NavigationViewController alloc] initWithRootViewController:interVc];
    [self addChildViewController:interNav];
    
    MyViewController *myVc = [[MyViewController alloc] init];
    myVc.tabBarItem.title = @"我的";
    myVc.tabBarItem.image = [UIImage imageNamed:@"bar_item_user"];
    myVc.title = @"我的";
    myVc.view.backgroundColor = [UIColor whiteColor];
    NavigationViewController *myNav = [[NavigationViewController alloc] initWithRootViewController:myVc];
    [self addChildViewController:myNav];
    //----------------------------------------打开数据库并新建表--------------------------------------
    [[DBObject sharedInstance] addDatabaseAndTableMethod];
}

@end
