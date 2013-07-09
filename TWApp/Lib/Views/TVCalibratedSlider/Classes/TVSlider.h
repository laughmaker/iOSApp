//
//  TVSlider.h
//
//  Created by TavisacaIos on 9/4/12.
//  Copyright (c) 2012 Tavisca. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 TVSlider is subclass of UISlider.
 */

@interface TVSlider : UISlider

/**
 @abstract Set the thumb image with a relative offset from the center of the track. 
 @param image  Slider thumb image.
 @param state  State of the slider.
 @param offset Offset from the center of the track.
 */
- (void)setThumbImage:(UIImage *)thumbImage forState:(UIControlState)state withOffsetRelativeToCenterOfTrack:(CGPoint)offset;

/**
 @abstract Set the text color on the highlighted thumb image.
 @param color Text color on the highlighted thumb image.
 */
- (void)setTextColorForHighlightedState:(UIColor*)color;

/**
 @abstract Set the text font on the highlighted thumb image.
 @param font Text font on the highlighted thumb image.
 */
- (void)setTextFontForHighlightedState:(UIFont *)font;

/**
 @abstract Set position of the text on the highlighted thumb image.
 @param position Text postion on the highlighted thumb image.
 */
- (void)setTextPositionForHighlightedStateRelativeToThumbImage:(CGPoint)position;
@end
