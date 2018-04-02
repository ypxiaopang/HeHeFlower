//
//  ConverUtil.h
//  mashine
//
//  Created by 韩 立 on 2017/7/14.
//  Copyright © 2017年 迈世集团. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConverUtil : NSObject
/**
 64编码
 */
+(NSString *)base64Encoding:(NSData*) text;
/**
 字节转化为16进制数
 */
+(NSString *) parseByte2HexString:(Byte *) bytes;
/**
 字节数组转化16进制数
 */
+(NSString *) parseByteArray2HexString:(Byte[]) bytes;
/*
 将16进制数据转化成NSData 数组
 */
+(NSData*) parseHexToByteArray:(NSString*) hexString;

//将16进制数据转化成NSData
+ (NSData *)hexStrToNSData:(NSString *)hexStr;

//将NSData转化成16进制数据
+ (NSString *)NSDataToHexString:(NSData *)data;

@end
