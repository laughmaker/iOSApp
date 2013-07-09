//
//  UIView+Animations.m
//  TwoTask
//
//  Created by M B. Bitar on 12/21/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

#import "UIView+Animations.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Animations)
-(void)animationPop;
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1.0);
    CATransform3D scale2 = CATransform3DMakeScale(1.35, 1.35, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.8, 0.8, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.duration = 0.4;
    
    [self.layer addAnimation:animation forKey:@"popup"];
}

-(void)addPulsingAnimation;
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    CATransform3D scale1 = CATransform3DMakeScale(1.0, 1.0, 1.0);
    CATransform3D scale2 = CATransform3DMakeScale(1.15, 1.15, 1);
    CATransform3D scale3 = CATransform3DMakeScale(0.8, 0.8, 1);
    CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
    
    NSArray *frameValues = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:scale1],
                            [NSValue valueWithCATransform3D:scale2],
                            [NSValue valueWithCATransform3D:scale3],
                            [NSValue valueWithCATransform3D:scale4],
                            nil];
    [animation setValues:frameValues];
    
    NSArray *frameTimes = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0.0],
                           [NSNumber numberWithFloat:0.5],
                           [NSNumber numberWithFloat:0.9],
                           [NSNumber numberWithFloat:1.0],
                           nil];
    [animation setKeyTimes:frameTimes];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;
    animation.duration = 0.6;
    
    [self.layer addAnimation:animation forKey:@"pulse"];
}

-(BOOL)hasPulseAnimation
{
    if([self.layer.animationKeys containsObject:@"pulse"])
        return YES;
    return NO;
}

-(void)removePulseAnimation
{
    [self.layer removeAnimationForKey:@"pulse"];
}

-(void)addFadingAnimationWithDuration:(CGFloat)duration
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromBottom;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = @"extended";
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"reloadAnimation"];
}

-(void)addFadingAnimation
{
    [self addFadingAnimationWithDuration:0.5];
}

#pragma mark --
#pragma mark Other

/* centers the views in the array with respect to self and given offset */
/* views is an array of dictionarys with keys "view" "offset" */
-(void)centerViewsVerticallyWithin:(NSArray*)views
{
    /* calculate y origin of first view */
    float heightOfAllViews = 0;
    
    for(NSDictionary *dic in views) {
        UIView *view = [dic objectForKey:@"view"];
        CGFloat offset = [[dic objectForKey:@"offset"] floatValue];
        heightOfAllViews += view.bounds.size.height + offset;
    }
    
    CGFloat selfHeight = self.bounds.size.height;
    CGFloat yOriginOfFirstView = selfHeight/2.0 - heightOfAllViews/2.0;
    CGFloat currentYOrigin = yOriginOfFirstView;
    
    for(NSDictionary *dic in views) {
        UIView *view = [dic objectForKey:@"view"];
        CGFloat offset = [[dic objectForKey:@"offset"] floatValue];
        CGRect rect = view.frame;
        rect.origin = CGPointMake(rect.origin.x, currentYOrigin + offset);
        view.frame = rect;
        currentYOrigin += rect.size.height + offset;
    }
}

// wrapper
-(void)resignFirstRespondersForSubviews
{
    [self resignFirstRespondersForView:self];
}

// helper
-(void)resignFirstRespondersForView:(UIView*)view
{
    for (UIView *subview in [view subviews])
    {
        if ([subview isKindOfClass:[UITextField class]] || [subview isKindOfClass:[UITextView class]]) {
            [(id)subview resignFirstResponder];
        }
        [self resignFirstRespondersForView:subview];
    }
}

@end
