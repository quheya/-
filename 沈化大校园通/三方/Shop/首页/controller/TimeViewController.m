//
//  TimeViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "TimeViewController.h"
#import "SDCycleScrollView.h"   //第三方轮播图

#import "SingleListModel.h" //新品列表模型
#import "MJExtension.h" //mj数据转模型
#import "ForumListModel.h"  //论坛列表model
#import "DBProduct.h"
#import "DBProductDetail.h"
#import "DBForum.h"
#import "SingleTableView.h" //展示列表
#import "TimeTwoBtnView.h"  //两个button的view
#import "DetailsViewController.h"   //商品详情页面
#import "SearchViewController.h"    //搜索页面
#import "ForumDetialViewController.h"   //帖子详情页
#import "NewsViewController.h"    //新闻跳转webView页

#import "SZKImagePickerVC.h"
#import "DBUser.h"


@interface TimeViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *mainScroll; //最底层滑动视图
@property (strong, nonatomic) SDCycleScrollView *headImageView;    //轮播图
@property (strong, nonatomic) TimeTwoBtnView *twoButtonView;    //中间切换列表按钮
@property (strong, nonatomic) SingleTableView *singleTable;  //单品团购
@property (strong, nonatomic) SingleTableView *forumTable;  //论坛


@property (strong, nonatomic) NSArray *singleModelArray;    //存放商品数据模型的数组
@property (strong, nonatomic) NSArray *forumModelArry;  //存放论坛数据模型的数组
@property (strong, nonatomic) NSArray *newsArray;  //新闻跳转链接



@end

@implementation TimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _newsArray = [[NSArray alloc] init];
    _newsArray = @[@"https://jiaowu.syuct.edu.cn/info/1085/2216.htm",
                   @"https://jiaowu.syuct.edu.cn/info/1085/2215.htm",
                   @"https://jiaowu.syuct.edu.cn/info/1085/2214.htm",
                   @"https://jiaowu.syuct.edu.cn/info/1085/2213.htm",
                   @"https://jiaowu.syuct.edu.cn/info/1085/1094.htm",
                   @"https://jiaowu.syuct.edu.cn/info/1085/1093.htm",
                   @"https://jiaowu.syuct.edu.cn/info/1085/1091.htm"];
    //设置背景色
    self.view.backgroundColor = MainColor;
    [self.view addSubview:self.mainScroll];
    [self.mainScroll addSubview:self.headImageView];
    
    //为了让twobutton形成吸附效果，所以把tableview放在了twobutton之上
    [self.mainScroll addSubview:self.singleTable];
    [self.mainScroll addSubview:self.forumTable];
    
    [self.mainScroll addSubview:self.twoButtonView];
    
    [self addSearchBtn];
    
    [self requestNew];
    [self requestForumData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.singleTable reloadData];
    [self loadViewIfNeeded];
    [self.forumTable reloadData];
}


//添加搜索按钮
- (void)addSearchBtn {
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"限时特卖界面搜索按钮"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 35, 35);
    [searchBtn addTarget:self action:@selector(pushSearchViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = navItem;
}


//搜索按钮的跳转事件
- (void) pushSearchViewController {
    SearchViewController *search = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}

- (UIScrollView *)mainScroll {
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 64 - 49)];
        _mainScroll.contentSize = CGSizeMake(0, 1980);  //滑动范围,以后想要修改限时购页面显示的商品个数，必须要修改这里
        _mainScroll.delegate = self;
    }
    return _mainScroll;
}

//监听、滑动的时候形成吸附效果，把twoButtonView吸附
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 230) { //滚动超过230
        CGRect rect = _twoButtonView.bounds;
        rect.origin.y = scrollView.contentOffset.y;
        _twoButtonView.frame = rect;
    }else {
        CGRect rect = _twoButtonView.bounds;
        rect.origin.y = 230;
        _twoButtonView.frame = rect;
    }
}

//请求轮播图数据
- (SDCycleScrollView *)headImageView {
    if (!_headImageView) {
        
        // 情景一：采用本地图片实现
        NSArray *imageNames = @[@"01.png",
                                @"02.png",
                                @"03.png",
                                @"04.png"// 本地图片请填写全名
                                ];
        // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        // 本地加载 --- 创建不带标题的图片轮播器
//        _headImageView =[[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 230)];
        _headImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 230) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
//        _headImageView.backgroundColor = [UIColor orangeColor];
        
        _headImageView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _headImageView.scrollDirection = UICollectionViewScrollDirectionVertical;
        //         --- 轮播时间间隔，默认1.0秒，可自定义
        //cycleScrollView.autoScrollTimeInterval = 4.0;
        
    }
    return _headImageView;
}


/**
 把缓存的plist中的数据存到模型之中 -- 商品列表的数据
 */
- (void) requestNew {
    
    //先把初始化的图片保存到沙盒中
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"01"] andImageNage:@"01"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"02"] andImageNage:@"02"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"03"] andImageNage:@"03"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"04"] andImageNage:@"04"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"05"] andImageNage:@"05"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"06"] andImageNage:@"06"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"07"] andImageNage:@"07"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"08"] andImageNage:@"08"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"09"] andImageNage:@"09"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"10"] andImageNage:@"10"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"11"] andImageNage:@"11"];
    [SZKImagePickerVC saveImageToSandbox:[UIImage imageNamed:@"12"] andImageNage:@"12"];
    
    //先在数据库中查询所有商品的数据，并保缓存到plist文件之中
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBProduct sharedInstance] insetProduct_Id:@"101" WithProduct_Name:@"抓云端教学契机 强一流教育品质" WithProduct_IconImage:[SZKImagePickerVC filePath:@"01"] WithProduct_CategoryID:@"学风" WithProduct_Price:@"" WithProduct_MarketPrice:@"2899" WithProduct_Description:@"岂曰无衣，与子同袍。面对突如其来的新冠肺炎疫情，沈阳化工大学全体教师用每一次充满热情的连接去温暖远方求知的学子；用每一滴满载知识的汗水去滋润渴望成长的心灵"];
    [[DBProduct sharedInstance] insetProduct_Id:@"102" WithProduct_Name:@"勇于担当做表率，管理育人重细节" WithProduct_IconImage:[SZKImagePickerVC filePath:@"02"] WithProduct_CategoryID:@"教育" WithProduct_Price:@"" WithProduct_MarketPrice:@"988" WithProduct_Description:@"疫情防控期间，教务处党支部积极组织实施在线教学工作，努力将“停课不停教、停课不停学”的各项工作落实落细，将基层党建和教师课程思政工作引向深入"];
    [[DBProduct sharedInstance] insetProduct_Id:@"103" WithProduct_Name:@"管理有态度 教学有深度 课堂有温度" WithProduct_IconImage:[SZKImagePickerVC filePath:@"03"] WithProduct_CategoryID:@"学风" WithProduct_Price:@"" WithProduct_MarketPrice:@"679" WithProduct_Description:@"为积极应对新冠肺炎疫情对传统课堂教学的影响，按照教育部总体部署要求和学校疫情防控工作的部署，教务处在学校党委领导下,统筹谋划、合理调整本科教学安排，积极组织实施在线教学工作，努力将“停课不停教、停课不停学”的各项工作落实落细"];
    [[DBProduct sharedInstance] insetProduct_Id:@"104" WithProduct_Name:@"我校举办线上教学管理工作专题培训会" WithProduct_IconImage:[SZKImagePickerVC filePath:@"04"] WithProduct_CategoryID:@"疫情" WithProduct_Price:@"" WithProduct_MarketPrice:@"1499" WithProduct_Description:@"在疫情防控的特殊时期，为了加强教学管理队伍建设，进一步提升基层教学管理人员的服务水平和业务管理能力，规范教学管理过程，促进教学工作深层次发展，更好服务于教师和学生，教务处于4月15日上午召开了线上教学管理工作专题培训会"];
    [[DBProduct sharedInstance] insetProduct_Id:@"105" WithProduct_Name:@"关于疫情防控期间本科教学工作安排的通知" WithProduct_IconImage:[SZKImagePickerVC filePath:@"05"] WithProduct_CategoryID:@"学风" WithProduct_Price:@"" WithProduct_MarketPrice:@"899" WithProduct_Description:@"按照教育部“停课不停教、停课不停学”的原则组织开展疫情防控期间本科教学工作，按照原定教学计划开展线上教学。通过学生主动学习、自主学习，教师线上教学、远程指导，做到教学不中断、学习不停顿，确保教学标准不缩水、教学质量不降低，完成学期教学任务"];
    [[DBProduct sharedInstance] insetProduct_Id:@"106" WithProduct_Name:@"众志成城 抗击疫情 努力学习 不负韶华" WithProduct_IconImage:[SZKImagePickerVC filePath:@"06"] WithProduct_CategoryID:@"学风" WithProduct_Price:@"" WithProduct_MarketPrice:@"389" WithProduct_Description:@"众志成城 抗击疫情 努力学习 不负韶华\n来自沈阳化工大学教务处的一封信"];
    [[DBProduct sharedInstance] insetProduct_Id:@"107" WithProduct_Name:@"积极应对疫情挑战 教务处组织线上教学" WithProduct_IconImage:[SZKImagePickerVC filePath:@"07"] WithProduct_CategoryID:@"疫情" WithProduct_Price:@"" WithProduct_MarketPrice:@"785" WithProduct_Description:@"自新型冠状病毒感染疫情发生以来，在教育部、省教育厅和学校的统一部署下，教务处高度重视疫情防控工作，立足岗位，积极应对疫情挑战，主动谋划2020年春季学期开学相关教学工作"];
    
    [[DBProduct sharedInstance] selectAllMethod];
    
    
    [[DBProductDetail sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBProductDetail sharedInstance] insetProduct_Id:@"101" WithBrand:@"LEGO/乐高" WithTitle:@"乐高机械组 42056 保时捷911GT3 RSLEGO Technic 积木玩具收藏" WithPrice:@"2899" WithMarketPrice:@"3499" WithPlace:@"中国" WithModel:@"42056" WithCategory:@"成人" WithAge:@"16岁+" WithTopImage1:[SZKImagePickerVC filePath:@"01"] WithTopImage2:[SZKImagePickerVC filePath:@"01"] WithTopImage3:[SZKImagePickerVC filePath:@"01"] WithTopImage4:[SZKImagePickerVC filePath:@"01"] WithDetailImage1:[SZKImagePickerVC filePath:@"01"] WithDetailImage2:[SZKImagePickerVC filePath:@"01"] WithDetailImage3:[SZKImagePickerVC filePath:@"01"] WithDetailImage4:[SZKImagePickerVC filePath:@"01"]];
    [[DBProductDetail sharedInstance] insetProduct_Id:@"102" WithBrand:@"LEGO/乐高" WithTitle:@"乐高星球大战系列75192 豪华千年隼 LEGO积木玩具" WithPrice:@"988" WithMarketPrice:@"1088" WithPlace:@"中国台湾" WithModel:@"75192" WithCategory:@"儿童" WithAge:@"10岁-14岁" WithTopImage1:[SZKImagePickerVC filePath:@"02"] WithTopImage2:[SZKImagePickerVC filePath:@"02"] WithTopImage3:[SZKImagePickerVC filePath:@"02"] WithTopImage4:[SZKImagePickerVC filePath:@"02"] WithDetailImage1:[SZKImagePickerVC filePath:@"02"] WithDetailImage2:[SZKImagePickerVC filePath:@"02"] WithDetailImage3:[SZKImagePickerVC filePath:@"02"] WithDetailImage4:[SZKImagePickerVC filePath:@"02"]];
    [[DBProductDetail sharedInstance] insetProduct_Id:@"103" WithBrand:@"LEGO/乐高" WithTitle:@"乐高机械组 42068 机场救援车 LEGO Technical 积木玩具收藏" WithPrice:@"679" WithMarketPrice:@"759" WithPlace:@"越南" WithModel:@"42068" WithCategory:@"儿童" WithAge:@"10岁-14岁" WithTopImage1:[SZKImagePickerVC filePath:@"03"] WithTopImage2:[SZKImagePickerVC filePath:@"03"] WithTopImage3:[SZKImagePickerVC filePath:@"03"] WithTopImage4:[SZKImagePickerVC filePath:@"03"] WithDetailImage1:[SZKImagePickerVC filePath:@"03"] WithDetailImage2:[SZKImagePickerVC filePath:@"03"] WithDetailImage3:[SZKImagePickerVC filePath:@"03"] WithDetailImage4:[SZKImagePickerVC filePath:@"03"]];
    [[DBProductDetail sharedInstance] insetProduct_Id:@"104" WithBrand:@"LEGO/乐高" WithTitle:@"乐高机械组 420878 马克卡车MSCK An Them LEGO TECHNIC" WithPrice:@"1499" WithMarketPrice:@"1699" WithPlace:@"中国大陆" WithModel:@"42078" WithCategory:@"学龄前儿童" WithAge:@"0岁-4岁" WithTopImage1:[SZKImagePickerVC filePath:@"04"] WithTopImage2:[SZKImagePickerVC filePath:@"04"] WithTopImage3:[SZKImagePickerVC filePath:@"04"] WithTopImage4:[SZKImagePickerVC filePath:@"04"] WithDetailImage1:[SZKImagePickerVC filePath:@"04"] WithDetailImage2:[SZKImagePickerVC filePath:@"04"] WithDetailImage3:[SZKImagePickerVC filePath:@"04"] WithDetailImage4:[SZKImagePickerVC filePath:@"04"]];
    [[DBProductDetail sharedInstance] insetProduct_Id:@"105" WithBrand:@"LEGO/乐高" WithTitle:@"LEGO乐高 60138 城市警察总局 拼接积木 益智玩具" WithPrice:@"899" WithMarketPrice:@"1099" WithPlace:@"美国" WithModel:@"60138" WithCategory:@"城市" WithAge:@"5岁-12岁" WithTopImage1:[SZKImagePickerVC filePath:@"05"] WithTopImage2:[SZKImagePickerVC filePath:@"05"] WithTopImage3:[SZKImagePickerVC filePath:@"05"] WithTopImage4:[SZKImagePickerVC filePath:@"05"] WithDetailImage1:[SZKImagePickerVC filePath:@"05"] WithDetailImage2:[SZKImagePickerVC filePath:@"05"] WithDetailImage3:[SZKImagePickerVC filePath:@"05"] WithDetailImage4:[SZKImagePickerVC filePath:@"05"]];
    [[DBProductDetail sharedInstance] insetProduct_Id:@"106" WithBrand:@"LEGO/乐高" WithTitle:@"LEGO乐高 建筑系列21033 芝加哥 成人粉丝拼装建筑积木玩具收藏" WithPrice:@"389" WithMarketPrice:@"599" WithPlace:@"英国" WithModel:@"21033" WithCategory:@"建筑" WithAge:@"12岁-14岁" WithTopImage1:[SZKImagePickerVC filePath:@"06"] WithTopImage2:[SZKImagePickerVC filePath:@"06"] WithTopImage3:[SZKImagePickerVC filePath:@"06"] WithTopImage4:[SZKImagePickerVC filePath:@"06"] WithDetailImage1:[SZKImagePickerVC filePath:@"06"] WithDetailImage2:[SZKImagePickerVC filePath:@"06"] WithDetailImage3:[SZKImagePickerVC filePath:@"06"] WithDetailImage4:[SZKImagePickerVC filePath:@"06"]];
    [[DBProductDetail sharedInstance] insetProduct_Id:@"107" WithBrand:@"LEGO/乐高" WithTitle:@"LEGO乐高 创意百变高手系列 10259 冬季村庄车站 拼插积木玩具" WithPrice:@"785" WithMarketPrice:@"799" WithPlace:@"日本" WithModel:@"10259" WithCategory:@"创意" WithAge:@"12岁-14岁" WithTopImage1:[SZKImagePickerVC filePath:@"07"] WithTopImage2:[SZKImagePickerVC filePath:@"07"] WithTopImage3:[SZKImagePickerVC filePath:@"07"] WithTopImage4:[SZKImagePickerVC filePath:@"07"] WithDetailImage1:[SZKImagePickerVC filePath:@"07"] WithDetailImage2:[SZKImagePickerVC filePath:@"07"] WithDetailImage3:[SZKImagePickerVC filePath:@"07"] WithDetailImage4:[SZKImagePickerVC filePath:@"07"]];
    
    
    [[DBProductDetail sharedInstance] selectAllMethod];
    
    [[DBUser sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBUser sharedInstance] insetUser_Name:@"1000000001" WithUser_PassWord:@"111111" WithUser_Type:@"管理员"];
    [[DBUser sharedInstance] insetUser_Name:@"1816050307" WithUser_PassWord:@"eeeeee" WithUser_Type:@"普通用户"];
    [[DBUser sharedInstance] insetUser_Info:@"1816050307" WithUser_school:@"沈阳化工大学" WithUser_class:@"计算机1803班" WithUser_realname:@"曲贺"];
    
    
    //把plist中的数据保存到模型中
    self.singleModelArray = [SingleListModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProduct"]];
    self.singleTable.singleModelArray = self.singleModelArray;
    Log(@"singleModelArray---%@",self.singleModelArray);
    //改变tableview1的高度
    CGRect tableViewRect = _singleTable.frame;
    tableViewRect.size.height = _singleModelArray.count * 170;
    _singleTable.frame = tableViewRect;
    
    //改变mainscroll的滑动范围
    if (_twoButtonView.button1.selected) {
        _mainScroll.contentSize = CGSizeMake(0, _singleModelArray.count * 170 + 280);
    }

    [_singleTable reloadData];   //刷新列表
}


/**
 把缓存的plist中的数据存到模型之中 -- 论坛列表的数据
 */
- (void) requestForumData {
    
    
    //先在数据库中查询所有商品的数据，并保缓存到plist文件之中
    [[DBForum sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBForum sharedInstance] insetForum_Title:@"啥时候开学呀" WithForum_Text:@"童年时代的美丽梦想，会在长大后开花结果呦~所以，友谊和快乐一定最适合小公主们。上天探险，拯救猴子，小英雄们的梦想，乐高来帮你实现" WithForum_Image1:[SZKImagePickerVC filePath:@"01"] WithForum_Image2:[SZKImagePickerVC filePath:@"05"]];
    [[DBForum sharedInstance] insetForum_Title:@"二食堂能不能降价，孩子吃不起了" WithForum_Text:@"童年时代的美丽梦想，会在长大后开花结果呦~所以，友谊和快乐一定最适合小公主们。上天探险，拯救猴子，小英雄们的梦想，乐高来帮你实现" WithForum_Image1:[SZKImagePickerVC filePath:@"09"] WithForum_Image2:[SZKImagePickerVC filePath:@"10"]];
    [[DBForum sharedInstance] insetForum_Title:@"新篮球场修好了吗" WithForum_Text:@"童年时代的美丽梦想，会在长大后开花结果呦~所以，友谊和快乐一定最适合小公主们。上天探险，拯救猴子，小英雄们的梦想，乐高来帮你实现" WithForum_Image1:[SZKImagePickerVC filePath:@"08"] WithForum_Image2:[SZKImagePickerVC filePath:@""]];
    [[DBForum sharedInstance] insetForum_Title:@"分享化大美景" WithForum_Text:@"童年时代的美丽梦想，会在长大后开花结果呦~所以，友谊和快乐一定最适合小公主们。上天探险，拯救猴子，小英雄们的梦想，乐高来帮你实现" WithForum_Image1:[SZKImagePickerVC filePath:@"11"] WithForum_Image2:[SZKImagePickerVC filePath:@"12"]];
    [[DBForum sharedInstance] selectAllMethod];
    
    
    self.forumModelArry = [ForumListModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryForum"]];
    _forumTable.forumModelArry = self.forumModelArry;
//    Log(@"forumModelArry---%@",self.forumModelArry);
    
    
    
    
    
    //改变tableview2的高度
    CGRect tableViewRect = _forumTable.frame;
    tableViewRect.size.height = _forumModelArry.count * 200;
    _forumTable.frame = tableViewRect;
    
    //改变mainscroll的滑动范围
    if (_twoButtonView.button2.selected) {
        _mainScroll.contentSize = CGSizeMake(0, _forumModelArry.count * 200 + 280);
    }
    
    [_forumTable reloadData];   //刷新列表
}


- (TimeTwoBtnView *)twoButtonView {
    if (!_twoButtonView) {
        _twoButtonView = [[TimeTwoBtnView alloc] initWithFrame:CGRectMake(0, 230, VIEW_WIDTH, 50)];
        _twoButtonView.backgroundColor = [UIColor whiteColor];
        [_twoButtonView.button1 addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
        [_twoButtonView.button2 addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoButtonView;
}



//切换view的方法--简言之就是改变两个tableview的x值，让另外一个X的值为屏幕的宽
- (void) changeTableFrame:(UIButton *) button {
    
    if (button == _twoButtonView.button1) {
        
        button.selected = YES;
        _twoButtonView.button2.selected = NO;
        
        //添加一个切换view的动画
        [UIView animateWithDuration:0.5 animations:^{
            CGRect tableRect1 = self.singleTable.frame;
            tableRect1.origin.x = 0;
            self.singleTable.frame = tableRect1;
            
            CGRect tableRect2 = self.forumTable.frame;
            tableRect2.origin.x = VIEW_WIDTH;
            self.forumTable.frame = tableRect2;
            self.mainScroll.contentSize = CGSizeMake(0, self.singleModelArray.count * 170 + 280);
        }];
    }else {
        
        button.selected = YES;
        _twoButtonView.button1.selected = NO;
        
        //添加一个切换view的动画
        [UIView animateWithDuration:0.5 animations:^{
            CGRect tableRect1 = self.singleTable.frame;
            tableRect1.origin.x = -VIEW_WIDTH;
            self.singleTable.frame = tableRect1;
            
            CGRect tableRect2 = self.forumTable.frame;
            tableRect2.origin.x = 0;
            self.forumTable.frame = tableRect2;
            self.mainScroll.contentSize = CGSizeMake(0, self.forumModelArry.count * 200 + 280);
        }];
    }
    
}

- (SingleTableView *)singleTable {
    if (!_singleTable) {
        _singleTable = [[SingleTableView alloc] initWithFrame:CGRectMake(0, 280, VIEW_WIDTH, 1700) style:UITableViewStylePlain]; //以后想要修改限时购页面显示的商品个数，必须要修改这里
        _singleTable.bounces = NO;
        _singleTable.isSingle = YES;
        
        __weak typeof (self) weakSelf = self;
        _singleTable.productIDBlock = ^(NSString *productID){
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NewsViewController *newVC = [[NewsViewController alloc] init];
            int temNum = [productID intValue];
            newVC.urlStr = strongSelf.newsArray[temNum - 101];
            [strongSelf.navigationController pushViewController:newVC animated:YES];
        };
    }
    return _singleTable;
}

- (SingleTableView *)forumTable {
    if (!_forumTable) {
        _forumTable = [[SingleTableView alloc] initWithFrame:CGRectMake(VIEW_WIDTH, 280, VIEW_WIDTH, 1700) style:UITableViewStylePlain]; //以后想要修改限时购页面显示的商品个数，必须要修改这里.暂时性先把x设置成屏幕的宽，这样就让tableView2显示在屏幕之外了
        _forumTable.bounces = NO;
        _forumTable.isSingle = NO;
        
        __weak typeof (self) weakSelf = self;
        _forumTable.forumIDBlock = ^(NSString *forumID){
            ForumDetialViewController *details = [[ForumDetialViewController alloc] init];
            details.DetailsForumId = forumID;
            details.title = @"拥有乐高，开启欢乐模式";
            [weakSelf.navigationController pushViewController:details animated:YES];
            Log(@"forumID : %@",forumID);
        };
    }
    return _forumTable;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
