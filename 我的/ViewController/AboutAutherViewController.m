//
//  AboutAutherViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/23.
//

#import <Masonry/Masonry.h>
#import "AboutAutherViewController.h"

@interface AboutAutherViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *infoTableView;
@property (nonatomic, strong) UIImageView *autherIconImageView;
@property (nonatomic, strong) UILabel *autherNameLabel;

@end

@implementation AboutAutherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self _createSub];
    [self _installContraints];
    [self _iniliza];
}

- (void)_createSub {
    _infoTableView = [[UITableView alloc] init];
    [self.view addSubview:_infoTableView];
    
    _autherIconImageView = [[UIImageView alloc] init];
    [self.view addSubview:_autherIconImageView];
    
    _autherNameLabel = [[UILabel alloc] init];
    [self.view addSubview:_autherNameLabel];
}

- (void)_iniliza {
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    _infoTableView.backgroundColor = [UIColor systemGray5Color];
    _autherIconImageView.image = [UIImage imageNamed:@"auther_avatar"];
    _autherIconImageView.layer.cornerRadius = 30;
    _autherIconImageView.clipsToBounds = YES;
    _autherNameLabel.text = @"传奇少年";
    _autherNameLabel.textAlignment = NSTextAlignmentCenter;
    _autherNameLabel.textColor = [UIColor blackColor];
    _autherNameLabel.backgroundColor = [UIColor whiteColor];
}

- (void)_installContraints {
    [_autherIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(100);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_autherNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_autherIconImageView.mas_bottom).with.offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 15));
    }];
    [_infoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(250);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

// MARK: UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 4;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *temView = [[UIView alloc] init];
    temView.backgroundColor = [UIColor systemGray5Color];
    return temView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  40;
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
        if (indexPath.row == 0) {
            cell.textLabel.text = @"技术博客";
            cellIconImageView.image = [UIImage imageNamed:@"auther_blog_icon"];
        } else {
            cell.textLabel.text = @"微博";
            cellIconImageView.image = [UIImage imageNamed:@"auther_weibo_icon"];
        }
       
    } else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"给APP提建议，联系他";
            cellIconImageView.image = [UIImage imageNamed:@"auther_contact_icon"];
        } else if (indexPath.row == 1){
            cell.textLabel.text = @"QQ:2893974956";
            cellIconImageView.image = [UIImage imageNamed:@"about_qq_icon"];
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"微信:quhe0426";
            cellIconImageView.image = [UIImage imageNamed:@"about_wechat_icon"];
        } else {
            cell.textLabel.text = @"邮箱:2893974956@qq.com";
            cellIconImageView.image = [UIImage imageNamed:@"auther_email_icon"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}



@end
