//
//  HomeModel.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/16.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Banners;

@interface HomeModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray *invests;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic,copy)    NSString *totalInvestAmount;

@property (nonatomic,copy)    NSString *totalInvestUser;

@property (nonatomic, strong) NSArray *banners;

@property (nonatomic, strong) NSArray *records;

@property (nonatomic, strong) NSArray *juliTopLineList;

@property (nonatomic, assign) BOOL experience;

@end

@interface Banners : NSObject

@property (nonatomic, copy) NSString *link_url;

@property (nonatomic, copy) NSString *file_url;

@end






