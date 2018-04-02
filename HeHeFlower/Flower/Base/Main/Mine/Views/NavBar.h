//
//  NavBar.h
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/16.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavBarDelegate <NSObject>

@optional
-(void)leftItemClick;
-(void)rightItemClick;
@end

@interface NavBar : UIView
@property (nonatomic,weak)id <NavBarDelegate>delegate;


- (instancetype)initWithTitle:(NSString *)title WithleftBtTitle:(NSString *)lTitle WithLeftImage:(UIImage *)lImage WithRightBtTitle:(NSString *)rTitle WithRightImage:(UIImage *)rImage;

- (instancetype)initWithTitle:(NSString *)title WithLeftImage:(UIImage *)lImage WithRightImage:(UIImage *)rImage;

- (instancetype)initWithTitle:(NSString *)title WithleftBtTitle:(NSString *)lTitle  WithRightBtTitle:(NSString *)rTitle;

- (instancetype)initWithTitle:(NSString *)title;

@end
