//
//  TableViewModel.m
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

- (id)init
{
    if ([super init])
    {
        [self resetRequestParams];
        self.tableItems = [NSMutableArray array];
    }
    return self;
}

- (void)resetRequestParams
{
    self.refreshData = YES;
    self.toPage     = 0;
    self.totalPage  = -1;
    [self.tableItems removeAllObjects];
}

- (void)updateModelData:(NSDictionary *)data
{
    self.totalPage = [data[@"total"] integerValue];
    self.toPage    = [data[@"index"] integerValue] + 1;
    [self.tableItems addObjectsFromArray:data[@"body"]];
}


@end
