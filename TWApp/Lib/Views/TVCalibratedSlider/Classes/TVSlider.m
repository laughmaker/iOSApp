//
//  TVSlider.m
//
//  Created by TavisacaIos on 9/4/12.
//  Copyright (c) 2012 Tavisca. All rights reserved.
//

#import "TVSlider.h"

@interface TVSlider () {
    UIImage *_thumbImage;
    CGPoint  _offset;
    UIColor *_highlightedStateTextColor;
    UIFont  *_highlightedStateTextFont;
    CGPoint _highlightedStateTextPosition;
    BOOL _isHighlightedStateTextPositionCustom;
}
@end

@implementation TVSlider

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _highlightedStateTextColor = [UIColor whiteColor];
        _highlightedStateTextFont = [UIFont systemFontOfSize:16];
        [self addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventTouchDragInside|UIControlEventTouchDown];
    }
    return self;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    CGRect rectForThumbImage = [super thumbRectForBounds:bounds trackRect:rect value:value];
    if( self.state == UIControlStateHighlighted ) {
      rectForThumbImage = CGRectOffset(rectForThumbImage, _offset.x , _offset.y);
    }
    return rectForThumbImage;
}

- (void)setThumbImage:(UIImage *)thumbImage forState:(UIControlState)state withOffsetRelativeToCenterOfTrack:(CGPoint)offset {
    [super setThumbImage:thumbImage forState:state];
    if(state == UIControlStateHighlighted) {
        _thumbImage = thumbImage;
        _offset = offset;
    }
}

- (void)setTextColorForHighlightedState:(UIColor *)color {
    _highlightedStateTextColor = color;
}

- (void)setTextPositionForHighlightedStateRelativeToThumbImage:(CGPoint)position {
    _isHighlightedStateTextPositionCustom = YES;
    _highlightedStateTextPosition = position;
}

-(void)setTextFontForHighlightedState:(UIFont *)font {
    _highlightedStateTextFont = font;
}

-(void)valueChanged {
    if(_thumbImage == nil){
        return;
    }
    UIGraphicsBeginImageContextWithOptions(_thumbImage.size, NO, 0);
    [_thumbImage drawAtPoint:CGPointMake(0, 0)];
    [_highlightedStateTextColor set];
    NSString *value = [NSString stringWithFormat:@"%0.0f",self.value];
    CGSize size = [value sizeWithFont:[UIFont systemFontOfSize:16]];
    if(!_isHighlightedStateTextPositionCustom){
        _highlightedStateTextPosition = CGPointMake(_thumbImage.size.width/2 - size.width/2, 0);
    }
    [value drawAtPoint:_highlightedStateTextPosition withFont:_highlightedStateTextFont];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbImage:image forState:UIControlStateHighlighted];
    UIGraphicsEndImageContext();
}
@end