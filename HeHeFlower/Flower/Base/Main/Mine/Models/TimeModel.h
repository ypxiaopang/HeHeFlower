//
//  TimeModel.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/16.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

@property (nonatomic, copy) NSString *time;

@end


@interface LongTimeModel : NSObject

@property (nonatomic, assign) long long time;

@end