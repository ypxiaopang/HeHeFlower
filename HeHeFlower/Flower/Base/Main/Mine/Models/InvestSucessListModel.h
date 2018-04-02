//
//  InvestSucessListModel.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/12.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvestSucessListModel : NSObject
@property (nonatomic, copy) NSString *borrow_id;//标的ID
@property (nonatomic, copy) NSString *borrow_status;
@property (nonatomic, copy) NSString *tender_seq;
@property (nonatomic, copy) NSString *borrow_title;//标的标题
@property (nonatomic, copy) NSString *aword_amount;//应赚奖励
@property (nonatomic, copy) NSString *borrow_account_scale;//投资进度
@property (nonatomic, copy) NSString *borrow_rate;//标的利率
@property (nonatomic, copy) NSString *valid_account_tender;//有效投资金额
@property (nonatomic, copy) NSString *ins_date;//投资日期
@property (nonatomic, copy) NSString *tender_status;//标的状态
@property (nonatomic, copy) NSString *recover_account_all;//应收本息

@end
