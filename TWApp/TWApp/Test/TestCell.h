//
//  TestCell.h
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TWCell.h"

@interface TestCell : TWCell
@property (weak, nonatomic) IBOutlet UIImageView    *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel        *nicknameLbl;
@property (weak, nonatomic) IBOutlet UILabel        *contentLbl;

+ (CGFloat)cellHeightForCellDatas:(NSDictionary *)cellDatas;

@end
