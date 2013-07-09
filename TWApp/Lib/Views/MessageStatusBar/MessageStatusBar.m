//
//  CustomStatueBar.m
//  CustomStatueBar
//
//  Created by 贺 坤 on 12-5-21.
//  Copyright (c) 2012年 深圳市瑞盈塞富科技有限公司. All rights reserved.
//

#import "MessageStatusBar.h"

@implementation MessageStatusBar

+ (MessageStatusBar *)sharedInstance
{
    static MessageStatusBar *messageStatusBar = nil;
    if (!messageStatusBar)
    {
        messageStatusBar = [[MessageStatusBar alloc] init];
    }
    return messageStatusBar;
}

- (id)initWithFrame:(CGRect)frame
{
    CGRect rect = [UIApplication sharedApplication].statusBarFrame;
    self = [super initWithFrame:rect];
    if (self)
    {
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        self.backgroundColor = [UIColor blackColor];

        self.messageLbl = [[BBCyclingLabel alloc]initWithFrame:rect
                                             andTransitionType:BBCyclingLabelTransitionEffectScrollUp];
        self.messageLbl.backgroundColor = [UIColor clearColor];
        self.messageLbl.clipsToBounds = YES;
        self.messageLbl.textAlignment = UITextAlignmentCenter;
        self.messageLbl.adjustsFontSizeToFitWidth = YES;
        [self.messageLbl setText:@"" animated:NO];
        self.messageLbl.transitionDuration = 0.75;
        self.messageLbl.font = [UIFont systemFontOfSize:14];
        self.messageLbl.textColor = [UIColor colorWithWhite:1 alpha:1];
        [self addSubview:self.messageLbl];
    }
    return self;
}

- (void)show
{
    self.hidden = NO;
    [UIView animateWithDuration:0.5f
                     animations:^
    {
        self.alpha = 1.0;
    }
                     completion:^(BOOL finished)
    {
    }];
}

- (void)hideAfterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(hide) withObject:nil afterDelay:delay];
}

- (void)hide
{
    [UIView animateWithDuration:0.5f
                     animations:^
    {
        self.alpha = 0.0f;
    }
                     completion:^(BOOL finished)
    {
        self.hidden = YES;
    }];
}

- (void)updateMessage:(NSString *)message
{
    [self show];
    [self.messageLbl setText:message animated:YES];
}


@end
