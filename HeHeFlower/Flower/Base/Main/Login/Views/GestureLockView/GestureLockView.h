//
//  GestureLockView.h
//  JulijrP2P
//
//  Created by 韩 立 on 2016/12/25.
//  Copyright © 2016年 聚力金服网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GestureLockView;

@protocol GestureLockViewDelegate <NSObject>
@optional
- (void)gestureLockView:(GestureLockView *)gestureLockView didBeginWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(GestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode;

- (void)gestureLockView:(GestureLockView *)gestureLockView didCanceledWithPasscode:(NSString *)passcode;
@end

@interface GestureLockView : UIView

@property (nonatomic, assign) NSUInteger numberOfGestureNodes;
@property (nonatomic, assign) NSUInteger gestureNodesPerRow;

@property (nonatomic, strong) UIImage *normalGestureNodeImage;
@property (nonatomic, strong) UIImage *selectedGestureNodeImage;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong, readonly) UIView *contentView;//the container of the gesture notes
@property (nonatomic, assign) UIEdgeInsets contentInsets;

@property (nonatomic, weak) id<GestureLockViewDelegate> delegate;

@end
