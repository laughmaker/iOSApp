//
//  UIView+WSK.m
//  CorePlotDemo
//
//  Created by 何 振东 on 12-9-26.
//  Copyright (c) 2012年 开趣. All rights reserved.
//

#import "UIView+Layer.h"
#import "QuartzCore/QuartzCore.h"

#define DEGREES_TO_RADIANS(d)   (d * M_PI / 180)

@implementation UIView (Layer)


+ (UIView *)reflectImage:(UIImage *)image withFrame:(CGRect)frame opacity:(CGFloat)opacity atView:(UIView *)view
{
	// Image Layer
	CALayer *imageLayer = [CALayer layer];
	imageLayer.contents = (id)image.CGImage;
    imageLayer.frame = frame;
    //	imageLayer.borderColor = [UIColor darkGrayColor].CGColor;
    //	imageLayer.borderWidth = 6.0;
	[view.layer addSublayer:imageLayer];
	
	// Reflection Layer
	CALayer *reflectionLayer = [CALayer layer];
	reflectionLayer.contents = imageLayer.contents;
    reflectionLayer.frame = CGRectMake(imageLayer.frame.origin.x, imageLayer.frame.origin.y + imageLayer.frame.size.height, imageLayer.frame.size.width, imageLayer.frame.size.height);
    //	reflectionLayer.borderColor = imageLayer.borderColor;
    //	reflectionLayer.borderWidth = imageLayer.borderWidth;
	reflectionLayer.opacity = opacity;
	// Transform X by 180 degrees
	[reflectionLayer setValue:[NSNumber numberWithFloat:DEGREES_TO_RADIANS(180)] forKeyPath:@"transform.rotation.x"];
    
	// Gradient Layer - Use as mask
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.bounds = reflectionLayer.bounds;
	gradientLayer.position = CGPointMake(reflectionLayer.bounds.size.width / 2, reflectionLayer.bounds.size.height * 0.5);
	gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor],(id)[[UIColor whiteColor] CGColor], nil];
	gradientLayer.startPoint = CGPointMake(0.5, 0.6);
	gradientLayer.endPoint = CGPointMake(0.5, 1.0);
    
	// Add gradient layer as a mask
	reflectionLayer.mask = gradientLayer;
	[view.layer addSublayer:reflectionLayer];
    
    return view;
}


- (void)startRotationAnimatingWithDuration:(CGFloat)duration
{
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = duration;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALL;

    [self.layer setShouldRasterize:YES];//抗锯齿
    [self.layer setRasterizationScale:[[UIScreen mainScreen] scale]];
    [self.layer addAnimation:animation forKey:nil];
    
    //如果暂停了，则恢复动画运行
    if (self.layer.speed == 0.0)
    {
        [self resumeAnimating];
    }
}

- (void)stopRotationAnimating
{
    [self.layer removeAllAnimations];
}

- (void)pauseAnimating
{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

- (void)resumeAnimating
{
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

@end
