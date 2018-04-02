//
//  StoreViewController.m
//  Flower
//
//  Created by Apple on 2018/1/30.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "StoreViewController.h"
#import <WebKit/WebKit.h>

@interface StoreViewController()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic,strong) WKWebView *myWebView;


@end

@implementation StoreViewController

- (void)viewWillAppear:(BOOL)animated{
      self.navigationController.navigationBarHidden = YES;
     self.fd_prefersNavigationBarHidden = YES;

}

- (void)viewDidLoad{
   
    [self createSubViews];
}

- (void)createSubViews{
    
    _myWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MSWIDTH, MSHIGHT)];
    _myWebView.navigationDelegate = self;
    _myWebView.UIDelegate = self;
    _myWebView.scrollView.bounces = NO;
  
    NSString *url = @"https://weidian.com/?userid=310861942";

    [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:_myWebView];
  
}










@end
