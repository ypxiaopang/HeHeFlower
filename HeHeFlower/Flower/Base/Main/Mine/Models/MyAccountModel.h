//
//  MyAccountModel.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/14.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAccountModel : NSObject
@property (nonatomic,copy) NSString *capital_total;//账户总额
@property (nonatomic,copy) NSString *balance;//账户余额
@property (nonatomic,copy) NSString *await_banlance;//待收本金
@property (nonatomic,copy) NSString *frost;//冻结金额
@property (nonatomic,copy) NSString *await_interest;//待收利息
@end
