//
//  MBAlertViewSubclass.h
//  AlertsDemo
//
//  Created by M B. Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import "MBAlertView.h"

@interface MBAlertView ()
@property (nonatomic, strong) UIButton *bodyLabelButton;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, strong) NSTimer *hideTimer;
-(void)addToWindow;
@end
