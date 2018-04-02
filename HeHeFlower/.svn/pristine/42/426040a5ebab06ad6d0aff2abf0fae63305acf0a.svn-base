//
//  LCESwitch.m
//  LCESwitch
//
//  Created by juziwl on 15/6/25.
//  Copyright (c) 2015年 juziwl. All rights reserved.
//

#import "LCESwitch.h"
@interface LCESwitch ()


@end


@implementation LCESwitch


+ (instancetype)lceSwitchCGRect:(CGRect)frame masks:(BOOL)masks;
{
    
    LCESwitch *headerView = [[LCESwitch alloc] initWithFrame:CGRectMake(CGRectGetMinX(frame), CGRectGetMidY(frame), CGRectGetWidth(frame), 40)];
    if (masks) {
        headerView.layer.masksToBounds=YES;
        headerView.layer.cornerRadius=20.0f;
    }
    
    return headerView;
}

-(void)setTitleArray:(NSArray *)titleArray
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = baseBorderColor.CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.masksToBounds=YES;
    
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.layer.cornerRadius=self.frame.size.height/2;
        
        UIView *sliderView=[[UIView alloc]initWithFrame:CGRectMake(0, 1, weakSelf.frame.size.width/titleArray.count, weakSelf.frame.size.height-2)];
        sliderView.layer.cornerRadius=sliderView.frame.size.height/2;
        sliderView.layer.masksToBounds=YES;
        sliderView.backgroundColor=baseOrangeColor;
        [weakSelf addSubview:sliderView];
        weakSelf.sliderView=sliderView;
        
        [titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=775566+idx;
            btn.frame=CGRectMake((weakSelf.frame.size.width/titleArray.count)*idx, 4, weakSelf.frame.size.width/titleArray.count, weakSelf.frame.size.height-8
                                 );
            [btn setExclusiveTouch:YES];
            btn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
            [btn setTitle:obj forState:UIControlStateNormal];
            
            [btn setTitleColor:(idx == 0)?[UIColor whiteColor]:baseDarkGrayColor forState:UIControlStateNormal];
            
            btn.layer.cornerRadius=btn.frame.size.height/2;
            [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
            [weakSelf addSubview:btn];
        }];
        
    });
    
    
}


-(void)clickEvent:(UIButton *)sender
{
    UIButton *button=(UIButton *)[self viewWithTag:sender.tag];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSInteger index=sender.tag-775566;
    
    if(index==self.currentIndex)
    {
        return;
    }else
    {
        UIButton *button=(UIButton *)[self viewWithTag:(NSInteger)(self.currentIndex+775566)];
        [button setTitleColor:baseDarkGrayColor forState:UIControlStateNormal];
        
    }
    
    [UIView animateWithDuration:0.35f animations:^{
        
        self.sliderView.frame= CGRectMake(sender.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
    }completion:^(BOOL finished) {
        
    }];
    
    self.currentIndex=index;
    
    if (self.selectBlock){
        self.selectBlock(self.currentIndex);
    }
}

@end
