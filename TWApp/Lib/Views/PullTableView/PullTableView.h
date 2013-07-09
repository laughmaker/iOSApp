//
//  PullingRefreshTableView.h
//  PullingTableView
//
//  Created by danal on 3/6/12.If you want use it,please leave my name here
//  Copyright (c) 2012 danal Luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshView.h"

//刷新类型
typedef enum
{
    PRPullDownRefresh,    //下拉刷新
    PRPullUpLoadMore,     //上拉加载更多
    PRPullBoth
}PRRefreshType;

@protocol PullTableViewDelegate;

@interface PullTableView : UITableView <UIScrollViewDelegate>

//刷新代理，必须实现
@property (weak, nonatomic) IBOutlet id <PullTableViewDelegate> pullDelegate;

//设置不同的刷新类型，默认为PRPullBoth。
@property (assign, nonatomic) PRRefreshType         refreshType;

//如果为上拉加载更多，则headerView为nil;
@property (strong, nonatomic, readonly) RefreshView *headerView;
//如果为下拉刷新，则footerView为nil;
@property (strong, nonatomic, readonly) RefreshView *footerView;


//只需要实现这个初始化方法即可
- (id)initWithFrame:(CGRect)frame;

//在主类中通过ScrollView的两个代理调用这两个方法,必须实现。
- (void)pullTableViewDidScroll:(UIScrollView *)scrollView;
- (void)pullTableViewDidEndDragging:(UIScrollView *)scrollView;

//加载完成后调用以取消菊花旋转
- (void)stopPullTableViewRefresh;

@end


@protocol PullTableViewDelegate <NSObject>

@optional

/*
 下拉刷新或上拉加载更多必须实现最少其中一个代理。
 */

//开始下拉刷新时调用
- (void)pullTableViewDidStartPullDownRefresh:(PullTableView *)tableView;

//开始上拉加载更多时调用
- (void)pullTableViewDidStartPullUpLoadMore:(PullTableView *)tableView;


/*
 设置刷新时间，若不实现，默认为当前时间。
 */
//下拉刷新完成后的时间
- (NSDate *)pullTableViewPullDownRefreshFinishedDate;

//上拉加载更多完成后的时间
- (NSDate *)pullTableViewPullUpLoadMoreFinishedDate;


@end


