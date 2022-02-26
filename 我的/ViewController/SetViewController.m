//
//  SetViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/23.
//

#import <Masonry/Masonry.h>
#import "SetViewController.h"
#import "AboutAutherViewController.h"

@interface SetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *setTableView;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self _createSub];
    [self _installContraints];
    [self _iniliza];
}

- (void)_createSub {
    _setTableView = [[UITableView alloc] init];
    [self.view addSubview:_setTableView];
}

- (void)_iniliza {
    _setTableView.delegate = self;
    _setTableView.dataSource = self;
    _setTableView.backgroundColor = [UIColor systemGray5Color];
    
}

- (void)_installContraints {
    [_setTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(120);
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
        return 1;
    } else {
        return 2;
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
    return  60;
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
        cell.textLabel.text = @"清除缓存";
        cellIconImageView.image = [UIImage imageNamed:@"setting_clear_icon"];
    } else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"关于校园通";
            cellIconImageView.image = [UIImage imageNamed:@"setting_info_icon"];
        } else {
            cell.textLabel.text = @"关于作者";
            cellIconImageView.image = [UIImage imageNamed:@"about_contact_icon"];
        }
       
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row ==1) {
        AboutAutherViewController *infoVC = [[AboutAutherViewController alloc] init];
        [self.navigationController pushViewController:infoVC animated:YES];
    }
}



@end
