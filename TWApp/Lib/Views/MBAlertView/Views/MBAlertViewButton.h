//
//  MBAlertViewButton.h
//  Notestand
//
//  Created by M B. Bitar on 9/8/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBAlertView.h"

@interface MBAlertViewButton : UIButton
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) MBAlertViewItemType alertButtonType;
- (id)initWithTitle:(NSString*)title;
@end
