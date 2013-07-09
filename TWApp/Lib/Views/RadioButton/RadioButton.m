//
//  RadioButton.m
//  RadioButton
//
//  Created by ohkawa on 11/03/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RadioButton.h"

static const NSUInteger kRadioButtonWidth  = 22;
static const NSUInteger kRadioButtonHeight = 22;

//观察者字典, Key为groupId
static NSMutableDictionary  *rb_observers = nil;
//单选框按钮实例字典, Key为groupId，相应的值为该组下的所有实例
static NSMutableDictionary  *rb_instances = nil;


@interface RadioButton()
@property (nonatomic, strong) UIButton    *radioButton;
@property (nonatomic, strong) NSString    *groupId;
@property (nonatomic, assign) NSUInteger  index;
@property (nonatomic, strong) UILabel     *textLbl;
@property (nonatomic, assign) BOOL        selected;

@end

@implementation RadioButton


#pragma mark - Object Lifecycle

- (id)initWithFrame:(CGRect)frame groupId:(NSString *)groupId index:(NSUInteger)index 
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.groupId = groupId;
        self.index = index;
        [RadioButton registerInstance:self withGroupID:self.groupId];
    }
    return  self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {        
        self.radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.radioButton.frame = CGRectMake(0, 0, frame.size.width, kRadioButtonHeight);
        [self.radioButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, frame.size.width - kRadioButtonWidth)];
        self.radioButton.adjustsImageWhenHighlighted = NO;
        [self.radioButton setImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
        [self.radioButton setImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateSelected];
        [self.radioButton addTarget:self action:@selector(radioButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.radioButton];
        
        CGRect rect = CGRectMake(kRadioButtonWidth, 0, frame.size.width - kRadioButtonWidth, kRadioButtonHeight);
        self.textLbl = [[UILabel alloc] initWithFrame:rect];
        [self.textLbl setFont:[UIFont systemFontOfSize:15]];
        [self.textLbl setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.textLbl];
    }
    
    return self;
}


#pragma mark - Manage Instances

+ (void)registerInstance:(RadioButton *)radioButton withGroupID:(NSString *)aGroupID
{
    if(!rb_instances)
    {
        rb_instances = [[NSMutableDictionary alloc] init];
    }
    
    NSMutableArray *radioButtons = [rb_instances objectForKey:aGroupID];
    if (radioButtons)
    {
        [radioButtons addObject:radioButton];
    }
    else
    {
        radioButtons = [[NSMutableArray alloc] init];
        [radioButtons addObject:radioButton];
    }
    [rb_instances setObject:radioButtons forKey:aGroupID];
}


#pragma mark - Observer

+ (void)addObserver:(id)observer forGroupId:(NSString *)groupId
{
    if(!rb_observers)
    {
        rb_observers = [[NSMutableDictionary alloc] init];
    }
    
    if ([groupId length] > 0 && observer)
    {
        [rb_observers setObject:observer forKey:groupId];
    }
}

+ (void)removeObserverForGroupId:(NSString *)groupId
{
    [[rb_instances objectForKey:groupId] removeAllObjects];
}

+ (void)removeAllObserver
{
    [rb_observers removeAllObjects];
    [rb_instances removeAllObjects];

    rb_instances = nil;
    rb_observers = nil;
}


#pragma mark - Set RadioButton Value

- (void)setSelected:(BOOL)selected
{
    if (selected)
    {
        NSArray *radioButtons = [rb_instances objectForKey:self.groupId];
        for (RadioButton *radioButton in radioButtons)
        {
            if (![radioButton isEqual:self])
            {
                [radioButton setSelected:NO];
            }
        }
        [self.radioButton setSelected:YES];
    }
    else
    {
        [self.radioButton setSelected:NO];
    }
    
    _selected = selected;
}

- (void)setText:(NSString *)text
{
    [self.textLbl setText:text];
}


#pragma mark - Tap handling

- (void)radioButtonClicked:(UIButton *)sender
{
    [self setSelected:YES];
    
    if (rb_observers)
    {
        id observer = [rb_observers objectForKey:self.groupId];
        if([observer respondsToSelector:@selector(radioButtonSelectedAtIndex:inGroup:)])
        {
            [observer radioButtonSelectedAtIndex:self.index inGroup:self.groupId];
        }
    }
}



@end
