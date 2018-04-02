//
//  NSString+Sign.m
//  mashine
//
//  Created by 韩 立 on 2017/7/14.
//  Copyright © 2017年 迈世集团. All rights reserved.
//

#import "NSString+Sign.h"

@implementation NSString (Sign)

/**
 *  ID加密
 *
 *  @param kId     需要加密的Id
 *  @param action  加密action标识
 *
 *  @return 加密sign
 */
+ (NSString *)addSign:(NSInteger)kId action:(NSString *)action
{
    if (kId == 0 || action.length == 0) {
        return @"";
    }
    //获取当前时间
    NSString *currentTime = [[self dateFormatter] stringFromDate:[NSDate date]];
   
    /* 将id、action标示、当前时间利用3des加密 */
    NSArray *arr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)kId],action,currentTime,nil];
    /* 用逗号分隔组成字符串 */
    NSString *joinedStr = [arr componentsJoinedByString:@","];
    /* 进行3DES加密 */
    NSString *des = [NSString encrypt3DES:joinedStr key:DESkey];
    /* 将des和3DESkey拼接，再进行MD5加密 */
    NSString *md5 =  [[des stringByAppendingString:DESkey]md5];
    /* 将得到的des和MD5密文拼接处理 */
    NSString *sign= [des stringByAppendingString:[md5 substringToIndex:8]];  //md5结果的前8位
    
    return sign;
}
/**
 *  ID解密
 *
 *  @param sign         密文
 *  @param action       加密action标识
 *  //@param encryptKey   3DESkey
 *
 *  @return 解密ID
 */
+ (NSString *)decodeSign:(NSString *)sign action:(NSString *)action
{
    /* 判断密文是否为空 */
    if (!sign || [sign isEqual:[NSNull null]] || sign.length < 8){
        return @"";
    }
    //截取字符串(0,sign.length-8)
    NSString *des = [sign substringWithRange:NSMakeRange(0,sign.length-8)];
    //截取最后8位
    NSString *key = [sign substringFromIndex:sign.length-8];
    //将des和3DESkey拼接，进行MD5加密
    NSString *md5 = [[des stringByAppendingString:DESkey]md5];
    
    if (![key isEqualToString:[md5 substringToIndex:8]]) {
        return @"";//无效请求
    }
    
    //将des进行3DSE解密,再进行数组分割 获取id,action,time
    NSString *desKey = [NSString decrypt3DES:des key:DESkey];
    NSArray *decryArray = [desKey componentsSeparatedByString:@","];
    
    if (decryArray.count != 3 || [decryArray[0]length] == 0 || ![decryArray[1]isEqualToString:action] ||  [decryArray[2]length] == 0)
    {
        return @"";//无效请求
    }
    
    //判断有效时间
    NSDateFormatter *formatter = [self dateFormatter];
    NSDate *validDate = [formatter dateFromString:decryArray[2]];
    NSDate *currentDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    //得到相差秒数
    NSTimeInterval time =[currentDate timeIntervalSinceDate:validDate];

    if (time > VALID_TIME)
    {
        return @"";//请求超时
    }
    
    return decryArray[0];//解密成功
}

/* 获取时间格式 */
+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    return formatter;
}

@end
