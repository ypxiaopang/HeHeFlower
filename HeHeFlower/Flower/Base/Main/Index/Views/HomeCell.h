//
//  HomeCell.h
//  Flower
//
//  Created by Apple on 2018/3/1.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property(nonatomic, strong)UILabel *label;//硬件名称
@property(nonatomic, strong)UIImageView *imgOfWare;//硬件图
@property(nonatomic, strong)UIImageView *flower;//花头像
@property(nonatomic, strong)UILabel *day;//监测天数
@end
