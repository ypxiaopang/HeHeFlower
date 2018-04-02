//
//  RestUIAlertView.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "RestUIAlertView.h"

@interface RestUIAlertView()<UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation RestUIAlertView

- (id)initWithTitle:(NSString *)title content:(NSString *)content {
	
	if (self = [super init])
	{
		_alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
		
		[_alertView show];
	}
	
	return self;
}

- (void)show {
	
	UIViewController *topVC = [self appRootViewController];
	self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - _alertView.frame.size.width) * 0.5, CGRectGetHeight(topVC.view.bounds), _alertView.frame.size.width, _alertView.frame.size.height);
	[topVC.view addSubview:self];
	
}

- (UIViewController *)appRootViewController
{
	UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
	UIViewController *topVC = appRootVC;
	while (topVC.presentedViewController) {
		topVC = topVC.presentedViewController;
	}
	return topVC;
}

#pragma mark - UIAlertView 代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	switch (buttonIndex) {
		case 0:
		{
			if (self.leftBlock) {
				self.leftBlock();
			}
			[self dismissAlert];
		}
			
			break;
		case 1:
		{
			if (self.rightBlock) {
				self.rightBlock();
			}
			[self dismissAlert];
		}
			
			break;
	}
	
}

- (void)dismissAlert
{
	if (self.dismissBlock) {
		self.dismissBlock();
	}
}



@end