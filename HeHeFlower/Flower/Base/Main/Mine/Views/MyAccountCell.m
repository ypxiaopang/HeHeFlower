//
//  MyAccountCell.m
//  Flower
//
//  Created by Apple on 2018/3/14.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "MyAccountCell.h"

@interface MyAccountCell()

@property(nonatomic, strong)UIImageView *img;//小图标
@property(nonatomic, strong)UILabel *label;//文字
@property(nonatomic, strong)UIImageView *next;//箭头

@end

@implementation MyAccountCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 20, 20)];
    [self.contentView addSubview:_img];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake( 50, 20, 70, 20)];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [ColorTools colorWithHexString:@"#5B5B5B"];
    _label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
    [self.contentView addSubview:_label];
    
    _next = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH - 30, 20, 20, 20)];
    _next.image = [UIImage imageNamed:@"右箭头-2"];
    [self.contentView addSubview:_next];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 59.5, MSWIDTH , 0.5)];
    view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    [self.contentView addSubview:view];

    
}


- (void)setLabelText:(NSString *)labelText{
    _label.text = labelText;
}

- (void)setIcon:(UIImage *)icon{
    _img.image = icon;
}

@end
