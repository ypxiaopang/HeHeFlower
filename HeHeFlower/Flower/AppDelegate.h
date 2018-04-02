//
//  AppDelegate.h
//  Flower
//
//  Created by Apple on 2018/1/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UserInfo *userInfo;

@property (nonatomic, strong) NSString *openType;

@property(nonatomic, assign)NSInteger huanjiekou;
//首页公告里的未读信息是否阅读
@property (nonatomic, assign) BOOL isHomeUpdate;

@property (nonatomic, assign) BOOL isFromMinePage;//从我的页面而来。
@end


