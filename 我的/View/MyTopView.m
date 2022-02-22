//
//  MyTopView.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/18.
//

#import <Masonry/Masonry.h>
#import "MyTopView.h"

@interface  MyTopView() {
    UIView *_topView;
    UIImageView *_iconImageView;
    UIView *_lineView;
    UIButton *_nameButton;
    UILabel *_idLabel;
    UILabel *_classLabel;
    UILabel *_schoolLabel;
    UIView *_hlineView;
}

@end

@implementation MyTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    [self _createSub];
    [self _installContraints];
    [self _iniliza];
    return self;
}

- (void)_createSub {
    _topView = [[UIView alloc] init];
    [self addSubview:_topView];
    
    _iconImageView = [[UIImageView alloc] init];
    [_topView addSubview:_iconImageView];
    
    _nameButton = [[UIButton alloc] init];
    [_topView addSubview:_nameButton];
    
    _lineView = [[UIView alloc] init];
    [_topView addSubview:_lineView];
    
    _schoolLabel = [[UILabel alloc] init];
    [_topView addSubview:_schoolLabel];
    
    _hlineView = [[UIView alloc] init];
    [self addSubview:_hlineView];
    
    _idLabel = [[UILabel alloc] init];
    [self addSubview:_idLabel];

    _classLabel = [[UILabel alloc] init];
    [self addSubview:_classLabel];
}

- (void)_iniliza {
    _topView.backgroundColor = [UIColor systemBlueColor];
    _iconImageView.layer.cornerRadius = 40;
    _iconImageView.layer.masksToBounds = YES;
    _nameButton.titleLabel.textColor = [UIColor whiteColor];
    _nameButton.backgroundColor = [UIColor clearColor];
    _nameButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _lineView.backgroundColor = [UIColor whiteColor];
    _schoolLabel.backgroundColor = [UIColor clearColor];
    _schoolLabel.textColor = [UIColor whiteColor];
    _hlineView.backgroundColor = [UIColor grayColor];
}

- (void)_installContraints {
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(80);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom).with.offset(-60);
    }];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top).with.offset(20);
        make.left.equalTo(_topView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top).with.offset(20);
        make.left.equalTo(_topView.mas_left).with.offset(120);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top).with.offset(60);
        make.left.equalTo(_topView.mas_left).with.offset(120);
        make.right.equalTo(_topView.mas_right).with.offset(-20);
        make.size.height.mas_equalTo(@1);
    }];
    [_schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top).with.offset(70);
        make.left.equalTo(_topView.mas_left).with.offset(120);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [_hlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
        make.centerX.equalTo(self.mas_centerX);
        make.size.width.mas_equalTo(@1);
    }];
    
    //CGRectGetWidth(self.frame)
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).with.offset(30);
        make.left.equalTo(self.mas_left).with.offset( [UIScreen mainScreen].bounds.size.width / 6);
        make.height.mas_equalTo(10);
    }];
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_bottom).with.offset(30);
        make.left.equalTo(_hlineView.mas_left).with.offset([UIScreen mainScreen].bounds.size.width / 6);
        make.height.mas_equalTo(10);
    }];
}

//MARK: --Set

-(void)setIconImage:(UIImage *)iconImage {
    _iconImageView.image = iconImage;
}

-(void)setNameStr:(NSString *)nameStr {
    [_nameButton setTitle:nameStr forState:UIControlStateNormal];
}

-(void)setSchoolStr:(NSString *)schoolStr {
    _schoolLabel.text = schoolStr;
}

- (void)setIdStr:(NSString *)idStr {
    _idLabel.text = idStr;
}

-(void)setClassStr:(NSString *)classStr {
    _classLabel.text = classStr;
}

@end
