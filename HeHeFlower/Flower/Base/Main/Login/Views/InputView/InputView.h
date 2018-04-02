//
//  InputView.h
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputView : UIView

@property (nonatomic,strong) UITextField *inputField;
@property (nonatomic,strong) UILabel *leftImg;
@property (nonatomic,strong) UILabel *bottomLine;

- (id)initWithImgName:(NSString *)imgName WithSelectImgName:(NSString *)selectImgName placeContent:(NSString *)content;

@end
