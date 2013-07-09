//
//  MTActivityIndicatorView.m
//  testAnimation
//
//  Created by jesse on 12-7-5.
//  Copyright (c) 2012年 Jesse Xu. All rights reserved.
//

#import "MTActivityIndicatorView.h"
#import <QuartzCore/QuartzCore.h>

#define kActivityIndicatorDotNumber 5

@interface MTActivityIndicatorView ()
{
    BOOL _isAnimating;
    
    //for calculate key frame value
    CGFloat _v0;
    CGFloat _v1;
    CGFloat _t0;
    CGFloat _t1;
    CGFloat _t2;
    CGFloat _a0;
    CGFloat _a1;
}

@property (nonatomic, retain) NSArray *keyframeValues;

@end


@implementation MTActivityIndicatorView

@synthesize dotColor = _dotColor;
@synthesize keyframeValues = _keyframeValues;

@synthesize animationDuration = _animationDuration;
@synthesize ratioOfMaxAndMinVelocity = _ratioOfMaxAndMinVelocity;
@synthesize accelerateDistance = _accelerateDistance;
@synthesize decelerateDistance = _decelerateDistance;
@synthesize repeatInterval = _repeatInterval;
@synthesize dotInterval = _dotInterval;
@synthesize dotCount = _dotCount;
@synthesize repeated = _repeated;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        //set default color
        self.backgroundColor            = [UIColor clearColor];
        self.dotColor                   = [UIColor redColor];
        self.dotCount                   = 5;
        self.ratioOfMaxAndMinVelocity   = 10;
        self.accelerateDistance         = 3./8;
        self.decelerateDistance         = 3./8;
        self.repeatInterval             = 1.0f;
        self.dotInterval                = 0.3f;
        self.animationDuration          = 4.0f;
        self.repeated                   = YES;
        self.dotRadius                  = 2.5;
        
    }
    return self;
}


#pragma mark - public method

- (void)startAnimating
{
    if (_isAnimating)
        return;
    
 
    self.keyframeValues = [self values];
    
    [self initLayers];
    
    _isAnimating = YES;
    [self startAnimatingTransaction];
}


- (void)startAnimatingTransaction
{
    [CATransaction begin];
    
    CFTimeInterval currentTime = CACurrentMediaTime();
    
    for (int i = 0; i < self.layer.sublayers.count; i++)
    {
        CALayer *layer = [self.layer.sublayers objectAtIndex:i];
        
        CAKeyframeAnimation *dotMoveKA = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
        [dotMoveKA setValues:self.keyframeValues];
        [dotMoveKA setDuration:self.animationDuration];
        [dotMoveKA setBeginTime:currentTime + i * self.dotInterval];
        
        if (layer == [self.layer.sublayers lastObject])
        {
            [dotMoveKA setDelegate:self];
        }
        
        [layer addAnimation:dotMoveKA forKey:nil];
    }
    
    [CATransaction commit];
}

- (void)stopAnimating
{
//    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self removeDots];
    _isAnimating = NO;
}

- (void)stopAnimatingNeedDelay:(NSTimeInterval)time
{
    if (time == kMTActivityIndicatorViewCycle)
        _isAnimating = NO;
    else 
    {
        [self performSelector:@selector(removeDots) withObject:nil afterDelay:time];
        _isAnimating = NO;
    }
}

- (BOOL)isAnimating
{
    return _isAnimating;
}


#pragma mark - private method

- (void)initLayers
{
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    for (int i = 0; i < kActivityIndicatorDotNumber; i++)
    {
        CALayer *dotLayer = [CALayer layer];
        dotLayer.frame = CGRectMake(-2.0f, 5.0f, self.dotRadius*2, self.dotRadius*2);
        dotLayer.backgroundColor = self.dotColor.CGColor;
        dotLayer.cornerRadius = self.dotRadius;
        [self.layer addSublayer:dotLayer];
    }
}

- (void)removeDots
{
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (NSArray *)values
{
    [self evalBasic];
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger length = self.animationDuration / 0.1 + 1;
    for (int i = 0; i < length; i++)
    {
        CGFloat value = [self eval:i*0.1];
        [array addObject:[NSNumber numberWithFloat:value]];
    }
    
    return array;
}


#pragma mark - animation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_isAnimating)
    {
        [self performSelector:@selector(startAnimatingTransaction) withObject:nil afterDelay:self.repeatInterval];
    }
}

- (CGFloat)eval:(CGFloat)time
{
    if (time < _t0)
    {
        return _v0 * time + 0.5 * _a0 * time * time;
    }
    else if (time < _t1)
    {
        return _v0 * _t0 + 0.5 * _a0 * _t0 * _t0 + _v1 * (time - _t0);
    }
    else if (time < _t2)
    {
        return _v0 * _t0 + 0.5 * _a0 * _t0 * _t0 + _v1 * (_t1 - _t0) + _v1 * (time - _t1) + 0.5 * _a1 * (time - _t1) * (time - _t1);
    }
    else
    {
        return self.frame.size.width + 2;
    }
}


- (void)evalBasic
{
    //V1 = (2Ka*S + 2Kd*S + (1 - Ka - Kd)*S*(K + 1))/((K + 1)*Tt)
    
    CGFloat s = self.frame.size.width;
    CGFloat k = self.ratioOfMaxAndMinVelocity;
    CGFloat t = self.animationDuration;
    CGFloat ka = self.accelerateDistance;
    CGFloat kd = self.accelerateDistance;
    
    _v1 = (2*ka*s + 2*kd*s + (1 - ka - kd)*s*(k + 1))/((k + 1)*t);
    _v0 = k * _v1;
    _t0 = 2 * ka * s / ((k + 1) * _v1);
    _t1 = _t0 + (1 - ka - kd) * s / _v1;
    _t2 = _t1 + 2 * kd * s / ((k + 1) * _v1);
    _a0 = (1 - k) * _v1 / _t0;
    _a1 = (k - 1) * _v1 / (_t2 - _t1);
}

@end
