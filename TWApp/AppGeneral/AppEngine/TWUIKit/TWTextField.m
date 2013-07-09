//
//  TWTextField.m
//  TWApp
//
//  Created by line0 on 13-7-6.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TWTextField.h"

@implementation TWTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

- (void)defaultInit
{
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
    self.layer.borderWidth = 1;
    [self setFont:[UIFont systemFontOfSize:15]];
    [self setClearButtonMode:UITextFieldViewModeWhileEditing];
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
	return CGRectInset(bounds, 5, 2.5);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
	return CGRectInset(bounds, 5, 2.5);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
	return CGRectInset(bounds, 5, 2.5);
}

//根据需求自定义输入框背景
//- (void)drawRect:(CGRect)rect
//{
//    UIImage *textFieldBackground = [[UIImage imageNamed:@"text_field_teal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15.0, 5.0, 15.0, 5.0)];
//    [textFieldBackground drawInRect:[self bounds]];
//}

@end
