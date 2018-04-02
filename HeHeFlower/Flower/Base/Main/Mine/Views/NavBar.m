//
//  NavBar.m
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/16.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//
#import "NavBar.h"
#import "UIButton+KK.h"
@interface NavBar ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong)  UIButton *rightBtn;
@property (nonatomic,strong)  UIButton *leftBtn;
@end

@implementation NavBar

- (instancetype)initWithTitle:(NSString *)title WithleftBtTitle:(NSString *)lTitle WithLeftImage:(UIImage *)lImage WithRightBtTitle:(NSString *)rTitle WithRightImage:(UIImage *)rImage {
    
    self = [super initWithFrame:NAVBAR_FRAME];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"顶部 渐变"]];
        if (title) {
            _titleLabel = [[UILabel alloc] init];
            _titleLabel.textColor = [UIColor whiteColor];
            _titleLabel.text = title;
            _titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLabel];
        }
        if (lImage || lTitle) {
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_leftBtn];
            if (lImage) {
                [_leftBtn setImage:lImage forState:UIControlStateNormal];
            }else if (lTitle){
                [_leftBtn setTitle:lTitle forState:UIControlStateNormal];
            }
        }
        if (rImage || rTitle) {
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:_rightBtn];
            if (rImage) {
                [_rightBtn setImage:rImage forState:UIControlStateNormal];
            }else if (rTitle){
                [_rightBtn setTitle:rTitle forState:UIControlStateNormal];
            }
        }

    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title WithLeftImage:(UIImage *)lImage WithRightImage:(UIImage *)rImage{
    
    return [self initWithTitle:title WithleftBtTitle:nil WithLeftImage:lImage WithRightBtTitle:nil WithRightImage:rImage];;
    
}

- (instancetype)initWithTitle:(NSString *)title WithleftBtTitle:(NSString *)lTitle  WithRightBtTitle:(NSString *)rTitle{
    
    return [self initWithTitle:title WithleftBtTitle:lTitle WithLeftImage:nil WithRightBtTitle:rTitle WithRightImage:nil];
}

- (instancetype)initWithTitle:(NSString *)title{
    
    return [self initWithTitle:title WithleftBtTitle:nil WithLeftImage:nil WithRightBtTitle:nil WithRightImage:nil];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_leftBtn) {
        _leftBtn.frame = CGRectMake(15, 30, NAVBAR_HEIGHT - 38, NAVBAR_HEIGHT - 38);
        if (MSHIGHT == 812) {
            _leftBtn.frame = CGRectMake(15, 50, NAVBAR_HEIGHT - 58, NAVBAR_HEIGHT - 58);
        }
        [_leftBtn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (_rightBtn) {
        _rightBtn.frame = CGRectMake(MSWIDTH - (NAVBAR_HEIGHT - 35) - 15, 30, NAVBAR_HEIGHT - 38, NAVBAR_HEIGHT - 38);
        if (MSHIGHT == 812) {
            _rightBtn.frame = CGRectMake(MSWIDTH - (NAVBAR_HEIGHT - 55) - 15, 50, NAVBAR_HEIGHT - 58, NAVBAR_HEIGHT - 58);
        }
        [_rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (_titleLabel) {
        
        _titleLabel.frame = CGRectMake(60, 30, MSWIDTH - 120, NAVBAR_HEIGHT - 35);
        if (MSHIGHT == 812) {
            _titleLabel.frame = CGRectMake(60, 50, MSWIDTH - 120, NAVBAR_HEIGHT - 58);
        }
    }

    
}

- (void)leftAction
{
    if ([self.delegate respondsToSelector:@selector(leftItemClick)]) {
        [self.delegate leftItemClick];
    }
}

- (void)rightAction
{
    if ([self.delegate respondsToSelector:@selector(rightItemClick)]) {
        [self.delegate rightItemClick];
    }	
}

@end
