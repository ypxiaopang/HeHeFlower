//
//  MyTableView.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "MyTableView.h"
@implementation MyTableView

- (id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self) {
		if ([self respondsToSelector:@selector(setSeparatorInset:)]){
			[self setSeparatorInset:UIEdgeInsetsZero];
		}
		if ([self respondsToSelector:@selector(setLayoutMargins:)]){
			[self setLayoutMargins:UIEdgeInsetsZero];
		}
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
	self = [super initWithFrame:frame style:style];
	if (self) {
		self.backgroundColor = BGC;
		self.separatorStyle = UITableViewCellSeparatorStyleNone;
		self.showsVerticalScrollIndicator = NO;
		
		}
	return self;
}

//xib继承调用方法
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.backgroundColor = BGC;
        self.showsVerticalScrollIndicator = NO;
                
    }
    return self;
}


@end
