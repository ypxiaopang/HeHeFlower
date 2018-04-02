//
//  WINCopyLabel.m
//  JulijrP2P
//
//  Created by 韩 立 on 2017/2/6.
//  Copyright © 2017年 聚力金服网络科技有限公司. All rights reserved.
//

#import "WINCopyLabel.h"

@implementation WINCopyLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self pressAction];
    }
    return self;
}
// 初始化设置
- (void)pressAction {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPress.minimumPressDuration = 1;
    [self addGestureRecognizer:longPress];
}
// 使label能够成为响应事件
- (BOOL)canBecomeFirstResponder {
    return YES;
}

// 控制响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return action == @selector(customCopy:);
}

- (void)customCopy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
}

- (void)longPressAction:(UIGestureRecognizer *)recognizer {
    [self becomeFirstResponder];
    UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"拷贝单号" action:@selector(customCopy:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyItem, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

@end
