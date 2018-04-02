//
//  NavBarWhite.m
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/23.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import "NavBarWhite.h"
#import "UIButton+KK.h"
@interface NavBarWhite ()
/**
 *  中间title
 */
@property (nonatomic,strong) UILabel *titleLabel;

@end
@implementation NavBarWhite

- (id)initWithFrame:(CGRect)frame WithTitle:(NSString *)title WithleftName:(NSString *)leftName WithRightName:(NSString *)rightName
{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"colour"]];
        //self.backgroundColor = [UIColor whiteColor];
        // 中间title
        if (title.length) {
            _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSWIDTH/2 - 60, 40, 120, self.frame.size.height - 20)];
            _titleLabel.textColor = [UIColor whiteColor];
            _titleLabel.text = title;
            _titleLabel.font = [UIFont systemFontOfSize:17.0];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLabel];
        }
        
        // 左边btn
        if (leftName.length) {
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_leftBtn setImage:[UIImage imageNamed:@"whiteBack"] forState:UIControlStateNormal];
            [_leftBtn setTitle:leftName forState:UIControlStateNormal];
            _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [_leftBtn setTitleColor:baseLightBlackColor forState:UIControlStateNormal];
            CGSize leftBtnSize = [_leftBtn sizeWithTitle:leftName font:_leftBtn.titleLabel.font];
            _leftBtn.frame = CGRectMake(0, 20, leftBtnSize.width + 20, self.frame.size.height - 20);
            [_leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_leftBtn];
        }
        
        // 右边btn
        if(rightName.length){
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [_rightBtn setTitle:rightName forState:UIControlStateNormal];
            _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
            [_rightBtn setTitleColor:baseLightBlackColor forState:UIControlStateNormal];
            CGSize rightBtnSize = [_rightBtn sizeWithTitle:rightName font:_rightBtn.titleLabel.font];
            _rightBtn.frame = CGRectMake(MSWIDTH - rightBtnSize.width - 10, 20, rightBtnSize.width , self.frame.size.height - 20);
            [_rightBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_rightBtn];
        }
        
        
        CGFloat titleWidth = self.frame.size.width-CGRectGetMaxX(_leftBtn.frame)-CGRectGetWidth(_rightBtn.frame)-40;
        if (MSHIGHT == 812) {
                _titleLabel.frame = CGRectMake((MSWIDTH-titleWidth)*0.5, 28, titleWidth, self.frame.size.height - 20);
        }else{
        _titleLabel.frame = CGRectMake((MSWIDTH-titleWidth)*0.5, 20, titleWidth, self.frame.size.height - 20);
        }
        /*
        UIImageView *shaowLine = [[UIImageView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT-0.5, MSWIDTH, 0.5)];
        shaowLine.image = [ColorTools imageWithColor:UIColorFromHex(0xB2B6B4)];
        [self addSubview:shaowLine];
         */
    }
    return self;
}

////frame等比例缩放
//CG_INLINE CGRect
//
//TS_CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
//
//{
//    
//    
//    
//    AppDelegate *myDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    CGRect rect;
//    
//    rect.origin.x = x * myDelegate.autoSizeScaleX;
//    
//    rect.origin.y = y * myDelegate.autoSizeScaleY;
//    
//    rect.size.width = width * myDelegate.autoSizeScaleX;
//    
//    rect.size.height = height * myDelegate.autoSizeScaleY;
//    
//    return rect;
//    
//}

- (void)backAction
{
    if ([self.delegate respondsToSelector:@selector(backItemClick)]) {
        [self.delegate backItemClick];
    }
}

- (void)nextAction
{
    if ([self.delegate respondsToSelector:@selector(nextItemClick)]) {
        [self.delegate nextItemClick];
    }
}

@end
