//
//  NSSpinningCircle.h
//  Notestand
//
//  Created by M B. Bitar on 9/11/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NSSpinningCircleSizeDefault,
    NSSpinningCircleSizeLarge,
    NSSpinningCircleSizeSmall
}NSSpinningCircleSize;

@interface MBSpinningCircle : UIView

@property (nonatomic, assign) BOOL isAnimating;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL hasGlow;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) NSSpinningCircleSize circleSize;

+(MBSpinningCircle*)circleWithSize:(NSSpinningCircleSize)size color:(UIColor*)color;

@end
