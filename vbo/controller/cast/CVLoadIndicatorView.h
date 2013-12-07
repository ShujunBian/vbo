//
//  CVLoadIndicatorView.h
//  vbo
//
//  Created by Emerson on 13-12-6.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVDragIndicatorView.h"

@class CVLoadIndicatorView;

@protocol CVLoadIndicatorViewDelegate
- (void)loadMoreTableFooterDidTriggerLoadMore:(CVLoadIndicatorView*)view;
@end

@interface CVLoadIndicatorView : UIView {
    // Set this to Yes when egoRefreshTableHeaderDidTriggerRefresh delegate is called and No with egoRefreshScrollViewDataSourceDidFinishedLoading
	
}

@property (nonatomic) PullRefreshState state;
@property (nonatomic) BOOL isLoading;
@property (nonatomic, weak) NSObject<CVLoadIndicatorViewDelegate> * delegate;

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

- (void)startAnimatingWithScrollView:(UIScrollView *) scrollView;

@end
