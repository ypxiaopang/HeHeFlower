//
//  AssoicateViewController.m
//  Flower
//
//  Created by 张营营 on 2018/4/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AssoicateViewController.h"

@interface AssoicateViewController ()

@property(nonatomic, retain)NavBar *navBar;


@end

@implementation AssoicateViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _navBar = [[NavBar alloc]initWithTitle:@"关联账号"];
    _navBar.delegate = (id)self;
    
    [self.view addSubview:_navBar];
    self.navigationController.navigationBar.alpha=1;
    
}

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)rightItemClick{
    
    
}


@end
