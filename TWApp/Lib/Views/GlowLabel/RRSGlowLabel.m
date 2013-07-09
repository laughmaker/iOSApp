//
//  RRSGlowLabel.m
//  TextGlowDemo
//
//  Created by Andrew on 28/04/2010.
//  Red Robot Studios 2010.
//

#import "RRSGlowLabel.h"

@implementation RRSGlowLabel

- (void)setGlowColor:(UIColor *)newGlowColor
{
    if (newGlowColor != _glowColor)
    {
        _glowColor = newGlowColor;
        CGColorRelease(glowColorRef);
        glowColorRef = CGColorCreate(colorSpaceRef, CGColorGetComponents(_glowColor.CGColor));
        [self setNeedsDisplay];
    }
}

- (void)setGlowAmount:(CGFloat)glowAmount
{
    _glowAmount = glowAmount;
    [self setNeedsDisplay];
}

- (void)setGlowOffset:(CGSize)glowOffset
{
    _glowOffset = glowOffset;
    [self setNeedsDisplay];
}

- (void)initialize
{
    colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    self.glowOffset = CGSizeMake(0.0, 0.0);
    self.glowAmount = 10.0;
    self.glowColor = [UIColor orangeColor];
}

- (void)awakeFromNib
{
    [self initialize];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self != nil)
    {
        [self initialize];
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetShadow(context, self.glowOffset, self.glowAmount);
    CGContextSetShadowWithColor(context, self.glowOffset, self.glowAmount, glowColorRef);
        
    CGContextRestoreGState(context);
}

- (void)dealloc
{
    CGColorRelease(glowColorRef);
    CGColorSpaceRelease(colorSpaceRef);
}

@end
