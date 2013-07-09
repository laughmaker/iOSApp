
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
//  SSCheckBoxView.h
//  SSCheckBoxView
//
//  Created by Ahmet Ardal on 12/6/11.
//  Copyright 2011 SpinningSphere Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CheckBoxView;

typedef enum CheckBoxViewStyle_
{
    kCheckBoxViewStyleBox = 0,
    kCheckBoxViewStyleDark,
    kCheckBoxViewStyleGlossy,
    kCheckBoxViewStyleGreen,
    kCheckBoxViewStyleMono,
    kCheckBoxViewStylesCount
}CheckBoxViewStyle;

void (^stateChangedBlock)(CheckBoxView *cbv);


@interface CheckBoxView: UIView

//按钮样式
@property (assign, nonatomic, readonly) CheckBoxViewStyle   style;

//按钮状态
@property (assign, nonatomic)           BOOL                checked;
@property (assign, nonatomic)           BOOL                enabled;

//右侧的文字、颜色、字体
@property (copy, nonatomic)             NSString            *text;
@property (strong, nonatomic)           UIColor             *textColor;
@property (strong, nonatomic)           UIFont              *textFont;

- (id)initWithFrame:(CGRect)frame style:(CheckBoxViewStyle)aStyle checked:(BOOL)aChecked;


//blocks响应方法
@property (nonatomic, copy) void (^stateChangedBlock)(CheckBoxView *cbv);

//常规响应方法
- (void)addStateChangedTarget:(id<NSObject>)target selector:(SEL)selector;

@end






