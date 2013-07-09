//
//  NSCheckmarkView.h
//  Notestand
//
//  Created by M B. Bitar on 9/24/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MBCheckmarkSizeVerySmall,
    MBCheckmarkSizeSmall,
    MBCheckmarkSizeMedium,
    MBCheckmarkSizeLarge
}MBCheckmarkSize;

@interface MBCheckMarkView : UIView
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) MBCheckmarkSize size;

+(MBCheckMarkView*)checkMarkWithSize:(MBCheckmarkSize)size color:(UIColor*)color;
@end
