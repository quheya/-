//
//  NewsViewController.m
//  沈化大校园通
//
//  Created by quhe qu on 2022/3/2.
//

#import "NewsViewController.h"
@import WebKit;

@interface NewsViewController ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, copy) NSString *temUrl;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createSub];
    [self _installContraints];
    [self _iniliza];
}

- (void)_createSub {
    _webView = [[WKWebView alloc] init];
    [self.view addSubview:_webView];
}

- (void)_iniliza {
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:_temUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)_installContraints {
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(44);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
}

-(void)setUrlStr:(NSString *)urlStr {
    _temUrl = urlStr;
}

@end
