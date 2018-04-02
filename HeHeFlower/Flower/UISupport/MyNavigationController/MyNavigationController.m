//
//  MyNavigationController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "MyNavigationController.h"

@implementation MyNavigationController

+(void)initialize
{
    //[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0];
    
    // 1.获得bar对象, 修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 2.设置bar高度
    CGFloat navBarHeight = 24.0f;
    CGRect rect = CGRectMake(0, 0, MSWIDTH, navBarHeight);
    [navBar setFrame:rect];
    //	[navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    //[navBar setBarTintColor:[UIColor blueColor]];
    
    
    // 4.设置文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //attrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:attrs];
    
    // 5.设置导航栏按钮的主题
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 6.设置按钮的文字样式
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //itemAttrs[NSShadowAttributeName] = [NSValue valueWithUIOffset:UIOffsetMake(0, 0)];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
    
    // 设置状态栏的背景颜色
    //[navBar setBarTintColor:baseNavColor];
    //[navBar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
}




@end
