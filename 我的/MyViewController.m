//
//  MyViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/17.
//

#import <Masonry/Masonry.h>
#import "MyViewController.h"
#import "MyTopView.h"
#import "LoginViewController.h"
#import "SetViewController.h"

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) MyTopView *mytopView;
@property (nonatomic, strong) UITableView *myTableView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createSub];
    [self _installContraints];
    [self _iniliza];
}

- (void)_createSub {
    _mytopView = [[MyTopView alloc] init];
    [self.view addSubview:_mytopView];
    
    _myTableView = [[UITableView alloc] init];
    [self.view addSubview:_myTableView];
    
}

- (void)_iniliza {
    _mytopView.iconImage = [UIImage imageNamed:@"user_avatar_placeholder"];
    _mytopView.nameStr = @"点击登录";
    _mytopView.schoolStr = @"暂无数据";
    _mytopView.idStr = @"***";
    _mytopView.classStr = @"***";
    __weak typeof(self) weakSelf = self;
    _mytopView.nameBtnBlick = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [strongSelf.navigationController pushViewController:loginVC animated:YES];
    };
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [UIColor systemGray5Color];
}

- (void)_installContraints {
    [_mytopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.size.height.mas_equalTo(260);
    }];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mytopView.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

// MARK: UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *temView = [[UIView alloc] init];
    temView.backgroundColor = [UIColor systemGray5Color];
    return temView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor whiteColor];
    UIImageView *cellIconImageView = [[UIImageView alloc] init];
    [cell addSubview:cellIconImageView];
    [cellIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).with.offset(10);
        make.centerY.equalTo(cell.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [ cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).with.offset(40);
        make.centerY.equalTo(cell.mas_centerY);
        
    }];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"服务";
        cellIconImageView.image = [UIImage imageNamed:@"user_find_icon"];
    } else if (indexPath.section == 1){
        cell.textLabel.text = @"发现";
        cellIconImageView.image = [UIImage imageNamed:@"find_join_icon"];
    } else {
        cell.textLabel.text = @"设置";
        cellIconImageView.image = [UIImage imageNamed:@"user_setting_icon"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
       
    } else if (indexPath.section == 1){
        
    } else {
        SetViewController *setVC = [[SetViewController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
        
    }
}
@end
