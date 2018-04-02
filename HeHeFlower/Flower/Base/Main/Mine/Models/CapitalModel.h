//
//  CapitalModel.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/16.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CapitalModel : NSObject
@property (nonatomic,copy) NSString *balance;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *photo;
@property (nonatomic,copy) NSString *totalAssets;
@property (nonatomic,copy) NSString *totalIncome;
@property (nonatomic,copy) NSString *hasUserUnreadMsg;
@property (nonatomic,assign) BOOL isEnter;

@end
