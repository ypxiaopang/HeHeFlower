//
//  AppDelegate.m
//  Flower
//
//  Created by Apple on 2018/1/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#define kLockTime 300.0

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "GuideViewController.h"
#import "LoginViewController.h"
#import "MyNavigationController.h"
#import "VersionUpdate.h"
//#import <UMSocialCore/UMSocialCore.h>
//#import "UMSocialWechatHandler.h"
//#import <UShareUI/UShareUI.h>

@interface AppDelegate ()<VersionUpdateDelegate,HTTPClientDelegate>{
    NSInteger typeNum;
}

@property (nonatomic,copy)NSDate *leaveDate;
@property (nonatomic,copy)NSDate *backDate;
@property (nonatomic,retain)NSTimer *myTimer;

@end

@implementation AppDelegate
-(BOOL)prefersStatusBarHidden

{
    
    return YES;// 返回YES表示隐藏，返回NO表示显示
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NetWorkClient sharedInstance].delegate = self;
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    //***************通知发送许可
    //***************通知发送许可
    //***************通知发送许可
    //***************通知发送许可
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
//    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    
    self.isHomeUpdate = NO;
    
    self.isFromMinePage = NO;//从我的页面而来。
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc] init];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH,MSHIGHT)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH, MSHIGHT)];
    if (MSWIDTH==320) {
        if(MSHIGHT == 480){
            imageView.image = [UIImage imageNamed:@"320-1.png"];
        }else{
            imageView.image = [UIImage imageNamed:@"320.png"];
        }
    }else if(MSWIDTH == 375){
        imageView.image = [UIImage imageNamed:@"375.png"];
    }else{
        imageView.image = [UIImage imageNamed:@"414.png"];
    }
    [backView addSubview:imageView];
    [self.window addSubview:backView];
    [self.window bringSubviewToFront:backView];
    [self requestData];
    //此方法位置不能更改
    [self.window makeKeyAndVisible];

    
    
    return YES;
}


#pragma mark - 网络请求
-(void)requestData{
    typeNum = 1;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"9" forKey:@"OPT"];
    [[NetWorkClient sharedInstance] requestGet:@"appController/receive" withParameters:parameters];
}
// 返回成功
-(void) httpResponseSuccess:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didSuccessWithObject:(id)obj
{
    NSDictionary *dataDics = obj;
    DLOG(@"%@", dataDics);
    if (typeNum == 1) {
        if ([[NSString stringWithFormat:@"%@",[dataDics objectForKey:@"code"]] isEqualToString:@"1"]) {
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH,MSHIGHT)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH, MSHIGHT)];
            UIButton *timeButton = [[UIButton alloc] initWithFrame:CGRectMake(MSWIDTH-72, 21, 57, 28)];
            [timeButton setBackgroundColor:[UIColor blackColor]];
            [timeButton.layer setCornerRadius:14.0];
            timeButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
            NSString *urlString = [NSString stringWithFormat:@"%@%@",Baseurl,[dataDics objectForKey:@"url"]];
            DLOG(@"%@", urlString);
            NSURL *url = [NSURL URLWithString:urlString];
            DLOG(@"%@", url);
            NSData *data;
            if (url) {
                data = [NSData dataWithContentsOfURL:url];
            }
            imageView.image = [UIImage imageWithData:data];
            [backView addSubview:imageView];
            [backView addSubview:timeButton];
            [self.window addSubview:backView];
            [self.window bringSubviewToFront:backView];
            __block int timeout = 3; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                }else{
                    //int seconds = timeout % 60;
                    // NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [timeButton setTitle:[NSString stringWithFormat:@"跳过:%d",timeout] forState:UIControlStateNormal];
                        timeButton.userInteractionEnabled = NO;
                        [timeButton setAlpha:0.4];
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
            [self performSelector:@selector(startRootView) withObject:nil afterDelay:4.0f];
        }else{
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH,MSHIGHT)];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH, MSHIGHT)];
            if (MSWIDTH==320) {
                if(MSHIGHT == 480){
                    imageView.image = [UIImage imageNamed:@"320-1.png"];
                }else{
                    imageView.image = [UIImage imageNamed:@"320.png"];
                }
            }else if(MSWIDTH == 375){
                imageView.image = [UIImage imageNamed:@"375.png"];
            }else{
                imageView.image = [UIImage imageNamed:@"414.png"];
            }
            [backView addSubview:imageView];
            [self.window addSubview:backView];
            [self.window bringSubviewToFront:backView];
            [self performSelector:@selector(startRootView) withObject:nil afterDelay:0.0f];
        }
    }else if (typeNum == 2){
        if ([[NSString stringWithFormat:@"%@",[dataDics objectForKey:@"code"]] isEqualToString:@"1"]) {
            DLOG(@"返回成功:登录信息-> %@",[obj objectForKey:@"msg"]);
            
            NSString *userId = [NSString stringWithFormat:@"%@",[obj objectForKey:@"t_id"]];
            DLOG(@"userSignId --> %@",userId);
            //保存用户注册成功后得到的用户ID
            [[AppDefaultUtil sharedInstance] setDefaultUserID:userId];
            //记录登录状态
            [[AppDefaultUtil sharedInstance] setLoginState:YES];
            
            TabBarController *tabbarVC = [[TabBarController alloc] init];
            self.window.rootViewController = tabbarVC;
            //检测版本更新
            [[VersionUpdate sharedInstance]checkUpdateWithDelegate:nil];
            //[self loginSuccess];// 登录成功
        }else{
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
            [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
            [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:71/255.0 green:71/255.0 blue:71/255.0 alpha:0.8888888]];
            [SVProgressHUD setMinimumDismissTimeInterval:2.0];
            [SVProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@", [dataDics  objectForKey:@"msg"]]];
            //退出登录状态
            [[AppDefaultUtil sharedInstance]setLoginState:NO];
            // 移除该账号的手势密码
//            [[AppDefaultUtil sharedInstance] removePasswordWithAccount:[[AppDefaultUtil sharedInstance] getDefaultUserID]];
//            [[AppDefaultUtil sharedInstance] removeAccountUserID];
            TabBarController *tabbarVC = [[TabBarController alloc] init];
            self.window.rootViewController = tabbarVC;
        }
    }
}

// 返回失败
-(void) httpResponseFailure:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didFailWithError:(NSError *)error{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH,MSHIGHT)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH, MSHIGHT)];
    if (MSWIDTH==320) {
        if(MSHIGHT == 480){
            imageView.image = [UIImage imageNamed:@"320-1.png"];
        }else{
            imageView.image = [UIImage imageNamed:@"320.png"];
        }
    }else if(MSWIDTH == 375){
        imageView.image = [UIImage imageNamed:@"375.png"];
    }else{
        imageView.image = [UIImage imageNamed:@"414.png"];
    }
    [backView addSubview:imageView];
    [self.window addSubview:backView];
    [self.window bringSubviewToFront:backView];
    [self performSelector:@selector(startRootView) withObject:nil afterDelay:0.0f];
}

// 无可用的网络
-(void) networkError{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH,MSHIGHT)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH, MSHIGHT)];
    if (MSWIDTH==320) {
        if(MSHIGHT == 480){
            imageView.image = [UIImage imageNamed:@"320-1.png"];
        }else{
            imageView.image = [UIImage imageNamed:@"320.png"];
        }
        
    }else if(MSWIDTH == 375){
        imageView.image = [UIImage imageNamed:@"375.png"];
    }else{
        imageView.image = [UIImage imageNamed:@"414.png"];
    }
    [backView addSubview:imageView];
    [self.window addSubview:backView];
    [self.window bringSubviewToFront:backView];
    [self performSelector:@selector(startRootView) withObject:nil afterDelay:0.0f];
}


-(void) startRootView{
    if (![[AppDefaultUtil sharedInstance]isFirstLancher]) {
        [[AppDefaultUtil sharedInstance] setFirstLancher:YES];
        
        [[AppDefaultUtil sharedInstance] setRemeberUser:YES];
        
        //启动引导页
        GuideViewController *guideView = [[GuideViewController alloc]  init];
        self.window.rootViewController = guideView;
        
    }
    else{
        //有保存用户密码则自动登录，并且进入主程序
        if ([[AppDefaultUtil sharedInstance] getDefaultUserName].length != 0 && [[AppDefaultUtil sharedInstance] getPassword].length != 0) {
            [self loginAction];
        }else{
            TabBarController *tabbarVC = [[TabBarController alloc] init];
            self.window.rootViewController = tabbarVC;
        }
    }
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //DLOG(@"applicationDidBecomeActive");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    //记录退到后台时间
    _leaveDate = [NSDate date];
    DLOG(@"leaveDate = %@",_leaveDate);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    _leaveDate = [NSDate date];
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    /*
     [_myTimer invalidate];
     _myTimer = nil;
     
     _backDate = [NSDate date];
     
     
     long leaveTime = (long)[_backDate timeIntervalSince1970] - [_leaveDate timeIntervalSince1970];
     
     DLOG(@"leaveTime = %ld",leaveTime);
     */
    //如果想回到前台才打开解锁，可调用此方法
    //    if (leaveTime > kLockTime)
    //    {
    //        [self showKwindow];
    //        DLOG(@"time out.");
    //    }
    
    //检测版本更新
    //[[VersionUpdate sharedInstance]checkUpdateWithDelegate:self];
}

#pragma mark - VersionUpdateDelegate
- (void)checkAppVersion:(NSString *)version updateType:(BOOL)updateType updatecontent:(NSString *)content updateName:(NSString *)versionName
{
    //从后台进入程序，强制更新才弹提示
    if (updateType) {
        [[VersionUpdate sharedInstance]compareVersion:version updateType:YES updatecontent:content updateName:versionName];
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}







#pragma  mark - Animationdelegate
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    
}

#pragma mark - 登录数据请求

- (void)loginAction
{
    typeNum = 2;
    NSString *userName = [[AppDefaultUtil sharedInstance]getDefaultUserName];
    NSString *_password = [[AppDefaultUtil sharedInstance] getPassword];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:@"3" forKey:@"OPT"];
    [parameters setObject:userName forKey:@"jobnumber"];
    [parameters setObject:_password forKey:@"password"];
    [[NetWorkClient sharedInstance] requestGet:@"appController/receive" withParameters:parameters];
}

@end
