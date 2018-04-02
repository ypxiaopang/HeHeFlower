//
//  VersionUpdate.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "VersionUpdate.h"
#import "NetWorkClient.h"

@interface VersionUpdate ()<HTTPClientDelegate>{
    UIView *showView;
}

@property (nonatomic,strong) NetWorkClient *requestClient;
@property (nonatomic,assign) BOOL updateType;
@property (nonatomic,strong) NSString *_versionName;
@property (nonatomic,strong) NSString *content;
@end

@implementation VersionUpdate

+ (instancetype)sharedInstance{
    
    static VersionUpdate *_appUpdate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appUpdate = [[VersionUpdate alloc] init];
    });
    return _appUpdate;
}



#pragma mark - 检查更新方法
/**
 *  平台检查更新
 *
 *  @param delegate 检查更新代理
 */
- (void)checkUpdateWithDelegate:(id<VersionUpdateDelegate>)delegate
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"423" forKey:@"OPT"];
    [parameters setObject:@"1" forKey:@"deviceType"];
    [[NetWorkClient sharedInstance] requestParameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dics = responseObject;
        
        DLOG(@"平台检查更新--%@",dics);
        NSDictionary *records = dics[@"record"];
         if ([[NSString stringWithFormat:@"%@",dics[@"code"]] isEqualToString:@"1"]) {
            
            NSString *newVersion = [NSString stringWithFormat:@"%@", records[@"version_code"]];
             DLOG(@"23:%@", newVersion);
             _updateType = [records[@"promotion_type"]boolValue];
             _content = records[@"content"];
             __versionName = records[@"version_name"];
            
            if(delegate && [delegate respondsToSelector:@selector(checkAppVersion:updateType:updatecontent:updateName:)])
            {
                [delegate checkAppVersion:newVersion updateType:_updateType updatecontent:_content updateName:__versionName];
            }else{
                //结束进程，进入程序，直接根据更新类型相应弹提示
                [self compareVersion:newVersion updateType:_updateType updatecontent:_content updateName:__versionName];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLOG(@"检查更新失败");
    }];
}

/*通过itunes检查更新*/
- (void)appStoreCheckUpdate
{
    DLOG(@"itunes检查更新");
    
    NSString *apiUrl = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",AppleID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置请求超时时长
    //[manager.requestSerializer setTimeoutInterval:10];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:apiUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //DLOG(@"请求成功:%@", responseObject);
        
        if (responseObject) {
            
            NSDictionary *dics = responseObject;
            
            NSArray *resultsArr = dics[@"results"];
            
            if (resultsArr.count) {
                
                NSString *newVersion = resultsArr[0][@"version"];
                
                [self compareVersion:newVersion updateType:_updateType updatecontent:_content updateName:__versionName];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLOG(@"请求失败:%@", error);
        //如果请求超时，使用平台服务器请求
        if ([error code] == -1001) {
            [self checkUpdateWithDelegate:nil];
        }
    }];
}

/**
 *  APP版本号比较
 *
 *  @param newVersion    最新版本
 *  @param updateType    是否强制升级  0 否 1 是
 */
- (void)compareVersion:(NSString *)newVersion updateType:(BOOL)updateType updatecontent:(NSString *)updatecontent updateName:(NSString *)versionName{
   
    if (newVersion.length == 0) {
        return;
    }
    //当前版本
    NSString *currVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    int currVersionNum = [currVersion intValue];
    int newVersionNum = [newVersion intValue];
    DLOG(@"12:%d", currVersionNum);
    DLOG(@"23:%d", newVersionNum);
    //与最新版本作比较
    //NSComparisonResult result = [currVersion compare:newVersion];
    //如果小于发布版本，则提示更新
   
    if(currVersionNum < newVersionNum)
    {
         NSString *title = [NSString stringWithFormat:@"版本更新提示\n版本号：%@",versionName];
         NSString *newUpdatecontent = [updatecontent stringByReplacingOccurrencesOfString:@"<br>" withString:@"  \n"];
         DLOG(@"%@", newUpdatecontent);
         UIAlertController * alert = [UIAlertController alertControllerWithTitle:title  message:newUpdatecontent preferredStyle:UIAlertControllerStyleAlert];
        
        
        NSMutableAttributedString *hogan1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%@",newUpdatecontent]];
        [hogan1 addAttribute:NSFontAttributeName
                       value:[UIFont fontWithName:@"STHeitiSC-Light" size:17]
                       range:NSMakeRange(0, newUpdatecontent.length)];
        [alert setValue:hogan1 forKey:@"attributedMessage"];
         UIView *subView1 = alert.view.subviews[0];
         UIView *subView2 = subView1.subviews[0];
         UIView *subView3 = subView2.subviews[0];
         UIView *subView4 = subView3.subviews[0];
         UIView *subView5 = subView4.subviews[0];
         //取title和message：
         UILabel *message = subView5.subviews[1];
         message.textAlignment = NSTextAlignmentLeft;
        
        
         UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后提醒" style:UIAlertActionStyleCancel handler:nil];
         UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         DLOG(@"跳转 APP Store...");
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppDownloadURL]];
         }];
        if (updateType) {
            [alert addAction:certainAction];
        }else{
         [alert addAction:cancelAction];
         [alert addAction:certainAction];
        }
         UIViewController * rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
         [rootViewController presentViewController:alert animated:YES completion:^{
         
         }];

    }
}

@end
