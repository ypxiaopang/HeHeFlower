//
//  UILabel+KK.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "UILabel+KK.h"

@implementation UILabel (KK)

+ (id)labelWithFrame:(CGRect)frame
				text:(NSString *)text
		   textColor:(UIColor *)textColor
			textFont:(float)textFont
			fitWidth:(BOOL)fitWidth
		   superview:(id)superview {
	
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	if (text.length > 0) {
		label.text = text;
	}
	if (textColor) {
		label.textColor = textColor;
	}
	if (textFont > 0) {
		label.font = [UIFont systemFontOfSize:textFont];
	}
	if (fitWidth) {
		label.adjustsFontSizeToFitWidth = YES;
	}else {
		label.adjustsFontSizeToFitWidth = NO;
	}
	label.textAlignment = NSTextAlignmentLeft;
	if (superview) {
		[superview addSubview:label];
	}
	return label;
}


@end
