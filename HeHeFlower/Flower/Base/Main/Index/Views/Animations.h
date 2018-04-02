//
//  Animations.h
//  DrawAnimations
//
//  Created by gitBurning on 14/12/1.
//  Copyright (c) 2014年 gitBurning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@protocol CustomerAnimationsDelegate<NSObject>


-(void)didStartAnimation;
-(void)didFinishAnimation;

@end

@interface Animations : NSObject<CAAnimationDelegate>

@property(nonatomic,assign)id<CustomerAnimationsDelegate> delegate;

+(void)cirCleAnimationWithLayerWithView:(UIView*)view
                  isRemovedOnCompletion:(BOOL)removedOnCompletion;

-(void)initCirCleAnimationWithLayerWithView:(UIView*)view
                      isRemovedOnCompletion:(BOOL)removedOnCompletion;

-(void)initCirCleAnimationWithLayerWithView:(UIView*)view
                      isRemovedOnCompletion:(BOOL)removedOnCompletion
                                   duration:(float)interval;


@end
