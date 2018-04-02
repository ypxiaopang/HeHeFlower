//
//  ActionConstants.m
//  mashine
//
//  Created by 韩 立 on 2017/7/14.
//  Copyright © 2017年 迈世集团. All rights reserved.
//
//加密action常量

#import "ActionConstants.h"

@implementation ActionConstants

/** 加密串有效时间(s) */
const NSInteger VALID_TIME = 3600;
/** 加密action标识:标ID */
NSString * const BID_ID_SIGN = @"b";
/** 加密action标识:债权转让项目ID */
NSString * const DEBT_TRANSFER_ID_SIGN = @"debt";
/** 加密action标识:等级ID */
NSString * const CREDITLEVEL_ID_SIGN = @"cl";
/** 加密action标识:账单ID */
NSString * const BILL_ID_SIGN = @"bill";
/** 加密action标识:投资ID */
NSString * const INVEST_ID_SIGN = @"invest";
/** 加密action标识:产品ID */
NSString * const PRODUCT_ID_SIGN = @"p";
/** 加密action标识:用户ID */
NSString * const USER_ID_SIGN = @"user";
/** 加密action标识:管理员ID */
NSString * const SUPERVISOR_ID_SIGN = @"supervisor_id";
/** 加密action标识:资料ID */
NSString * const ITEM_ID_SIGN = @"i";
/** 加密action标识:用户资料ID */
NSString * const USER_ITEM_ID_SIGN = @"ui";
/** 加密action标识:用户站内信 */
NSString * const MSG_ID_SIGN = @"mi";
/** 加密action标识:用户邮箱 */
NSString * const MSG_EMAIL_SIGN = @"email";
/** 合同模板加密标志 */
NSString * const MSG_PACTTEMP_SIGN = @"pactTemp";
/** 合同模板加密标志 */
NSString * const MSG_PACT_SIGN = @"pact";
/** 加密action标识:资讯ID */
NSString * const INFORMATION_ID_SIGN = @"infor";
/** 加密action标识:广告图片ID  */
NSString * const ADS_ID_SIGN = @"ads";
/** 加密action标识:理财顾问ID  */
NSString * const CONSULTANT_ID_SIGN = @"consultant";
/** 加密action标识:合作伙伴ID  */
NSString * const PARTNER_ID_SIGN = @"partner";
/** 加密action标识:帮助中心ID  */
NSString * const HELPCENTER_ID_SIGN = @"help";
/** 加密action标识:兑换记录  */
NSString * const CONV_ID_SIGN = @"conv";
/** 加密action标识:主题  */
NSString * const THEME_ID_SIGN = @"theme";
/** 一些弹框的sign加密value */
NSString * const SHOW_BOX = @"show_box";
/** 加密action标识:通知模板  */
NSString * const NOTEMP_ID_SIGN = @"notemp";
/** 加密action标识:cps推广记录  */
NSString * const CPS_ID_SIGN = @"cps";
/** 加密action标识:财富圈推广记录  */
NSString * const WEALTHCIRCLE_ID_SIGN = @"wealCir";


@end
