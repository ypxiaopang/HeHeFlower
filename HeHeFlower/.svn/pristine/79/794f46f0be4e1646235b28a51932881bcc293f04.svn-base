//
//  MyTools.h
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTools : NSObject

//获取文字宽高
+ (CGSize)getSizeOfString:(NSString *)string maxWidth:(CGFloat)width maxHeight:(CGFloat)height withFont:(UIFont *)font;

// 设置可变字体
+ (void)setAttributedLabel:(UILabel *)label rangeStr:(NSString *)rangeStr color:(UIColor *)color font:(UIFont *)font;

// 设置可变字体，获取可变字符串,行距
+ (NSMutableAttributedString *)getAttributedWithText:(NSString *)text rangeStr:(NSString *)rangeStr color:(UIColor *)color font:(UIFont *)font lineSpace:(CGFloat)lineSpace;

// 字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 延时
+ (void)completion:(void (^)(bool finish))completion afterDelay:(CGFloat)delay;

// 去掉 html字符串中所有标签
+ (NSString *)filterHTML:(NSString *)html;

//金额格式化
+ (NSString *)formatConversion:(double)amount type:(NSInteger)type;

//获取转让状态
+ (NSString *)getDebtStatus:(NSString *)status;


@end
