//
//  TWCell.h
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWCell : UITableViewCell

//基类方法，由子类实现具体功能
- (void)configureCellWithCellDatas:(id)cellDatas;

@end
