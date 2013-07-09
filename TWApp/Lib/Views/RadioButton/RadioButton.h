//
//  RadioButton.h
//  RadioButton
//
//  Created by ohkawa on 11/03/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  


#import <UIKit/UIKit.h>

@protocol RadioButtonDelegate <NSObject>
@optional
- (void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId;

@end


@interface RadioButton : UIView
//单选按钮
@property (nonatomic, strong, readonly) UIButton    *radioButton;

//所在组标志位
@property (nonatomic, strong, readonly) NSString    *groupId;

//按钮在所在组的索引号
@property (nonatomic, assign, readonly) NSUInteger  index;

//显示在右边的内容Lable
@property (nonatomic, strong, readonly) UILabel     *textLbl;

//是否选中状态
@property (nonatomic, assign, readonly, getter = isSelected) BOOL selected;

- (id)initWithFrame:(CGRect)frame groupId:(NSString *)groupId index:(NSUInteger)index;

//设置默认选中项，默认未选中
- (void)setSelected:(BOOL)selected;

//设置显示在右边的文字
- (void)setText:(NSString *)text;

+ (void)addObserver:(id)observer forGroupId:(NSString *)groupId;
//移除分组观察者
+ (void)removeObserverForGroupId:(NSString *)groupId;
//移除所有观察者
+ (void)removeAllObserver;


@end
