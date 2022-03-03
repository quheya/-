//
//  WelcomeViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/17.
//

#import "WelcomeViewController.h"
#import "MyMessageNormalUser.h"
#import "CheckViewController.h"
#import "AboutAutherViewController.h"
#import "InfoViewController.h"

@interface WelcomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UIImageView *topImageView;
@property (strong, nonatomic) MyMessageNormalUser *normalUserView;
@property (strong, nonatomic) UITableView *welcomeTableView;
@property (strong, nonatomic) NSArray *welcomeTitleArray;
@property (strong, nonatomic) NSArray *infoArray;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createSub];
    [self _installContraints];
    [self _iniliza];
}

- (void)_createSub {
    _topImageView = [[UIImageView alloc] init];
    [self.view addSubview:_topImageView];
    
    _normalUserView = [[MyMessageNormalUser alloc] init];
    [self.view addSubview:_normalUserView];
    [_normalUserView.payButton addTarget:self action:@selector(payButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [_normalUserView.sendButton addTarget:self action:@selector(sendButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [_normalUserView.receiveButton addTarget:self action:@selector(receiveButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [_normalUserView.commentButton addTarget:self action:@selector(commentButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [_normalUserView.moreOrderButton addTarget:self action:@selector(moreOrderButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [_normalUserView.afterSaleButton addTarget:self action:@selector(afterSaleButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _welcomeTableView = [[UITableView alloc] init];
    [self.view addSubview:_welcomeTableView];
    _welcomeTitleArray = [[NSArray alloc] init];
    _infoArray = [[NSArray alloc] init];
}

- (void)_iniliza {
    _topImageView.image = [UIImage imageNamed:@"welcomeTopIcon"];
    _welcomeTableView.delegate = self;
    _welcomeTableView.dataSource = self;
    _welcomeTableView.backgroundColor = [UIColor systemGray5Color];
    _welcomeTitleArray = @[@"新生报道", @"日常生活", @"寝室信息", @"关于学习"];
    _infoArray = @[
        @[@"必带证件", @"报道流程", @"新生建议",],
        @[@"食堂信息", @"日常出行", @"医药", @"快递信息"],
        @[@"床位大小", @"寝室位置", @"必需用品"],
        @[@"教室位置", @"注意事项", @"日常需要", @""]
    ];
}

- (void)_installContraints {
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(44);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.height.mas_equalTo(180);
    }];
    [_normalUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).with.offset(5);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.height.mas_equalTo(100);
    }];
    [_welcomeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.normalUserView.mas_bottom).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-80);
    }];
}
// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _infoArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *temArray = [[NSArray alloc] initWithArray:_infoArray[section]];
    return temArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *temView = [[UIView alloc] init];
    temView.backgroundColor = [UIColor systemGray5Color];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    titleLabel.text = _welcomeTitleArray[section];
    [temView addSubview:titleLabel];
    return temView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return  0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = _infoArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    infoVC.r = indexPath.row;
    infoVC.l = indexPath.section;
    [self.navigationController pushViewController:infoVC animated:YES];
}

// MARK: 点击方法

- (void) payButtonMethod {
    
}

- (void) sendButtonMethod {
    
}

- (void) receiveButtonMethod {
    CheckViewController *checkVC = [[CheckViewController alloc] init];
    [self.navigationController pushViewController:checkVC animated:YES];
}

- (void) commentButtonMethod {
  
}

- (void) moreOrderButtonMethod {
   
}

- (void) afterSaleButtonMethod {
    AboutAutherViewController *aboutAutherVC = [[AboutAutherViewController alloc] init];
    [self.navigationController pushViewController:aboutAutherVC animated:YES];
}

@end
