//
//  Animations.m
//  DrawAnimations
//
//  Created by gitBurning on 14/12/1.
//  Copyright (c) 2014年 gitBurning. All rights reserved.
//

#import "Animations.h"

@interface Animations()

@property(nonatomic, retain)CAKeyframeAnimation *animation;

@end

@implementation Animations
+(void)cirCleAnimationWithLayerWithView:(UIView *)view
                  isRemovedOnCompletion:(BOOL)removedOnCompletion
{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
    
    CGAffineTransform t2=view.layer.affineTransform;
    
    
     CGPathAddArc(ovalfromarc,&t2 , kScreenWidth/2, kScreenHeight/2, kScreenWidth/2-50, 0, M_PI*2, YES);
    
    [animation setPath:ovalfromarc];
    
    [animation setDuration:5.0];
    [animation setSpeed:0.1f];
    animation.repeatCount = 0;
    if (removedOnCompletion) {
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
    }
    [view.layer addAnimation:animation forKey:@"position"];
    
}

-(void)initCirCleAnimationWithLayerWithView:(UIView *)view
                      isRemovedOnCompletion:(BOOL)removedOnCompletion{
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
    
    CGAffineTransform t2=view.layer.affineTransform;
    
    
    CGPathAddArc(ovalfromarc,&t2 , kScreenWidth/2, kScreenHeight/2, kScreenWidth/2-50, 0, M_PI*2, NO);
    
    [animation setPath:ovalfromarc];
    
    [animation setDuration:5.0f];
    [animation setSpeed:0.1f];
    animation.repeatCount = 0;
    if (removedOnCompletion) {
        animation.autoreverses = NO;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
    }
    [view.layer addAnimation:animation forKey:@"position"];
}

-(void)initCirCleAnimationWithLayerWithView:(UIView *)view
                      isRemovedOnCompletion:(BOOL)removedOnCompletion
                                   duration:(float)interval{
    _animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    _animation.delegate = self;
    CGMutablePathRef ovalfromarc = CGPathCreateMutable();
    
    CGAffineTransform t2=view.layer.affineTransform;
    

    CGPathAddArc(ovalfromarc,&t2 , kScreenWidth/2, kScreenHeight/2, kScreenWidth/2-50, 0, M_PI*2*(int)interval, NO);
    
    [_animation setPath:ovalfromarc];
    [_animation setDuration:interval];
    [_animation setSpeed:interval*0.2f];
    _animation.repeatCount = 0;
    if (removedOnCompletion) {
        _animation.autoreverses = NO;
        _animation.fillMode = kCAFillModeForwards;
        _animation.removedOnCompletion = NO;
    }
    [view.layer addAnimation:_animation forKey:@"position"];
}

-(void)animationDidStart:(CAAnimation *)anim{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didStartAnimation)]){
        [self.delegate didStartAnimation];
    }

    NSLog(@"start--------------------");

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"flag=%d",flag);
    //如果按返回键,flag为0,此时调用didFinishAnimation会出现内存错误
    if (flag == true){
      if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishAnimation)]){
            [self.delegate didFinishAnimation];
      }

    }
    NSLog(@"end--------------------");
    

}


@end
