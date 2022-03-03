//
//  InterViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/2/17.
//

#import "InterViewController.h"
#import "interCellCollectionViewCell.h"

@interface InterViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UIImageView *topImageView;
@property (strong, nonatomic) UICollectionView *collectiveView;
@property (strong, nonatomic) NSArray *sectionArray;
@property (strong, nonatomic) NSArray *rowArray;
 
@end

@implementation InterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createSub];
    [self _installContraints];
    [self _iniliza];
}

- (void)_createSub {
    _sectionArray = [[NSArray alloc] init];
    _rowArray = [[NSArray alloc] init];
    _topImageView = [[UIImageView alloc] init];
    [self.view addSubview:_topImageView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 3-5, [UIScreen mainScreen].bounds.size.width / 3-5);
    _collectiveView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 224, [UIScreen mainScreen].bounds.size.width-10, [UIScreen mainScreen].bounds.size.height-300) collectionViewLayout:layout];
    [_collectiveView registerClass:[interCellCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:_collectiveView];
}

- (void)_iniliza {
    _sectionArray = @[@"", @""];
    _rowArray = @[
        @[@"", @"", @"",],
        @[@"", @"", @"", @""]
    ];
    _topImageView.image = [UIImage imageNamed:@"interIcon"];
    _collectiveView.backgroundColor = [UIColor systemGray5Color];
    _collectiveView.delegate = self;
    _collectiveView.dataSource = self;
    [_collectiveView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
}

- (void)_installContraints {
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(44);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.height.mas_equalTo(180);
    }];
}
// MARK: UICollectionViewDelegate, UICollectionViewDataSource
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={110,40};
    return size;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 3, 100, 30)];
        headerLabel.textColor = [UIColor grayColor];
        headerLabel.text = @"办公";
        [header addSubview:headerLabel];
        reusableView = header;
    }
    return  reusableView;
}


//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   interCellCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.temStr = @"办事大厅";
    cell.temImage = [UIImage imageNamed:@"info_rate_icon"];
    return cell;
}


@end
