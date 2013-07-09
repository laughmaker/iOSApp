//
//  MBAlertViewItem.h
//  AlertsDemo
//
//  Created by M B. Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MBAlertViewItemTypeDefault,
    MBAlertViewItemTypeDestructive,
    MBAlertViewItemTypePositive,
}MBAlertViewItemType;

@interface MBAlertViewItem : NSObject
@property (nonatomic, copy) id block;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) MBAlertViewItemType type;
-(id)initWithTitle:(NSString*)text type:(MBAlertViewItemType)type block:(void (^)())block;
@end
