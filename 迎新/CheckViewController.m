//
//  CheckViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/3/3.
//

#import "CheckViewController.h"

@interface CheckViewController ()
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UIButton *checkButton;

@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemGray5Color];
    [self createSub];
    [self iniliza];
    [self allLayout];
}

- (void)createSub {
    _backView = [[UIView alloc] init];
    [self.view addSubview:_backView];
    
    _infoLabel = [[UILabel alloc] init];
    [self.view addSubview:_infoLabel];
    
    _checkButton = [[UIButton alloc] init];
    [self.view addSubview:_checkButton];
}

- (void)iniliza {
    _backView.backgroundColor = [UIColor whiteColor];
    [_checkButton setTitle:@"确认信息" forState:UIControlStateNormal];
    _checkButton.backgroundColor = [UIColor redColor];
    _checkButton.layer.cornerRadius = 12;
    _checkButton.clipsToBounds = YES;
    
}

- (void)allLayout {
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(150);
        make.right.equalTo(self.view.mas_right).with.offset(-50);
        make.left.equalTo(self.view.mas_left).with.offset(50);
        make.height.mas_equalTo(200);
    }];
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).with.offset(0);
        make.right.equalTo(self.backView.mas_right).with.offset(0);
        make.left.equalTo(self.backView.mas_left).with.offset(0);
        make.bottom.equalTo(self.backView.mas_bottom).with.offset(0);
    }];
    [_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).with.offset(20);
        make.right.equalTo(self.backView.mas_right).with.offset(-50);
        make.left.equalTo(self.backView.mas_left).with.offset(50);
        make.height.mas_equalTo(50);
    }];
}

@end
