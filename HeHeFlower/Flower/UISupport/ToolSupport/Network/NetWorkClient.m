//
//  NetWorkClient.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "NetWorkClient.h"
#import "ShoveGeneralRestGateway.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface NetWorkClient ()

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation NetWorkClient

+ (instancetype)sharedInstance{
    
    static NetWorkClient *requestClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestClient = [[NetWorkClient alloc] init];
    });
    return requestClient;
}

- (instancetype)init
{
    if (    AppDelegateInstance.huanjiekou == 1) {
        self = [super initWithBaseURL:[NSURL URLWithString:@"http://39.104.15.35:8080"]];
    }else{
        self = [super initWithBaseURL:[NSURL URLWithString:Baseurl]];
    }
    if (self) {
        self.requestSerializer.timeoutInterval = 20;
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
    }
    return self;
}
//- (instancetype)init1
//{
//
//        self = [super initWithBaseURL:[NSURL URLWithString:@"http://39.104.15.35:8080"]];
//
//    if (self) {
//        self.
//        self.requestSerializer.timeoutInterval = 20;
//        self.requestSerializer = [AFJSONRequestSerializer serializer];
//        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
//    }
//    return self;
//}


- (NSURLSessionDataTask *) requestGet:(NSString *)URLString withParameters:(NSDictionary *)parameters
{
    NSString *restUrl = [ShoveGeneralRestGateway buildUrl:URLString key:MD5key parameters:parameters];
    
    DLOG(@"restUrl -> %@/%@", Baseurl, restUrl);
    if (![self isNetworkEnabled]) {
        //无可用网络
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:2.0];
        [SVProgressHUD setErrorImage:nil];
        [SVProgressHUD showErrorWithStatus:@"无可用网络"];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(networkError)]) {
            [self.delegate networkError];
        }
    }else
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(startRequest)]) {
            [self.delegate startRequest];
        }
        _dataTask = [self GET:restUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DLOG(@"[NetWorkClient] -> task.response==============\n%@\n====================", task.response);
            // 转码
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpResponseSuccess:dataTask:didSuccessWithObject:)]) {
                //移除loading指示器
                [DejalActivityView removeView];
                
                [self.delegate httpResponseSuccess:self dataTask:task didSuccessWithObject:responseObject];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //网络异常
            [DejalActivityView removeView];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
            [SVProgressHUD setMinimumDismissTimeInterval:2.0];
            [SVProgressHUD setErrorImage:nil];
            [SVProgressHUD showErrorWithStatus:@"网络异常"];
            //NSLog(@"error ==%@", [error userInfo][@"com.alamofire.error.serialization.string"]);
            NSLog(@"%ld",(long)error.code);
            
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(httpResponseSuccess:dataTask:didSuccessWithObject:)]) {
                [self.delegate httpResponseFailure:self dataTask:task didFailWithError:error];
            }
        }];
    }
    return _dataTask;
}

/**
 * block请求方式
 */
- (NSURLSessionDataTask *)requestParameters:(NSMutableDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSString *URLString = @"appController/receive";
    parameters[@"body"] = @"";
    NSString *restUrl = [ShoveGeneralRestGateway buildUrl:URLString key:MD5key parameters:parameters];
    
    DLOG(@"restUrl -> %@/%@", Baseurl, restUrl);
    
    _dataTask = [self GET:restUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // DLOG(@"[NetWorkClient] -> task.response==============\n%@\n====================", task.response);
        [DejalActivityView removeView];
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [DejalActivityView removeView];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
        [SVProgressHUD setMinimumDismissTimeInterval:2.0];
        [SVProgressHUD setErrorImage:nil];
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        // [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"networkError", nil)];
        failure(task, error);
    }];
    return _dataTask;
}


//-判断当前网络是否可用
-(BOOL) isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url = Baseurl;
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    return bEnabled;
}

-(void)cancel
{
    if (_dataTask != nil) {
        [_dataTask cancel];
    }
}

@end
