//
//  TableDataSource.m
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

#import "TableDataSource.h"

@interface TableDataSource ()
@property (copy, nonatomic) NSString *cellIdentifier;
@property (copy, nonatomic) CellConfigureBlock cellConfigureBlock;

@end

@implementation TableDataSource

- (id)initWithCellIdentifier:(NSString *)cellIdentifier cellconfigureBlock:(CellConfigureBlock)cellConfigureBlock
{
    self = [super init];
    if (self)
    {
        self.cellIdentifier = cellIdentifier;
        self.cellConfigureBlock = [cellConfigureBlock copy];
        self.tableItems = [NSMutableArray array];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableItems[(NSUInteger) indexPath.row];
}


#pragma mark - TableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TWCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    id item = [self itemAtIndexPath:indexPath];
    self.cellConfigureBlock(cell, item);
    return cell;
}

@end
