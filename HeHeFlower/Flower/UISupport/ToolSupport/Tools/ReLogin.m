//
//  ReLogin.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "ReLogin.h"
#import "RestUIAlertView.h"
#import "LoginViewController.h"

#import "MyNavigationController.h"

@interface ReLogin()<HTTPClientDelegate>
//@property(nonatomic ,strong) NetWorkClient *requestClient;

@end

@implementation ReLogin

//- (NetWorkClient *)requestClient{
//	if (!_requestClient) {
//		_requestClient = [[NetWorkClient alloc] init];
//		_requestClient.delegate = self;
//	}
//	return _requestClient;
//}
//


+ (void)oldOutTheTimeRelogin:(UIViewController *)viewController;
{
	// 登录过期
	RestUIAlertView *restAlert  =  [[RestUIAlertView alloc] initWithTitle:@"登录提示" content:@"亲，未登录或登录过期，请重新登录！"];
	
	restAlert.leftBlock = ^() {
		
		LoginViewController *calculatorVC = [[LoginViewController alloc] init];
		UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:calculatorVC];
		[viewController presentViewController:navigationController animated:YES completion:nil];
	};
	
	restAlert.rightBlock = ^() {
		// 取消按钮
		
		DLOG(@"取消");
		
	};
	restAlert.dismissBlock = ^() {
		
	};
	[restAlert show];
	
}

//登录超时调用方法
+ (void)outTheTimeRelogin:(UIViewController *)viewController{

//    GestureViewWindow *kwin = [GestureViewWindow sharedInstance];
//   //kwin.delegate = self;
//	[kwin show];
    
    LoginViewController *loginView = [[LoginViewController alloc] init];
    MyNavigationController *loginNVC = [[MyNavigationController alloc] initWithRootViewController:loginView];
    if ([[AppDefaultUtil sharedInstance]isLoginState]) {
        loginView.backType = LoginTimeOut;
    }
    [viewController presentViewController:loginNVC animated:YES completion:nil];
}

//未登录调用方法
+ (void)goLogin:(UIViewController *)viewController
{
    LoginViewController *loginView = [[LoginViewController alloc] init];
    MyNavigationController *loginNVC = [[MyNavigationController alloc] initWithRootViewController:loginView];
    [viewController presentViewController:loginNVC animated:YES completion:nil];
}


@end
