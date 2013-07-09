//
//  MTActivityIndicatorView.h
//  testAnimation
//
//  Created by jesse on 12-7-5.
//  Copyright (c) 2012年 Jesse Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMTActivityIndicatorViewCycle -1

@interface MTActivityIndicatorView : UIView

@property (nonatomic, strong) UIColor *dotColor;

@property (nonatomic, assign) CGFloat animationDuration;                //animation duration    default 4.0f
@property (nonatomic, assign) CGFloat ratioOfMaxAndMinVelocity;         //ratio of max velocity and min velocity    default 10.0f
@property (nonatomic, assign) CGFloat accelerateDistance;               //accelerate distance ratio (between 0.0 - 1.0) default 0.375f
@property (nonatomic, assign) CGFloat decelerateDistance;               //decelerate distance ratio (between 0.0 - 1.0)  accelerateDistance + decelerateDistance <= 1.0     defualt 0.375f
@property (nonatomic, assign) CGFloat repeatInterval;                   //time interval between animations  defualt 2.0f
@property (nonatomic, assign) CGFloat dotInterval;                      //time interval between dots    defualt 0.3f
@property (nonatomic, assign) NSInteger dotCount;                       //number of dots    default 5
@property (nonatomic, assign) BOOL repeated;                            //need repeated     defualt YES
@property (nonatomic, assign) CGFloat dotRadius;//default 2.5


- (void)startAnimating;
- (void)stopAnimating;
- (void)stopAnimatingNeedDelay:(NSTimeInterval)time;
- (BOOL)isAnimating;

@end
