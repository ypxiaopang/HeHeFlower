//
//  EditView.m
//  JulijrP2P
//
//  Created by 韩 立 on 2017/1/16.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import "EditView.h"
#define kImgHeight  self.frame.size.height * 0.9
@interface EditView()
@property (nonatomic,strong) UIView *superView;

@end

@implementation EditView

- (id)initWithTitle:(NSString *)title WithPlaceContent:(NSString *)content
{
	if (self = [super init]) {
		
		_superView = self;
		// 左边的图片
		UILabel *titleLabel = [[UILabel alloc]init];
		titleLabel.text = title;
		titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
		[self addSubview:titleLabel];
		[titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(_superView.mas_top).with.offset(0);
			make.left.equalTo(_superView.mas_left).with.offset(10);
			make.size.mas_equalTo(CGSizeMake(MSWIDTH/4 ,ITHIGHT));
		}];
		// 右边的输入框
		_inputField = [[UITextField alloc]init];
		_inputField.placeholder = content;
		[_inputField setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:13]];
		_inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_inputField.secureTextEntry = YES;
		[self addSubview:_inputField];
		[_inputField mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(_superView.mas_top).with.offset(0);
			make.left.equalTo(_superView.mas_left).with.offset(MSWIDTH/4 + 30);
			make.right.equalTo(_superView.mas_right).with.offset(0);
			make.height.mas_equalTo(ITHIGHT);
		}];
		
		
		// 底部线条
		UILabel *lineLabel = [[UILabel alloc]init];
		lineLabel.backgroundColor = [UIColor lightGrayColor];
		[self addSubview:lineLabel];
		[lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(_superView.mas_left).with.offset(0);
			make.right.equalTo(_superView.mas_right).with.offset(0);
			make.bottom.equalTo(_superView.mas_bottom).with.offset(1);
			make.height.mas_equalTo(0.5);
		}];
	}
	return self;

}

@end
