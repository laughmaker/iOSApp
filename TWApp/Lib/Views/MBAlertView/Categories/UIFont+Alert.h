//
//  UIFont+Alert.h
//  AlertsDemo
//
//  Created by M B. Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Alert)
+(UIFont*)boldSystemFontThatFitsSize:(CGSize)size maxFontSize:(int)max minSize:(int)min text:(NSString*)text;
@end
