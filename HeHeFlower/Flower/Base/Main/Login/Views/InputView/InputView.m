//
//  InputView.m
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import "InputView.h"

#define kImgHeight  self.frame.size.height * 0.9
@interface InputView()
@property (nonatomic,strong) UIView *superView;

@end

@implementation InputView

- (id)initWithImgName:(NSString *)imgName WithSelectImgName:(NSString *)selectImgName placeContent:(NSString *)content{
	if (self = [super init]) {
		
		_superView = self;
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        //下面的线
        _bottomLine = [[UILabel alloc]init];
        [_bottomLine setBackgroundColor:[UIColor colorWithRed:(172.0 / 255.0f) green:(172.0 / 255.0f) blue:(172.0 / 255.0f) alpha:1.0f]];
        [self addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.top.equalTo(_superView.mas_top).with.offset(60);
            make.left.equalTo(_superView.mas_left).with.offset(0);
            make.right.equalTo(_superView.mas_right).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(_superView.frame.size.width,0.5));
            make.bottom.equalTo(_superView.mas_bottom).with.offset(11);

        }];
        
		// 左边的图片
//        _leftImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName] highlightedImage:[UIImage imageNamed:selectImgName]];
        _leftImg = [[UILabel alloc]init];
        _leftImg.text = imgName;
        _leftImg.textColor = basegrayColor;
        _leftImg.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:15.0 ];
		[self addSubview:_leftImg];
		[_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(_superView.mas_top).with.offset(21);
			make.left.equalTo(_superView.mas_left).with.offset(10);
            //make.bottom.equalTo(_superView.mas_bottom).with.offset(-7);
            make.size.mas_equalTo(CGSizeMake(60,20));
           // make.centerY.mas_equalTo(_superView.mas_centerY);
        }];
		
		// 中间的输入框
		_inputField = [[UITextField alloc]init];
        [_inputField setBorderStyle:UITextBorderStyleNone];
        _inputField.backgroundColor = [UIColor whiteColor];
		_inputField.placeholder = content;
		_inputField.keyboardType = UIKeyboardTypeDefault;
		[_inputField setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:14.0]];
		_inputField.clearButtonMode = UITextFieldViewModeWhileEditing;
		[self addSubview:_inputField];
		[_inputField mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(_superView.mas_top).with.offset(3);
			make.left.equalTo(_leftImg.mas_right).with.offset(40);
			make.right.equalTo(_superView.mas_right).with.offset(-5);
            make.bottom.equalTo(_superView.mas_bottom).with.offset(10);
		}];
	}
	return self;
}

@end
