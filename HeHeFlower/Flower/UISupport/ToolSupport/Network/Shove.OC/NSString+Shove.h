//
//  NSString+Shove.h
//  mashine
//
//  Created by 韩 立 on 2017/7/14.
//  Copyright © 2017年 迈世集团. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Shove)

/* 
 * 判断字符串是否为空白的
 */
- (BOOL)isBlank;

/* 
 * 判断字符串是否为空
 */
- (BOOL)isEmpty;

/* 
 * 给字符串md5加密
 */
- (NSString *)md5;

/**
 * 判断字符串是否是email格式
 */
- (BOOL)isEmail;

/**
 * 判断字符串是否是手机号码格式
 */
- (BOOL)isPhone;

@end
