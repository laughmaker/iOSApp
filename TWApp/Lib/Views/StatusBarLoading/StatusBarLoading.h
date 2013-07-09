//
//  StatusBarLoading.h
//  TWApp
//
//  Created by line0 on 13-7-9.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTActivityIndicatorView.h"

//
typedef enum LoadingStyle:NSInteger
{
    kPageControlStyle,
    kCustomStyle
}LoadingStyle;

@interface StatusBarLoading : UIWindow
//默认为kCustomStyle
@property (assign, nonatomic) LoadingStyle  loadingStyle;

//默认为白色
@property (strong, nonatomic) UIColor       *dotColor;

//默认为5
@property (assign, nonatomic) NSUInteger    dotCount;

//LoadingStyle为kPageControlStyle有值，可自定义外观风格，否则返回nil
@property (strong, nonatomic, readonly) UIPageControl *pageControl;

//LoadingStyle为kCustomStyle有值，可自定义外观风格，否则返回nil
@property (strong, nonatomic, readonly) MTActivityIndicatorView *customLoading;

//LoadingStyle为kCustomStyle可设置,默认为2.5
@property (assign, nonatomic) CGFloat dotRadius;

+ (id)sharedInstance;
- (void)show;
- (void)hideAfterDelay:(NSTimeInterval)delay;

@end
