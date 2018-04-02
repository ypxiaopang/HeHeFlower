//
//  Macros.h
//
//  宏定义文件
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "AppDelegate.h"

// 应用程序托管
#define AppDelegateInstance	                        ((AppDelegate*)([UIApplication sharedApplication].delegate))

//宽高度宏定义
#define ITHIGHT   44
#define CELLHIGHT 58


#define MSWIDTH [UIScreen mainScreen].bounds.size.width
#define MSHIGHT CGRectGetHeight([UIScreen mainScreen].bounds)
#define NAVBAR_FRAME CGRectMake(0, 0, MSWIDTH, NAVBAR_HEIGHT)
#define MYTABLEVIEW_FRAME CGRectMake(0, NAVBAR_HEIGHT, MSWIDTH, MSHIGHT - NAVBAR_HEIGHT)
#define NAVBAR_HEIGHT (MSHIGHT==812?88.0f:68.0f)
//#define NAVBAR_HEIGHT 68

// 其它的宏定义
#ifdef DEBUG
	#define                                         DLOG(...) NSLog(__VA_ARGS__)
	#define                                         DLOG_METHOD NSLog(@"%s", __func__)
    #define                                         DLOGERROR(...) NSLog(@"%@传入数据有误",__VA_ARGS__)
#else
	#define                                         DLOG(...)
	#define                                         DLOG_METHOD
    #define                                         DLOGERROR(...) NSLog(@"%@传入数据有误",__VA_ARGS__)
#endif

//判断系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//判断是否大于 IOS7
#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

//======================================================================

#define IS_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define IS_iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define IS_IPHONE6PLUS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && [[UIScreen mainScreen] nativeScale] == 3.0f)

//判断是否是iphone5
#define IS_WIDESCREEN                              ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - (double)568 ) < __DBL_EPSILON__ )
#define IS_IPHONE                                  ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] || [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone Simulator" ])
#define IS_IPOD                                    ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_IPHONE_5                                ( IS_IPHONE && IS_WIDESCREEN )


#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 838.00
#endif

#define iOS7 (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0)

//判断字符串是否为空
#define IFISNIL(v)                                 (v = (v != nil) ? v : @"")
//判断NSNumber是否为空
#define IFISNILFORNUMBER(v)                        (v = (v != nil) ? v : [NSNumber numberWithInt:0])
//判断是否是字符串
#define IFISSTR(v)                                 (v = ([v isKindOfClass:[NSString class]]) ? v : [NSString stringWithFormat:@"%@",v])

#define NUMBERS @"0123456789\n"

#define CHANGETABBAR   @"ChangeTabbarIndex"

#define WordFontName_W3(num)   [UIFont fontWithName:@"HiraginoSans-W3" size:num]


//数据宏定义
#define MYACCOUNDLABELARR @[@"关联账号",@"历史植物",@"常见问题"];

#define MYACCOUNTICONARR @[[UIImage imageNamed:@"关联"],[UIImage imageNamed:@"历史记录"],[UIImage imageNamed:@"问题-互动"]];

