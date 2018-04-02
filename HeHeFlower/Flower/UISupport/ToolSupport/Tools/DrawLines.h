//
//  DrawLines.h
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
@interface DrawLines : NSObject

//绘制表格边框
- (void)drawRoundedRectanglePath:(CGRect)rect color:(UIColor *)color Radius:(float)radius lineWidth:(float)linewidth;

//绘制线条
-(void)drawBezierPath:(CGPoint)startpoint lastpoint:(CGPoint)lastpoint color:(UIColor *)color  lineWidth:(float)linewidth;

@end
