//
//  BaseViewController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "NetWorkClient.h"
@interface BaseViewController ()<HTTPClientDelegate>

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear :animated];
	self.navigationController.navigationBarHidden = YES;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

	//取消手势返回
	if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
     self.navigationController.interactivePopGestureRecognizer.enabled = NO;
	}
    self.view.backgroundColor = BGC;

    
}

// 返回成功
-(void) httpResponseSuccess:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didSuccessWithObject:(id)obj{

}

// 返回失败
-(void) httpResponseFailure:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didFailWithError:(NSError *)error
{
    
}
// 无可用的网络
-(void) networkError{

}


@end
