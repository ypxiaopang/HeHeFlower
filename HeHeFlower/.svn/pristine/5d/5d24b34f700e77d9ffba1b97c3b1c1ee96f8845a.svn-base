//
//  ShoveGeneralRestGateway.h
//  mashine
//
//  Created by 韩 立 on 2017/7/14.
//  Copyright © 2017年 迈世集团. All rights reserved.
//
// 通用的 REST 类型的网关

#import <Foundation/Foundation.h>

@interface ShoveGeneralRestGateway : NSObject

/**
 * 构建通用网关的请求 url，参数为键值对形式，不分顺序。不需要包含时间戳、签名等参数 ，系统会自动增加。
 *
 * @param baseUrl
 *                  地址
 * @param key
 *                  加密的key
 * @param parameters
 *                  参数
 * @return  生成后的网关
 */
+ (NSString *) buildUrl:(NSString *)baseUrl key:(NSString *)key parameters:(NSDictionary *)parameters;

@end
