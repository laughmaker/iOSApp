//
//  MBAlertView.h
//  Notestand
//
//  Created by M B. Bitar on 9/8/12.
//  Copyright (c) 2012 progenius, inc. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>
#import "MBAlertViewItem.h"

// notifications called when an alert/hud appears/disappears
extern NSString *const MBAlertViewDidAppearNotification;
extern NSString *const MBAlertViewDidDismissNotification;

// use these as needed
extern CGFloat MBAlertViewMaxHUDDisplayTime;
extern CGFloat MBAlertViewDefaultHUDHideDelay;

@interface MBAlertView : UIViewController <UIGestureRecognizerDelegate>
// if yes, will wait until alert has disappeared before performing any button blocks
@property (nonatomic, assign) BOOL shouldPerformBlockAfterDismissal;

// perform something after the alert dismisses
@property (nonatomic, copy) id uponDismissalBlock;

// huds by default are put on super view controller. however sometimes a hud appears right before a modal disappears. in that case we'll add the hud to the window
@property (nonatomic, assign) BOOL addsToWindow;

// offset for HUD icons, or image offset if supplied
@property (nonatomic, assign) CGSize iconOffset;

// body is the main text of the alert
@property (nonatomic, copy) NSString *bodyText;
@property (nonatomic, strong) UIFont *bodyFont;

// just set the imageView's image to activate
@property (nonatomic, strong) UIImageView *imageView;

// if not assigned, will be full screen
@property (nonatomic, assign) CGSize size;

// the opacity of the background
@property (nonatomic, assign) float backgroundAlpha;

-(void)dismiss;
-(void)addToDisplayQueue;
-(void)addButtonWithText:(NSString*)text type:(MBAlertViewItemType)type block:(void (^)())block;

#pragma mark Class methods
// factory method
+(MBAlertView*)alertWithBody:(NSString*)body cancelTitle:(NSString*)cancelTitle cancelBlock:(void (^)())cancelBlock;

// yes if there is currently an alert or hud on screen
+(BOOL)alertIsVisible;

// dismisses current hud in queue, whether or not its visible
+(void)dismissCurrentHUD;
+(void)dismissCurrentHUDAfterDelay:(float)delay;

// a helper method that returns a size
+(CGSize)halfScreenSize;


@end
