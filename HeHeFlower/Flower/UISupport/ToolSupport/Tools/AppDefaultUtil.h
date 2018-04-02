//
//  AppDefaultUtil.h
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDefaultUtil : NSObject

/**
 单例模式，实例化对象
 */
+ (instancetype)sharedInstance;

// 设置是否记住密码
-(void) setRemeberUser:(BOOL)value;

// 获取用户是否记住密码
-(BOOL) isRemeberUser;

// 设置注册后首次登录状态
- (void)setFromRegisterToLoginState:(BOOL)value;
// 获取注册后首次登录状态
-(BOOL) isFromRegisterToLoginState;
// 设置当前的登录状态
- (void)setLoginState:(BOOL)value;

// 获取当前的登录状态
-(BOOL) isLoginState;


// 设置用户是否第一次登陆
-(void) setFirstLancher:(BOOL)value;

// 获取用户是否第一次登录
-(BOOL) isFirstLancher;

// 保存最后一次用户登录的用户ID
-(void) setDefaultUserID:(NSString *)value;

// 获取最后一次用户登录的用户ID
-(NSString *) getDefaultUserID;

// 保存最后一次用户登录的用户昵称
-(void) setDefaultUserName:(NSString *)value;

// 获取最后一次用户登录的用户昵称
-(NSString *) getDefaultUserName;

// 保存最后一次用户登录的手机号
-(void) setPhoneNum:(NSString *)value;

// 获取最后一次用户登录的手机号
-(NSString *) getPhoneNum;

// 保存最后一次登录的用户密码(des加密后)
-(void) setPassword:(NSString *)value;

// 获取最后一次登录的用户密码(des加密后)
-(NSString *) getPassword;

// 设置用户头像
-(void) setDefaultIcon:(UIImage *)image;
//
// 获取用户头像
-(UIImage *) getDefaultIcon;

// 通过url设置用户头像
-(void) setDefaultHeaderImageUrl:(NSString *)value;

// 获取某用户的头像的url
-(NSString *) getDefaultHeaderImageUrl;

// 保存设备型号
-(void) setdeviceType:(NSString *) deviceType;
// 获取设备型号
-(NSString *) getdeviceType;


// 保存最后一次密码(没加密)
-(void) setDefaultUserNoPassword:(NSString *)value;
// 获取最后一次密码(没加密)
-(NSString *) getDefaultUserNoPassword;

// 保存最后一次启动网络图片
-(void) setAppImage:(NSString *)value;
// 获取最后一次启动网络图片
-(NSString *) getAppImage;

//登录用户名列表
-(void) setDefaultNameList:(NSArray *)nameArr;
//获取用户名列表
-(NSArray *) getDefaultNameList;

// 保存是否请求数据的标识
- (void)setIdentification:(NSString *)identification;
// 获取是否请求数据的标识
- (NSString *)getIdentification;

// 保存是否需要升级的标识
- (void)setAppUpdata:(NSString *)appUpdata;
// 获取是否需要升级的标识
- (NSString *)getAppUpdata;

@end
