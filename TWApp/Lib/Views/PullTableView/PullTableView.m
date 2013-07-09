//
//  PullingRefreshTableView.m
//  PullingTableView
//
//  Created by luo danal on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PullTableView.h"


@interface PullTableView () <UITableViewDelegate, UITableViewDataSource>
@property (assign, nonatomic) BOOL isFooterInAction;
@property (assign, nonatomic) BOOL reachedTheEnd;

@property (strong, nonatomic) RefreshView *headerView;
@property (strong, nonatomic) RefreshView *footerView;


@end


@implementation PullTableView

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}


#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame style:UITableViewStylePlain];
    if (self)  { }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self defaultInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:UITableViewStylePlain];
    if (self)
    {
        [self defaultInit];
    }
    
    return self;
}

- (void)defaultInit
{
    self.refreshType = PRPullBoth;
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark - Property

- (void)setRefreshType:(PRRefreshType)refreshType
{
    _refreshType = refreshType;
    [self.headerView removeFromSuperview];
    [self.footerView removeFromSuperview];

    CGRect rect = CGRectMake(0, 0 - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    if (refreshType == PRPullDownRefresh)
    {
        self.headerView = [[RefreshView alloc] initWithFrame:rect atTop:YES];
        [self addSubview:self.headerView];
    }
    else if (refreshType == PRPullUpLoadMore)
    {
        rect = CGRectMake(0, self.frame.size.height - 15, self.frame.size.width, self.frame.size.height);
        self.footerView = [[RefreshView alloc] initWithFrame:rect atTop:NO];
        [self addSubview:self.footerView];
    }
    else if (refreshType == PRPullBoth)
    {
        self.headerView = [[RefreshView alloc] initWithFrame:rect atTop:YES];
        [self addSubview:self.headerView];
        
        rect = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        self.footerView = [[RefreshView alloc] initWithFrame:rect atTop:NO];
        [self addSubview:self.footerView];
    }
}

- (void)setReachedTheEnd:(BOOL)reachedTheEnd
{
    _reachedTheEnd = reachedTheEnd;
    if (_reachedTheEnd)
    {
        _footerView.state = kPRStateHitTheEnd;
    }
    else
    {
        _footerView.state = kPRStateNormal;
    }
}


#pragma mark - Scroll methods

- (void)scrollToNextPage
{
    float h = self.frame.size.height;
    float y = self.contentOffset.y + h;
    y = y > self.contentSize.height ? self.contentSize.height : y;
    
    [UIView animateWithDuration:.7f 
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut 
                     animations:^
    {
                        self.contentOffset = CGPointMake(0, y);  
    }
                     completion:^(BOOL bl)
    {
    }];
}

- (void)pullTableViewDidScroll:(UIScrollView *)scrollView
{
    if (_headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading)
    {
        return;
    }

    CGPoint offset = scrollView.contentOffset;
    CGSize size    = scrollView.frame.size;
    CGSize contentSize = scrollView.contentSize;
 
    float yMargin = offset.y + size.height - contentSize.height;
    if (offset.y < -kPROffsetY)
    {   //header totally appeard
         _headerView.state = kPRStatePulling;
    }
    else if (offset.y > -kPROffsetY && offset.y < 0)
    { //header part appeared
        _headerView.state = kPRStateNormal;
    }
    else if ( yMargin > kPROffsetY)
    {  //footer totally appeared
        if (_footerView.state != kPRStateHitTheEnd)
        {
            _footerView.state = kPRStatePulling;
        }
    }
    else if ( yMargin < kPROffsetY && yMargin > 0)
    {   //footer part appeared
        if (_footerView.state != kPRStateHitTheEnd)
        {
            _footerView.state = kPRStateNormal;
        }
    }
}

- (void)pullTableViewDidEndDragging:(UIScrollView *)scrollView
{
    if (_headerView.state == kPRStateLoading || _footerView.state == kPRStateLoading)
    {
        return;
    }
    
    if (_headerView.state == kPRStatePulling)
    {
        _isFooterInAction = NO;
        _headerView.state = kPRStateLoading;
        
        [UIView animateWithDuration:kPRAnimationDuration animations:^
        {
            self.contentInset = UIEdgeInsetsMake(kPROffsetY, 0, 0, 0);
        }];
        
        if ([self.pullDelegate respondsToSelector:@selector(pullTableViewDidStartPullDownRefresh:)])
        {
            [self.pullDelegate pullTableViewDidStartPullDownRefresh:self];
        }
    }
    else if (_footerView.state == kPRStatePulling)
    {
        if (self.reachedTheEnd)
        {
            return;
        }
        _isFooterInAction = YES;
        _footerView.state = kPRStateLoading;
        [UIView animateWithDuration:kPRAnimationDuration animations:^
        {
            self.contentInset = UIEdgeInsetsMake(0, 0, kPROffsetY, 0);
        }];
        
        if ([self.pullDelegate respondsToSelector:@selector(pullTableViewDidStartPullUpLoadMore:)])
        {
            [self.pullDelegate pullTableViewDidStartPullUpLoadMore:self];
        }
    }
}

- (void)stopPullTableViewRefresh
{
    if (self.headerView.loading)
    {
        self.headerView.loading = NO;
        [self.headerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if ([self.pullDelegate respondsToSelector:@selector(pullTableViewPullDownRefreshFinishedDate)])
        {
            date = [self.pullDelegate pullTableViewPullDownRefreshFinishedDate];
        }
        [self.headerView updateRefreshDate:date];
        
        [UIView animateWithDuration:kPRAnimationDuration * 2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^
        {
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
                         completion:^(BOOL bl)
        {
        }];
    }
    else if (self.footerView.loading)
    {
        self.footerView.loading = NO;
        [self.footerView setState:kPRStateNormal animated:NO];
        NSDate *date = [NSDate date];
        if ([self.pullDelegate respondsToSelector:@selector(pullTableViewPullUpLoadMoreFinishedDate)])
        {
            date = [self.pullDelegate pullTableViewPullUpLoadMoreFinishedDate];
        }
        [self.footerView updateRefreshDate:date];
        
        [UIView animateWithDuration:kPRAnimationDuration
                         animations:^
        {
            self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
                         completion:^(BOOL bl)
        {
        }];
    }
}


#pragma mark - Observe 

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context 
{    
    if ([keyPath isEqualToString:@"contentSize"])
    {
        CGRect frame = _footerView.frame;
        CGSize contentSize = self.contentSize;
        frame.origin.y = contentSize.height < self.frame.size.height ? self.frame.size.height : contentSize.height;
        _footerView.frame = frame;
        if (_isFooterInAction)
        {
            CGPoint offset = self.contentOffset;
            self.contentOffset = offset;
        }    
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end


