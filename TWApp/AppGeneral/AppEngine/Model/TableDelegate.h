//
//  TableDelegate.h
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import <Foundation/Foundation.h>

//路径下的cell高
typedef CGFloat (^CellHeightBlock) (NSIndexPath *indexPath);

//选中某行时的block
typedef void (^SelectCellBlock) (NSIndexPath *indexPath, id item);


@interface TableDelegate : NSObject <UITableViewDelegate, PullTableViewDelegate>

@property (strong, nonatomic) NSMutableArray    *tableItems;

@property (copy, nonatomic) SelectCellBlock     selectCell;
@property (copy, nonatomic) CellHeightBlock     cellHeight;//如果没有设置，则为默认的44高

@property (copy, nonatomic) TWLoadMoreDataBlock loadMoreData;
@property (copy, nonatomic) TWUpdateDataBlock   updateData;

@end
