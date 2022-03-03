//
//  interCellCollectionViewCell.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/3/2.
//

#import "interCellCollectionViewCell.h"

@interface interCellCollectionViewCell()
{
    float selfW;
  
}
@property (strong, nonatomic) UIImageView *cellIcon;
@property (strong, nonatomic) UILabel *cellLabel;


@end

@implementation interCellCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        selfW = frame.size.width;
        [self createSub];
        [self initiza];
        [self allLayout];
    }
    return self;
}

- (void)createSub {
    _cellIcon = [[UIImageView alloc] init];
    [self addSubview:_cellIcon];
    
    _cellLabel = [[UILabel alloc] init];
    [self addSubview:_cellLabel];
}

- (void)initiza {
    [_cellLabel sizeToFit];
}

-(void)allLayout {
    [_cellIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(selfW / 4);
        make.size.mas_equalTo(CGSizeMake(selfW / 3, selfW / 3));
    }];
    [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.cellIcon.mas_bottom).with.offset(10);
    }];
}

// MARK: set get
- (void)setTemImage:(UIImage *)temImage {
    _cellIcon.image = temImage;
}

- (void)setTemStr:(NSString *)temStr {
    _cellLabel.text = temStr;
}
@end
