//
//  NetWorkClient.h
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ShoveGeneralRestGateway.h"
#import "NSString+encryptDES.h"
#import "AFHTTPSessionManager.h"

@protocol HTTPClientDelegate;

@interface NetWorkClient : AFHTTPSessionManager

@property (nonatomic, weak) id<HTTPClientDelegate>delegate;

+ (instancetype)sharedInstance;//单例模式

- (instancetype)init;

- (NSURLSessionDataTask *) requestGet:(NSString *)URLString withParameters:(NSDictionary *)parameters;
/**
 * 带block的请求方式
 */
- (NSURLSessionDataTask *)requestParameters:(NSDictionary *)parameters success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 取消任务
 */
-(void) cancel;

-(BOOL)isNetworkEnabled;

@end

@protocol HTTPClientDelegate <NSObject>

@optional

-(void) startRequest;

-(void) httpResponseSuccess:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didSuccessWithObject:(id)obj;

-(void) httpResponseFailure:(NetWorkClient *)client dataTask:(NSURLSessionDataTask *)task didFailWithError:(NSError *)error;

-(void)networkError;


@end
