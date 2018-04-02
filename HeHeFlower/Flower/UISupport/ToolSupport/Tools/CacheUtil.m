//
//  CacheUtil.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "CacheUtil.h"
#import "NSString+Shove.h"

@implementation CacheUtil


+(NSString *) creatCacheFileName:(NSDictionary *) parameters
{
    NSArray *parameterNames = [parameters allKeys];
    
    NSString *cacheName = @"";
    
    for (int i = 0; i < [parameters count]; i++) {
        NSString *_key = parameterNames[i];
        NSString * _value = parameters[_key];
        
        cacheName = [NSString stringWithFormat:@"%@%@=%@", cacheName, _key, _value];
        if (i < ([parameters count] - 1)) {
            cacheName = [cacheName stringByAppendingString:@"&"];
        }
    }
    
    return [cacheName md5];
}

@end
