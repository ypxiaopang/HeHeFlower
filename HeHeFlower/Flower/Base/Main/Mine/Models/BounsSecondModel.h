//
//  BounsSecondModel.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/5.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BounsSecondModel : NSObject
@property (nonatomic,copy) NSString *redbag_id;//"id"
@property (nonatomic,copy) NSString *redbag_name;//"名字"
@property (nonatomic,copy) NSString *amount;//"面额"

@property (nonatomic,copy) NSString *date_start;//"起始时间"

@property (nonatomic,copy) NSString *date_end;//"结束时间"

@property (nonatomic,copy) NSString *status;//"状态"
@property (nonatomic,copy) NSString *tender_period;//期限
@property (nonatomic,copy) NSString *tender_amount;//"投资额度"

@property (nonatomic,copy) NSString *activity_infor;//"活动信息"

@end
