//
//  ZhuView.m
//  Flower
//
//  Created by Apple on 2018/3/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ZhuView.h"
@implementation ZhuView

- (instancetype)initWithFrame:(CGRect)frame :(NSArray *)arrayOfDay :(NSArray  *)arrayOfValue :(UIColor *)color{
    self = [super initWithFrame:frame];
    
    if (self) {
        _labelsmall = [[UILabel alloc]init];
        _arrOfDay = [NSArray array];
        _arrOfDay = arrayOfDay;
        _arrOfValue = [NSArray array];
        _arrOfValue = arrayOfValue;
        for (int i = 0; i< arrayOfDay.count; i++) {
            
            NSInteger gao = [arrayOfValue[i] integerValue];
            
            _btn = [[UIButton alloc]init];
            
            UILabel *labelText = [[UILabel alloc]init];
         
            UIButton *back = [[UIButton alloc]init];
            
            if (arrayOfDay.count == 7) {
             
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(2+( (MSWIDTH/arrayOfDay.count - 4))/2-1.5, 103, self.frame.size.width - (2+( (MSWIDTH/arrayOfDay.count - 4))/2-1.5)*2, 0.5)];
                view.backgroundColor = [UIColor lightGrayColor];
                [self addSubview:view];
                
                back.frame = CGRectMake(15 + i*MSWIDTH/arrayOfDay.count, 0,MSWIDTH/arrayOfDay.count - 30 , 100);
                back.layer.masksToBounds = YES;
                back.layer.cornerRadius = 5.0f;
                back.backgroundColor = [ColorTools colorWithHexString:@"#eeeeee"];
                [self addSubview:back];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                 button.frame = CGRectMake(15 + i*MSWIDTH/arrayOfDay.count, 100-gao,MSWIDTH/arrayOfDay.count - 30 , gao );
                button.backgroundColor = color;
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 5.0f;
                button.tag = i;
                [button addTarget:self action:@selector(buttonAction:forEvent:)
                 forControlEvents:UIControlEventAllTouchEvents];
                [self addSubview:button];
                
                labelText.font = [UIFont systemFontOfSize:12];
                labelText.frame = CGRectMake(15 + i*MSWIDTH/arrayOfDay.count, 105,MSWIDTH/arrayOfDay.count - 30 , 15);
                labelText.textAlignment = NSTextAlignmentCenter;
                labelText.textColor = [UIColor lightGrayColor];
                [self addSubview:labelText];
          
                _arrDay = [NSArray array];
                _arrValue = [NSArray array];
                _arrValue = arrayOfValue;
                _arrDay = arrayOfDay;
                
                UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(15 + i*MSWIDTH/arrayOfDay.count  +( (MSWIDTH/arrayOfDay.count - 30))/2-1.5, 102,3 , 3 )];
                    view1.backgroundColor = [UIColor lightGrayColor];
                    [self addSubview:view1];
                    view1.layer.masksToBounds = YES;
                    view1.layer.cornerRadius = 2.0f;
                
            }else if (arrayOfDay.count == 24){
                _arrDay = [NSArray array];
                _arrValue = [NSArray array];
                _arrValue = arrayOfValue;
                _arrDay = arrayOfDay;

                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(2+( (MSWIDTH/arrayOfDay.count - 4))/2-1.5, 103, self.frame.size.width - (2+( (MSWIDTH/arrayOfDay.count - 4))/2-1.5)*2, 0.5)];
                view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.01];
                [self addSubview:view];
                
                if (i == 0||i == 5||i==11||i == 17||i==23 ) {
                    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(2 + i*MSWIDTH/arrayOfDay.count  +( (MSWIDTH/arrayOfDay.count - 4))/2-1.5, 102,3 , 3 )];
                    view1.backgroundColor = [UIColor lightGrayColor];
                    [self addSubview:view1];
                    view1.layer.masksToBounds = YES;
                    view1.layer.cornerRadius = 2.0f;
                }
                back.frame = CGRectMake(2 + i*MSWIDTH/arrayOfDay.count, 0,MSWIDTH/arrayOfDay.count - 4 , 100 );
                back.layer.masksToBounds = YES;
                back.layer.cornerRadius = 4.0f;
                back.backgroundColor = [ColorTools colorWithHexString:@"#eeeeee"];
                [self addSubview:back];
           
                labelText.frame = CGRectMake(2 + i*MSWIDTH/arrayOfDay.count, 103,MSWIDTH/arrayOfDay.count - 4 , 15);
                labelText.textColor = [UIColor lightGrayColor];
                [self addSubview:labelText];
                   labelText.font = [UIFont systemFontOfSize:8];
                labelText.textAlignment = NSTextAlignmentCenter;
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(2 + i*MSWIDTH/arrayOfDay.count, 100-gao,MSWIDTH/arrayOfDay.count - 4 , gao );
                button.backgroundColor = color;
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 5.0f;
                button.tag = i;
                [button addTarget:self action:@selector(buttonAction:forEvent:)
                 forControlEvents:UIControlEventAllTouchEvents];
                [self addSubview:button];
            }else{
                _arrDay = [NSArray array];
                _arrValue = [NSArray array];
                _arrValue = arrayOfValue;
                _arrDay = arrayOfDay;


                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(2+( (MSWIDTH/arrayOfDay.count - 4))/2-1.5, 103, self.frame.size.width - (2+( (MSWIDTH/arrayOfDay.count - 4))/2-1.5)*2, 0.5)];
                view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.01];
                [self addSubview:view];
                
                if (i == 0||i == 6||i==12||i == 18||i==24 ||i == arrayOfDay.count - 1) {
                    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(2 + i*MSWIDTH/arrayOfDay.count  +( (MSWIDTH/arrayOfDay.count - 4))/2-1.5, 102,3 , 3 )];
                    view1.backgroundColor = [UIColor lightGrayColor];
                    [self addSubview:view1];
                    view1.layer.masksToBounds = YES;
                    view1.layer.cornerRadius = 2.0f;
                }
                
                back.frame = CGRectMake(2 + i*MSWIDTH/arrayOfDay.count, 0,MSWIDTH/arrayOfDay.count - 4 , 100 );
                back.layer.masksToBounds = YES;
                back.layer.cornerRadius = 4.0f;
                back.backgroundColor = [ColorTools colorWithHexString:@"#eeeeee"];
                [self addSubview:back];
                
                labelText.frame = CGRectMake( i*MSWIDTH/arrayOfDay.count, 103,MSWIDTH/arrayOfDay.count  , 15);
                labelText.textColor = [UIColor lightGrayColor];
                [self addSubview:labelText];
                labelText.font = [UIFont systemFontOfSize:8];
                labelText.textAlignment = NSTextAlignmentCenter;
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                button.frame = CGRectMake(2 + i*MSWIDTH/arrayOfDay.count, 100-gao,MSWIDTH/arrayOfDay.count - 4 , gao );
                button.backgroundColor = color;
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 5.0f;
                button.tag = i;
                [button addTarget:self action:@selector(buttonAction:forEvent:)
                 forControlEvents:UIControlEventAllTouchEvents];
                [self addSubview:button];

             
            }

            labelText.text = arrayOfDay[i];
            
        }

        
    }
    return self;
    
}

- (void)TouchDown:(UIButton *)btn{
    
    btn.backgroundColor = [UIColor blackColor];
    
}

- (void)buttonAction:(UIButton *)btn forEvent:(UIEvent *)event{
    UITouchPhase phase = event.allTouches.anyObject.phase;

    if (phase == UITouchPhaseBegan) {
        NSLog(@"press");
     
        _labelsmall.font = [UIFont systemFontOfSize:8];
        _labelsmall.frame = CGRectMake(15 + btn.tag*MSWIDTH/_arrDay.count, -15,MSWIDTH/_arrDay.count - 30 , 15);
        _labelsmall.textAlignment = NSTextAlignmentCenter;
        _labelsmall.textColor = [UIColor lightGrayColor];
        _labelsmall.text =_arrValue[btn.tag];
        [self addSubview:_labelsmall];
        btn.alpha = 0.5;
        
    }
    else if(phase == UITouchPhaseEnded){
               _labelsmall.text = @"";
        [_labelsmall removeFromSuperview];
        NSLog(@"release");
        btn.alpha = 1;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
}

@end
