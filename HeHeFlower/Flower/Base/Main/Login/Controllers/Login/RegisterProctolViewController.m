//
//  RegisterProctolViewController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/28.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import "RegisterProctolViewController.h"
#import <WebKit/WebKit.h>
@interface RegisterProctolViewController ()<NavBarDelegate,UITableViewDataSource,UITableViewDelegate,WKUIDelegate,WKNavigationDelegate>{
    UITableView *_myTableView;
}
@property (nonatomic,strong) WKWebView *myWebView;
@end

@implementation RegisterProctolViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NavBar *navBar = [[NavBar alloc]initWithTitle:@"使用协议"];
    navBar.delegate = self;
    [self.view addSubview:navBar];
    
    self.tabBarController.tabBar.hidden = YES;
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH,MSHIGHT-NAVBAR_HEIGHT) style:UITableViewStyleGrouped];
    _myTableView.backgroundColor = BGC;
    _myTableView.bounces = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
}

#pragma mark - UITableView代理方法
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return MSHIGHT-NAVBAR_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"weiboCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    _myWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH, MSHIGHT-NAVBAR_HEIGHT)];
    _myWebView.navigationDelegate = self;
    _myWebView.UIDelegate = self;
    _myWebView.scrollView.bounces = NO;
    //获取当前页面的URL
    NSString *curURL = @"http://59.110.8.2/m/registAgreement.page";
    NSString  *currentURL = [curURL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DLOG(@"currentURL is %@",currentURL);
    
    if (currentURL != nil) {
        [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:currentURL] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:20]];
    }
    
    //_myWebView.scalesPageToFit = YES;;
    [cell.contentView addSubview:_myWebView];
    
    return cell;
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
    [DejalActivityView activityViewForView:self.view];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
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

#pragma mark ----- NavBar 代理方法
- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightItemClick{
    DLOG(@"下一步");
    
}

@end
