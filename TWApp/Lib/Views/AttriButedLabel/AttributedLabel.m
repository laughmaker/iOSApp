//
//  AttributedLabel.m
//  AttributedStringTest
//
//  Created by sun huayu on 13-2-19.
//  Copyright (c) 2013年 sun huayu. All rights reserved.
//

#import "AttributedLabel.h"
#import "QuartzCore/QuartzCore.h"

@interface AttributedLabel()
@property (nonatomic, strong) NSMutableAttributedString *attString;
@property (nonatomic, strong) CATextLayer               *textLayer;

@end

@implementation AttributedLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
        
        [self setTextColor:[UIColor darkTextColor]];
        [self setFont:[UIFont systemFontOfSize:15]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self defaultInit];
        
        [self setText:self.text];
        [self setTextColor:self.textColor];
        [self setFont:self.font];
    }

    return self;
}

- (void)defaultInit
{
    self.textLayer = [CATextLayer layer];
    self.textLayer.contentsScale = [[UIScreen mainScreen] scale];
    self.textLayer.frame = self.bounds;
    [self.layer addSublayer:self.textLayer];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.textLayer setFrame:self.bounds];
}

- (void)drawRect:(CGRect)rect
{
    self.textLayer.string = self.attString;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    if (text == nil)
    {
        self.attString = nil;
    }
    else
    {
        self.attString = [[NSMutableAttributedString alloc] initWithString:text];
        [self setFont:self.font];
        [self setTextColor:self.textColor];
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    [super setTextColor:textColor];
    
    [self setColor:textColor fromIndex:0 length:self.text.length];
}

- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length
{
    if (location < 0||location>self.text.length-1||length+location>self.text.length)
    {
        return;
    }
    [self.attString addAttribute:(NSString *)kCTForegroundColorAttributeName
                        value:(id)color.CGColor
                        range:NSMakeRange(location, length)];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];

    [self setFont:font fromIndex:0 length:self.text.length];
}

- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length
{
    if (location < 0||location>self.text.length-1||length+location>self.text.length)
    {
        return;
    }
    [self.attString addAttribute:(NSString *)kCTFontAttributeName
                        value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)CFBridgingRetain(font.fontName),
                                                       font.pointSize,
                                                       NULL))
                        range:NSMakeRange(location, length)];
}

- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length
{
    if (location < 0 || location>self.text.length - 1 || length + location > self.text.length)
    {
        return;
    }
    [self.attString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                        value:(id)[NSNumber numberWithInt:style]
                        range:NSMakeRange(location, length)];
}


@end
