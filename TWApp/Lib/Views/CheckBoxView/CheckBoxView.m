
/*
 Copyright 2011 Ahmet Ardal
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

//
//  SSCheckBoxView.m
//  SSCheckBoxView
//
//  Created by Ahmet Ardal on 12/6/11.
//  Copyright 2011 SpinningSphere Labs. All rights reserved.
//

#import "CheckBoxView.h"


static const CGFloat kHeight = 36.0f;


@interface CheckBoxView()

@property (assign, nonatomic) CheckBoxViewStyle style;
@property (weak,   nonatomic) id <NSObject>     delegate;
@property (assign, nonatomic) SEL               stateChangedSelector;

@property (strong, nonatomic) UILabel           *textLabel;
@property (strong, nonatomic) UIImageView       *checkBoxImageView;


@end

@implementation CheckBoxView

- (id)initWithFrame:(CGRect)frame style:(CheckBoxViewStyle)aStyle checked:(BOOL)aChecked
{
    frame.size.height = kHeight;
    if ((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];

        self.style   = aStyle;
        self.checked = aChecked;
        self.enabled = YES;
        
        CGRect labelFrame = CGRectMake(32.0f, 7.0f, self.frame.size.width - 32, 20.0f);
        self.textLabel = [[UILabel alloc] initWithFrame:labelFrame];
        self.textLabel.textAlignment = UITextAlignmentLeft;
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.textLabel];
        
        self.checkBoxImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.checkBoxImageView];
        
        [self updateCheckBoxImage];
    }

    return self;
}


#pragma mark - property

- (UIFont *)textFont
{
    return self.textLabel.font;
}

- (void)setTextFont:(UIFont *)font
{
    self.textLabel.font = font;
}

- (UIColor *)textColor
{
    return self.textLabel.textColor;
}

- (void)setTextColor:(UIColor *)color
{
    self.textLabel.textColor = color;
}

- (void)setEnabled:(BOOL)enabled
{
    [_textLabel setEnabled:enabled];
    _enabled = enabled;
    self.checkBoxImageView.alpha = enabled ? 1.0f : 0.5f;
}

- (NSString *)text
{
    return self.textLabel.text;
}

- (void)setText:(NSString *)text
{
    [self.textLabel setText:text];
}

- (void)setChecked:(BOOL)isChecked
{
    _checked = isChecked;
    [self updateCheckBoxImage];
}


#pragma mark -
#pragma mark Touch-related Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.enabled) return;

    self.alpha = 0.8f;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.enabled)  return;

    self.alpha = 1.0f;
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.enabled)   return;

    // restore alpha
    self.alpha = 1.0f;

    // check touch up inside
    if ([self superview])
    {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:[self superview]];
        CGRect validTouchArea = CGRectMake((self.frame.origin.x - 5),
                                           (self.frame.origin.y - 10),
                                           (self.frame.size.width + 5),
                                           (self.frame.size.height + 10));
        if (CGRectContainsPoint(validTouchArea, point))
        {
            self.checked = !self.checked;
            [self updateCheckBoxImage];
            if (self.delegate && self.stateChangedSelector)
            {
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self.delegate performSelector:self.stateChangedSelector withObject:self];
                #pragma clang diagnostic pop
            }
            else if (stateChangedBlock)
            {
                stateChangedBlock(self);
            }
        }
    }

    [super touchesEnded:touches withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}


#pragma mark -
#pragma mark Private Methods

- (UIImage *)checkBoxImageForStyle:(CheckBoxViewStyle)s checked:(BOOL)isChecked
{
    NSString *suffix = isChecked ? @"on" : @"off";
    NSString *imageName = @"";
    switch (s)
    {
        case kCheckBoxViewStyleBox:
            imageName = @"cb_box_";
            break;
        case kCheckBoxViewStyleDark:
            imageName = @"cb_dark_";
            break;
        case kCheckBoxViewStyleGlossy:
            imageName = @"cb_glossy_";
            break;
        case kCheckBoxViewStyleGreen:
            imageName = @"cb_green_";
            break;
        case kCheckBoxViewStyleMono:
            imageName = @"cb_mono_";
            break;
        default:
            return nil;
    }
    imageName = [NSString stringWithFormat:@"%@%@", imageName, suffix];
    return [UIImage imageNamed:imageName];
}

- (CGRect)imageViewFrameForCheckBoxImage:(UIImage *)img
{
    CGFloat y = floorf((kHeight - img.size.height) / 2.0f);
    return CGRectMake(5.0f, y, img.size.width, img.size.height);
}

- (void)updateCheckBoxImage
{
    UIImage *image = [self checkBoxImageForStyle:self.style checked:self.checked];
    self.checkBoxImageView.image = image;
    self.checkBoxImageView.frame = [self imageViewFrameForCheckBoxImage:image];
}

- (void)addStateChangedTarget:(id<NSObject>)target selector:(SEL)selector
{
    self.delegate = target;
    self.stateChangedSelector = selector;
}



@end
