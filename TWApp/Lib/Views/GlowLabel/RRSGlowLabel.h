//
//  RRSGlowLabel.h
//  TextGlowDemo
//
//  Created by Andrew on 28/04/2010.
//  Copyright 2010 Red Robot Studios. All rights reserved.
//


@interface RRSGlowLabel : UILabel
{
    CGColorSpaceRef colorSpaceRef;
    CGColorRef      glowColorRef;
}

@property (nonatomic, assign) CGSize    glowOffset;
@property (nonatomic, assign) CGFloat   glowAmount;
@property (nonatomic, strong) UIColor   *glowColor;

@end
