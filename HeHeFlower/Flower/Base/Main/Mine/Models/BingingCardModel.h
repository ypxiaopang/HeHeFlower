//
//  BingingCardModel.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/16.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@class BankCardRecords;

@interface BingingCardModel : NSObject


@property (nonatomic, copy) NSString *real_name;
@property (nonatomic, copy) NSString *card_id;

@property (nonatomic, assign) double withdrawFeePoint;

@property (nonatomic, assign) double withdrawFeeMin;

@property (nonatomic, assign) double withdrawFeeRate;

@property (nonatomic, assign) double maxWithdraw;

@property (nonatomic, assign) double balance;

@property (nonatomic, assign) double withdrawMaxRate;

@property (nonatomic, strong) NSArray *records;

@end

@interface BankCardRecords : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *bankName;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *statusStr;

@end
