//
//  UIButton+KK.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "UIButton+KK.h"

@implementation UIButton (KK)



- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont*)font
{
	self.titleLabel.font = font;
	[self setTitle:title forState:UIControlStateNormal];
	CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:self.titleLabel.font.fontName size:self.titleLabel.font.pointSize+2]}];
	return titleSize;
}


@end
