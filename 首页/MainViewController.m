//
//  MainViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/17.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    UITextField *tem = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, 100, 30)];
    [self.view addSubview:tem];
    tem.backgroundColor = [UIColor greenColor];
    [self _createSub];
    [self _installContraints];
    [self _iniliza];
}

- (void)_createSub {
   
}

- (void)_iniliza {
   
}

- (void)_installContraints {
    
}

@end
