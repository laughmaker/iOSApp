//
//  StatusBarLoading.m
//  TWApp
//
//  Created by line0 on 13-7-9.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "StatusBarLoading.h"

@interface StatusBarLoading ()
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) MTActivityIndicatorView *customLoading;
@property (strong, nonatomic) NSTimer       *timer;

@end

@implementation StatusBarLoading

kSingleton(StatusBarLoading)

- (id)initWithFrame:(CGRect)frame
{
    CGRect rect = [UIApplication sharedApplication].statusBarFrame;
    self = [super initWithFrame:rect];
    if (self)
    {
        self.windowLevel = UIWindowLevelStatusBar + 1.0f;
        self.backgroundColor = [UIColor blackColor];
        self.loadingStyle = kCustomStyle;
        self.dotColor = [UIColor whiteColor];
        self.dotRadius = 2.5;
        self.dotCount = 3;
    }
    return self;
}

- (void)setLoadingStyle:(LoadingStyle)loadingStyle
{
    if (_loadingStyle != loadingStyle)
    {
        _loadingStyle = loadingStyle;
        if (_loadingStyle == kCustomStyle)
        {
            [self.pageControl removeFromSuperview];
            [self addCustomLoading];
        }
        else if (_loadingStyle == kPageControlStyle)
        {
            [self.customLoading removeFromSuperview];
            [self addPageControl];
        }
    }
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    [self.customLoading setDotColor:dotColor];
    if ([self.pageControl respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)])
    {
        [self.pageControl setCurrentPageIndicatorTintColor:dotColor];
    }
}

- (void)setDotRadius:(CGFloat)dotRadius
{
    _dotRadius = dotRadius;
    [self.customLoading setDotRadius:dotRadius];
}

- (void)setDotCount:(NSUInteger)dotCount
{
    _dotCount = dotCount;
    [self.pageControl setNumberOfPages:dotCount];
    [self.customLoading setDotCount:dotCount];
}

- (void)addCustomLoading
{
    self.customLoading = [[MTActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 10.0f)];
    self.customLoading.animationDuration = 4.0f;
    [self addSubview:self.customLoading];
}

- (void)addPageControl
{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    [self.pageControl setNumberOfPages:5];
    [self addSubview:self.pageControl];
}

- (void)pageControlValueChanged
{
    NSInteger idx = self.pageControl.currentPage;
    if (idx == self.pageControl.numberOfPages - 1)
    {
        [self.pageControl setCurrentPage:0];
    }
    else
    {
        [self.pageControl setCurrentPage:idx+1];
    }
}

- (void)startPageControlAnimating
{
    if (!self.timer)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(pageControlValueChanged) userInfo:nil repeats:YES];
    }
}

- (void)stopPageControlAnimating
{
    [self.timer invalidate];
    self.timer = nil;
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
    
    if (self.loadingStyle == kPageControlStyle)
    {
        [self startPageControlAnimating];
    }
    else if (self.loadingStyle == kCustomStyle)
    {
        [self.customLoading startAnimating];
    }
}

- (void)hideAfterDelay:(NSTimeInterval)delay
{
    [self performSelector:@selector(hide) withObject:nil afterDelay:delay];
}

- (void)hide
{    
    if (self.loadingStyle == kPageControlStyle)
    {
        [self stopPageControlAnimating];
    }
    else if (self.loadingStyle == kCustomStyle)
    {
        [self.customLoading stopAnimating];
    }

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


@end
