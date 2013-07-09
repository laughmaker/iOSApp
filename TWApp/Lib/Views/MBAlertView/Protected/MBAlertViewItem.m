//
//  MBAlertViewItem.m
//  AlertsDemo
//
//  Created by M B. Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import "MBAlertViewItem.h"

@implementation MBAlertViewItem

-(id)initWithTitle:(NSString*)text type:(MBAlertViewItemType)type block:(void (^)())block
{
    if(self = [super init]) {
        _title = text;
        _type = type;
        self.block = block;
    }
    return self;
}

@end
