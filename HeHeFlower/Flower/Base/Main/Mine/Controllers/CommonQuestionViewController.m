//
//  CommonQuestionViewController.m
//  Flower
//
//  Created by Apple on 2018/3/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CommonQuestionViewController.h"

@interface CommonQuestionViewController ()<NavBarDelegate>
@property(nonatomic, strong)NavBar *navBar;
@end

@implementation CommonQuestionViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    
    _navBar = [[NavBar alloc]initWithTitle:@"常见问题"];
    _navBar.delegate = self;
    
    [self.view addSubview:_navBar];
    self.navigationController.navigationBar.alpha=1;
    
}

- (void)leftItemClick{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)rightItemClick{
    
    
}



@end
