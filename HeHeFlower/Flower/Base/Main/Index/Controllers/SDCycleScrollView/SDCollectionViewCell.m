//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * 🌟🌟🌟 新建SDCycleScrollView交流QQ群：185534916 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * 新浪微博:GSD_iOS
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios
 *
 * 另（我的自动布局库SDAutoLayout）：
 *  一行代码搞定自动布局！支持Cell和Tableview高度自适应，Label和ScrollView内容自适应，致力于
 *  做最简单易用的AutoLayout库。
 * 视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * 用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 * GitHub：https://github.com/gsdios/SDAutoLayout
 *********************************************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"
#import "SDCustomMaskView.h"


@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
        //新增自定义View
        [self setupMuskView];
    }
    
    return self;
}
- (void)setupMuskView{
    _customBanner = [[SDCustomMaskView alloc]init];
    _customBanner.BackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width-30, self.bounds.size.height-30)];
    _customBanner.BackgroundView.image = [UIImage imageNamed:@"home_list_background"];
    [_customBanner addSubview:_customBanner.BackgroundView];
    
    _customBanner.TopLeftView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 4, 89, 55.5)];
    _customBanner.TopLeftView.image = [UIImage imageNamed:@"newtitle"];
    [_customBanner addSubview:_customBanner.TopLeftView];
    
    _customBanner.RateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, self.bounds.size.width-30, 54.5)];
    _customBanner.RateLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:40];
    _customBanner.RateLabel.textAlignment = NSTextAlignmentCenter;
    _customBanner.RateLabel.text = @"6.00%";
    _customBanner.RateLabel.textColor = [UIColor redColor];
    [_customBanner addSubview:_customBanner.RateLabel];
    
    _customBanner.RateShowLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 88.5, self.bounds.size.width-30, 11.5)];
    _customBanner.RateShowLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:11];
    _customBanner.RateShowLabel.textAlignment = NSTextAlignmentCenter;
    _customBanner.RateShowLabel.text = @"预期出借收益（年化）";
    _customBanner.RateShowLabel.textColor = [UIColor colorWithRed:91/255.0 green:91/255.0 blue:91/255.0 alpha:1];
    [_customBanner addSubview:_customBanner.RateShowLabel];
    
    _customBanner.LimitedView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 118, 10, 10)];
    _customBanner.LimitedView.image = [UIImage imageNamed:@"product_hint"];
    [_customBanner addSubview:_customBanner.LimitedView];
    
    _customBanner.LimitedDaysLabel = [[UILabel alloc] initWithFrame:CGRectMake(27, 118, 60, 10)];
    _customBanner.LimitedDaysLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    _customBanner.LimitedDaysLabel.textAlignment = NSTextAlignmentLeft;
    _customBanner.LimitedDaysLabel.text = @"500起投";
    _customBanner.LimitedDaysLabel.adjustsFontSizeToFitWidth = YES;
    _customBanner.LimitedDaysLabel.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    [_customBanner addSubview:_customBanner.LimitedDaysLabel];
    
    _customBanner.NewView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 118, 10, 10)];
    _customBanner.NewView.image = [UIImage imageNamed:@"product_hint"];
    [_customBanner addSubview:_customBanner.NewView];
    
    _customBanner.NewLabel = [[UILabel alloc] initWithFrame:CGRectMake(102, 118, self.bounds.size.width/2-76, 10)];
    _customBanner.NewLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    _customBanner.NewLabel.textAlignment = NSTextAlignmentLeft;
    _customBanner.NewLabel.text = @"到期还本付息";
    _customBanner.NewLabel.adjustsFontSizeToFitWidth = YES;
    _customBanner.NewLabel.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    [_customBanner addSubview:_customBanner.NewLabel];
    
    
    _customBanner.BounsView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2+26, 118, 10, 10)];
    _customBanner.BounsView.image = [UIImage imageNamed:@"product_hint"];
    [_customBanner addSubview:_customBanner.BounsView];
    
    _customBanner.BounsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2+38, 118, self.bounds.size.width/2-76, 10)];
    _customBanner.BounsLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
    _customBanner.BounsLabel.textAlignment = NSTextAlignmentLeft;
    _customBanner.BounsLabel.text = @"剩余金额：500元";
    _customBanner.BounsLabel.adjustsFontSizeToFitWidth = YES;
    _customBanner.BounsLabel.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1];
    [_customBanner addSubview:_customBanner.BounsLabel];
    [self.contentView addSubview:_customBanner];
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
}


- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isShow) {
        _customBanner.frame = CGRectMake(15, 10, self.bounds.size.width-30, self.bounds.size.height-20);
    }else{
        _customBanner.hidden = YES;
    }
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    } else {
        _imageView.frame = self.bounds;
        CGFloat titleLabelW = self.sd_width;
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.sd_height - titleLabelH;
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
}


@end
