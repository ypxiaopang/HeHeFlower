//
//  MyWebViewController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//
//展示webView

#import "MyWebViewController.h"
#import <WebKit/WebKit.h>
@interface MyWebViewController ()<WKNavigationDelegate,WKUIDelegate,NavBarDelegate>
{
    WKWebView *_myWebView;
    UIActivityIndicatorView *_activityIndicatorView;
}

@end
@implementation MyWebViewController

#pragma mark - 视图控制器生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
}

#pragma mark - 视图初始化方法
- (void)initView{
    NavBar *navBar = [[NavBar alloc]initWithTitle:self.title];
    navBar.delegate = self;
    [self.view addSubview:navBar];
    
    _myWebView = [[WKWebView alloc] initWithFrame:MYTABLEVIEW_FRAME];
    _myWebView.backgroundColor = BGC;
    _myWebView.UIDelegate = self;
    _myWebView.navigationDelegate = self;
    //_myWebView.scalesPageToFit = YES;
    [self.view addSubview:_myWebView];
    
    if (_isLoadRequest) {
        //如果传来的是网址，则调用此方法
        [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.html] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10]];
        
    }else
    {
        //适配屏幕宽度
        NSString *str = @"<meta name='viewport' content = 'user-scalable=yes, width=device-width,initial-scale=1'/><style type=text/css>img{max-width: 100%;}</style><body>";
        
        self.html = [NSString stringWithFormat:@"%@%@</body>",str,self.html];
        
        [_myWebView loadHTMLString:self.html baseURL:[NSURL URLWithString:Baseurl]];
    }
}

#pragma mark - WKwebView 代理方法
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
    }
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [DejalActivityView activityViewForView:_myWebView];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    [DejalActivityView removeView];
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [DejalActivityView removeView];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [DejalActivityView removeView];
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [_myWebView.configuration.userContentController removeAllUserScripts];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (version.doubleValue >= 9.0) {
        // 针对 9.0 以上的iOS系统进行处理
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                         completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             for (WKWebsiteDataRecord *record  in records)
                             {
                                 //                             if ( [record.displayName containsString:@"baidu"]) //取消备注，可以针对某域名清除，否则是全清
                                 //                             {
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                                                           forDataRecords:@[record]
                                                                        completionHandler:^{
                                                                            NSLog(@"Cookies for %@ deleted successfully",record.displayName);
                                                                        }];
                                 //                             }
                             }
                         }];
    } else {
        // 针对 9.0 以下的iOS系统进行处理
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
    
}



#pragma mark - NavBar 代理方法
- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightItemClick{
    DLOG(@"下一步");
}



@end
