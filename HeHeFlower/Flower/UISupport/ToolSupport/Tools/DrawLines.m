//
//  DrawLines.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "DrawLines.h"

@implementation DrawLines

- (void)drawRoundedRectanglePath:(CGRect)rect color:(UIColor *)color Radius:(float)radius lineWidth:(float)linewidth
{
	
	UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height) cornerRadius: 9];
	[[UIColor whiteColor] setFill];
	[roundedRectanglePath fill];
	[color setStroke];
	roundedRectanglePath.lineWidth = 1;
	[roundedRectanglePath stroke];
	
}

-(void)drawBezierPath:(CGPoint)startpoint lastpoint:(CGPoint)lastpoint color:(UIColor *)color  lineWidth:(float)linewidth
{
	
	UIBezierPath* bezierPath = [UIBezierPath bezierPath];
	[bezierPath moveToPoint: CGPointMake(startpoint.x, startpoint.y)];
	[bezierPath addLineToPoint: CGPointMake(lastpoint.x,lastpoint.y)];
	[[UIColor whiteColor] setFill];
	[bezierPath fill];
	[color setStroke];
	bezierPath.lineWidth = linewidth;
	[bezierPath stroke];
	
}


@end
