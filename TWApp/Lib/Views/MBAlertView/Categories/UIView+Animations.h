//
//  UIView+Animations.h
//  TwoTask
//
//  Created by M B. Bitar on 12/21/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)
-(void)animationPop;
-(void)addFadingAnimation;
-(void)removePulseAnimation;
-(BOOL)hasPulseAnimation;
-(void)addPulsingAnimation;
-(void)addFadingAnimationWithDuration:(CGFloat)duration;

// other
-(void)centerViewsVerticallyWithin:(NSArray*)views;
-(void)resignFirstRespondersForSubviews;
@end
