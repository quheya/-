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

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    MainViewController *mainVc = [[MainViewController alloc] init];
    mainVc.tabBarItem.title = @"主页";
    mainVc.tabBarItem.image = [UIImage imageNamed:@"bar_item_main"];
    mainVc.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:mainVc];
    
    WelcomeViewController *welcomeVc = [[WelcomeViewController alloc] init];
    welcomeVc.tabBarItem.title = @"迎新";
    welcomeVc.tabBarItem.image = [UIImage imageNamed:@"bar_item_new"];
    welcomeVc.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:welcomeVc];
    
    InterViewController *interVc = [[InterViewController alloc] init];
    interVc.tabBarItem.title = @"互动";
    interVc.tabBarItem.image = [UIImage imageNamed:@"bar_item_inter"];
    interVc.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:interVc];
    
    MyViewController *myVc = [[MyViewController alloc] init];
    myVc.tabBarItem.title = @"我的";
    myVc.tabBarItem.image = [UIImage imageNamed:@"bar_item_user"];
    myVc.title = @"我的";
    myVc.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:myVc];
}

@end
