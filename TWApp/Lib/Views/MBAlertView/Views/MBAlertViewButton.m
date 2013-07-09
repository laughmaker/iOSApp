//
//  MBAlertViewButton.m
//  Notestand
//
//  Created by M B. Bitar on 9/8/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

#import "MBAlertViewButton.h"
#import <QuartzCore/QuartzCore.h>
#import "AlertViewUI.h"

@implementation MBAlertViewButton

#define kShadowSize 8
#define kButtonFont [UIFont boldSystemFontOfSize:18]
- (id)initWithTitle:(NSString*)title
{    
    self = [super initWithFrame:CGRectMake(0, 0, 100, 40)];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _title = title;
    }
    return self;
}

-(UIColor*)colorForButtonStyle
{
    if(_alertButtonType == MBAlertViewItemTypeDefault) {
        return [UIColor whiteColor];
    } else if(_alertButtonType == MBAlertViewItemTypeDestructive) {
        return [UIColor redColor];
    } else if(_alertButtonType == MBAlertViewItemTypePositive) {
        return BLUE_GLOW_COLOR;
    }
    
    return [UIColor whiteColor];
}

-(UIColor*)textColor
{
    if(_alertButtonType == MBAlertViewItemTypeDefault) {
        return [UIColor colorWithWhite:0.2 alpha:1.0];
    } else if(_alertButtonType == MBAlertViewItemTypeDestructive) {
        return [UIColor whiteColor];
    } else if(_alertButtonType == MBAlertViewItemTypePositive) {
        return [UIColor whiteColor];
    }
    
    return [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:2.0];
    [[self colorForButtonStyle] setFill];   
    [path fill];
    
    float actualSize = 0;
    [_title sizeWithFont:kButtonFont minFontSize:8 actualFontSize:&actualSize forWidth:self.bounds.size.width - 20 lineBreakMode:NSLineBreakByClipping];
    CGSize otherSize = [_title sizeWithFont:[UIFont boldSystemFontOfSize:actualSize]];
    
    CGPoint origin = CGPointMake(self.bounds.size.width/2.0 - otherSize.width/2.0, self.bounds.size.height/2.0 - otherSize.height/2.0);
    CGRect frame = CGRectMake(origin.x, origin.y, otherSize.width, otherSize.height);
    
    [[self textColor] set];
    [_title drawInRect:frame withFont:[UIFont boldSystemFontOfSize:actualSize] lineBreakMode:NSLineBreakByClipping];
}

@end
