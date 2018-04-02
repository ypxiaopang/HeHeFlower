//
//  SetCell.m
//  Flower
//
//  Created by Apple on 2018/3/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initView];
    }
    return self;
}

- (void)initView{
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 90, 20)];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.textColor = [ColorTools colorWithHexString:@"#5B5B5B"];
    _label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
    [self.contentView addSubview:_label];
    
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(MSWIDTH - 30, 20, 20, 20)];
    _img.image = [UIImage imageNamed:@"右箭头-2"];
    [self.contentView addSubview:_img];
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 59.5, MSWIDTH , 0.5)];
    view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    [self.contentView addSubview:view];
    
}

@end
