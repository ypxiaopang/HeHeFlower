//
//  BounsFirstModel.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/5.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BounsFirstModel : NSObject

@property (nonatomic,copy) NSString *redpacket_name;//红包名称
@property (nonatomic,copy) NSString *status; //状态
@property (nonatomic,copy) NSString *amount;//"面额"

@property (nonatomic,copy) NSString *date_start;//"起始时间"

@property (nonatomic,copy) NSString *date_end;//"结束时间"

@property (nonatomic,copy) NSString *valid_days;//"有效天数"

@property (nonatomic,copy) NSString *source;//"来源"

@property (nonatomic,copy) NSString *activity_infor;//"来源信息"



@end
