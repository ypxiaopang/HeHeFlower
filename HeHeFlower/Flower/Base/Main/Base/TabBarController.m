//
//  TabBarController.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "TabBarController.h"
#import "MyNavigationController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "BaseViewController.h"
#import "MyAccountViewController.h"
#import "StoreViewController.h"
#import "ScanQRCodeViewController.h"
#import "QuestionViewController.h"

@class InvestViewController;
@class LoanViewController;
//@class MyAccountViewController;

@interface TabBarController ()

@end

@implementation TabBarController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectIndex:) name:CHANGETABBAR object:nil];
    
    [[UITabBarItem appearance] setTitleTextAttributes:                                                  [NSDictionary dictionaryWithObjectsAndKeys:[ColorTools colorWithHexString:@"#41b086"],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    
    UITabBarItem *myEuqipItem = [[UITabBarItem alloc] initWithTitle:@"我的设备" image:[UIImage imageNamed:@"我的设备 未点击"] selectedImage:[[UIImage imageNamed:@"我的设备 点击"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem *flowerOriginalItem = [[UITabBarItem alloc] initWithTitle:@"花卉追溯" image:[UIImage imageNamed:@"花卉追溯 未点击"] selectedImage:[[UIImage imageNamed:@"花卉追溯 点击"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem *questionItem = [[UITabBarItem alloc] initWithTitle:@"问答" image:[UIImage imageNamed:@"问答 未点击"] selectedImage:[[UIImage imageNamed:@"问答 点击"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem *shopItem = [[UITabBarItem alloc] initWithTitle:@"商城" image:[UIImage imageNamed:@"商城 未点击"] selectedImage:[[UIImage imageNamed:@"商城 点击"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem *individualCenterItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[UIImage imageNamed:@"个人中心 未点击"] selectedImage:[[UIImage imageNamed:@"个人中心 点击"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    HomeViewController *homeView = [[HomeViewController alloc]init];
    MyNavigationController *homeNav = [[MyNavigationController alloc]initWithRootViewController:homeView];
    homeNav.tabBarItem = myEuqipItem;
    
    ScanQRCodeViewController *qrView = [[ScanQRCodeViewController alloc] init];
    MyNavigationController *qrNav = [[MyNavigationController alloc] initWithRootViewController:qrView];
    qrNav.tabBarItem = flowerOriginalItem;
    
    QuestionViewController *questionView = [[QuestionViewController alloc] init];
    MyNavigationController *questionNav = [[MyNavigationController alloc] initWithRootViewController:questionView];
    questionNav.tabBarItem = questionItem;
    
    StoreViewController *storeView = [[StoreViewController alloc]init];
       MyNavigationController *productsNav = [[MyNavigationController alloc]initWithRootViewController:storeView];
    productsNav.tabBarItem = shopItem;
    
    MyAccountViewController *accountView = [[MyAccountViewController alloc]init];
    MyNavigationController *accountNav = [[MyNavigationController alloc]initWithRootViewController:accountView];
    accountNav.tabBarItem = individualCenterItem;
   
    self.viewControllers = @[homeNav,qrNav,questionNav,productsNav,accountNav];
    
}

#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //判断的是当前点击的tabBarItem的标题
    if ([viewController.tabBarItem.title isEqualToString:@"我的"] && ![[AppDefaultUtil sharedInstance]isLoginState]) {
        
        //如果未登录，则跳转登录界面
        LoginViewController *loginView = [[LoginViewController alloc] init];
        MyNavigationController *loginNVC = [[MyNavigationController alloc] initWithRootViewController:loginView];
        loginView.backType = MinePage;
        [((UINavigationController *)tabBarController.selectedViewController) presentViewController:loginNVC animated:YES completion:nil];
        
        return NO;
    }
    else{
        return YES;
    }
}

#pragma mark - 跳转指定tabbar
- (void)changeSelectIndex:(NSNotification *)note
{
    NSInteger index = [[note object]integerValue];
    [self setSelectedIndex:index];
}





@end
