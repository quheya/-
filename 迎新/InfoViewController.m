//
//  InfoViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/3/3.
//

#import "InfoViewController.h"

@interface InfoViewController ()
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) NSArray *infoArray;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemGray5Color];
    [self createSub];
    [self iniliza];
    [self allLayout];
}

- (void)createSub {
    _infoLabel = [[UILabel alloc] init];
    [self.view addSubview:_infoLabel];
    _infoArray = [[NSArray alloc] init];
}

- (void)iniliza {
    _infoLabel.backgroundColor = [UIColor whiteColor];
    _infoArray = @[
        @[@"1、录取通知书；\n2、学籍档案；\n3、党、团组织关系证明；\n4、身份证及正反两面复印件", @"", @"",],
        @[@"", @"", @"", @""],
        @[@"", @"", @"", @""],
        @[@"", @"", @"", @""]
    ];
}

- (void)allLayout {
    [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(150);
        make.right.equalTo(self.view.mas_right).with.offset(-50);
        make.left.equalTo(self.view.mas_left).with.offset(50);
        make.height.mas_equalTo(200);
    }];
}

-(void)setL:(NSInteger)l {
    _infoLabel.text = _infoArray[l][self.r];
}
@end
