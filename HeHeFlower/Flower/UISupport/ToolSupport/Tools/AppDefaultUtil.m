//
//  AppDefaultUtil.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "AppDefaultUtil.h"


#define KEY_FIRST_LANCHER @"FirstLancher" // 记录用户是否第一次登陆，YES为是，NO为否

#define KEY_USER_ID @"UserId" // 用户Id

#define KEY_USER_NAME @"UserName" // 用户昵称

#define KEY_PHONE_NUM @"PhoneNum" // 手机号

#define KEY_PASSWORD @"Password" // 密码

#define NO_KEY_PASSWORD @"noPassword" // 密码(没有加密)

#define KEY_HEARD_IMAGE @"HeardImage" //头像

#define KEY_GESTURES_PASSWORD @"GesturesPassword" //手势密码

#define KEY_REMEBER_USER @"RemeberUser" //  记住用户

#define KEY_DEVICE_TYPE @"deviceType" //设备型号

#define KEY_appImage @"appImage" //启动网络图片

#define KEY_Name_List @"NameList" // 名字列表

#define KEY_LOGSTATE @"logState" //  登录状态

#define KEY_FromRegisterToLOGSTATE @"fromRegisterToLogState" //  登录状态

#define KEY_BANKERNUM @"bankerNum" //银行卡号

#define KEY_IDENTIFICATION @"identification" //标识

#define KEY_APPUPDATA @"appUpdata" //是否需要升级

#define KEY_ISREQUESTDATA @"isRequestData" //是否需要对资产管理界面请求我的借款数据


@interface AppDefaultUtil()


@end

@implementation AppDefaultUtil

+ (instancetype)sharedInstance {
    
    static AppDefaultUtil *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppDefaultUtil alloc] init];        
    });
    
    return _sharedClient;
}

// 设置是否记住密码
-(void) setRemeberUser:(BOOL)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:KEY_REMEBER_USER];
    [defaults synchronize];
}

-(BOOL) isRemeberUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:KEY_REMEBER_USER];
}

// 设置注册后首次登录状态
- (void)setFromRegisterToLoginState:(BOOL)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:KEY_FromRegisterToLOGSTATE];
    [defaults synchronize];
}

// 获取注册后首次登录状态
-(BOOL) isFromRegisterToLoginState
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:KEY_FromRegisterToLOGSTATE];
}




// 设置当前的登录状态
- (void)setLoginState:(BOOL)value
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:value forKey:KEY_LOGSTATE];
	[defaults synchronize];
}

// 获取当前的登录状态
-(BOOL) isLoginState
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:KEY_LOGSTATE];
}


// 用户是否第一次登陆
-(void) setFirstLancher:(BOOL)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:KEY_FIRST_LANCHER];
    [defaults synchronize];
}

-(BOOL) isFirstLancher
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:KEY_FIRST_LANCHER];
}

// 保存最后一次用户登录的用户ID
-(void) setDefaultUserID:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_USER_ID];
    [defaults synchronize];
}

-(NSString *) getDefaultUserID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:KEY_USER_ID];
    return userId;
}


// 保存最后一次用户登录的用户昵称
-(void) setDefaultUserName:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_USER_NAME];
    [defaults synchronize];
}

-(NSString *) getDefaultUserName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_USER_NAME];
}

// 手机号
-(void) setPhoneNum:(NSString *)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_PHONE_NUM];
    [defaults synchronize];
}

-(NSString *) getPhoneNum
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_PHONE_NUM];
}


// 密码 (des 加密后)
-(void) setPassword:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_PASSWORD];
    [defaults synchronize];
}

-(NSString *) getPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_PASSWORD];
}

// 密码 (没加密)
-(void) setDefaultUserNoPassword:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:NO_KEY_PASSWORD];
    [defaults synchronize];
}

-(NSString *) getDefaultUserNoPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:NO_KEY_PASSWORD];
}

// 通过url设置用户头像
-(void) setDefaultHeaderImageUrl:(NSString *)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_HEARD_IMAGE];
    [defaults synchronize];
}

-(NSString *) getDefaultHeaderImageUrl
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_HEARD_IMAGE];
}


-(void) setdeviceType:(NSString *) deviceType {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceType forKey:KEY_DEVICE_TYPE];
    [defaults synchronize];
}

-(NSString *) getdeviceType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_DEVICE_TYPE];
}

// 保存启动网络图片
-(void) setAppImage:(NSString *)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_appImage];
    [defaults synchronize];
}
// 获取启动网络图片
-(NSString *) getAppImage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_appImage];
}

//登录用户名列表
-(void) setDefaultNameList:(NSArray *)nameArr
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nameArr forKey:KEY_Name_List];
    [defaults synchronize];
}

-(NSArray *) getDefaultNameList
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *nameList = [defaults objectForKey:KEY_Name_List];
    if (nameList == nil) {
        nameList = [[NSArray alloc] init];
    }
    return nameList;
}

-(void) setDefaultIcon:(UIImage *)image
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//NSData *imageData = UIImagePNGRepresentation(image);
	NSData *imageData = UIImageJPEGRepresentation(image, 100);
	[defaults setObject:imageData forKey:KEY_HEARD_IMAGE];
	[defaults synchronize];
}

-(UIImage *) getDefaultIcon
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSData *imageData = [defaults objectForKey:KEY_HEARD_IMAGE];
	if (imageData!= nil) {
		UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
		return image;
	}
	return nil;
}


- (void)setIdentification:(NSString *)identification{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:identification forKey:KEY_BANKERNUM];
	[defaults synchronize];
}

- (NSString *)getIdentification{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults objectForKey:KEY_BANKERNUM];
}

- (void)setAppUpdata:(NSString *)appUpdata{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:appUpdata forKey:KEY_APPUPDATA];
	[defaults synchronize];

}
// 获取是否需要升级的标识
- (NSString *)getAppUpdata{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults objectForKey:KEY_APPUPDATA];
}

@end
