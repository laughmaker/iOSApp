//
//  TableDataSource.h
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWCell.h"

//Cell Block，用于配置Cell
typedef void (^CellConfigureBlock) (TWCell *cell, id cellDatas);

@interface TableDataSource : NSObject <UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *tableItems;

- (id)initWithCellIdentifier:(NSString *)cellIdentifier
          cellconfigureBlock:(CellConfigureBlock)cellConfigureBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
