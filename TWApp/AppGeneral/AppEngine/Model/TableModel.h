//
//  TableViewModel.h
//  TWApp
//
//  Created by line0 on 13-7-8.
//  Copyright (c) 2013年 makeLaugh. All rights reserved.
//

/*
 *带TableView的视图控制器的Model。
 */

#import "VCModel.h"

@interface TableModel : VCModel
@property (strong, nonatomic) NSMutableArray *tableItems;//TableView数据
@property (assign, nonatomic) NSInteger      totalPage;//初始值为－1
@property (assign, nonatomic) NSInteger      toPage;//初始值为0

//判断是下拉刷新数据还是加载更多，默认为YES
@property (assign, nonatomic, getter = isRefreshData) BOOL refreshData;

//在更新数据时复位参数
- (void)resetRequestParams;

//更新Model数据,子类可重写这个方法。
- (void)updateModelData:(NSDictionary *)datas;

@end
