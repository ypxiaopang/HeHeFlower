//
//  SDCustomMaskView.m
//  Pods
//
//  Created by 韩 立 on 2017/1/21.
//
//

#import "SDCustomMaskView.h"

@implementation SDCustomMaskView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialization];
    
}

- (void)initialization
{
    
}


@end
