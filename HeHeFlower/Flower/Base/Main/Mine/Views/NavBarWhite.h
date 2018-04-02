//
//  NavBarWhite.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/23.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NavBarWhiteDelegate <NSObject>

-(void)backItemClick;
-(void)nextItemClick;
@end

@interface NavBarWhite : UIView
@property (nonatomic,weak)id <NavBarWhiteDelegate>delegate;
/**
 *  右侧button
 */
@property (nonatomic,strong)  UIButton *rightBtn;
/*  左侧button
 */
@property (nonatomic,strong)  UIButton *leftBtn;

- (id)initWithFrame:(CGRect)frame WithTitle:(NSString *)title WithleftName:(NSString *)leftName WithRightName:(NSString *)rightName;
@end
