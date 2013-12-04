//
//  CVDragIndicator.h
//  vbo
//
//  Created by Emerson on 13-11-30.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//
//  based on Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//


#import <UIKit/UIKit.h>

typedef enum{
	PullRefreshPulling = 0,
	PullRefreshNormal,
	PullRefreshLoading,
} PullRefreshState;

@class CVDragIndicatorView;
@protocol CVDragIndicatorViewDelegate

/*! 下拉刷新松手后调用的方法
 * \param view 下拉刷新的view
 */
- (void)refreshTableHeaderDidTriggerRefresh:(CVDragIndicatorView*)view;

/*! 下拉刷新松手后调用的方法
 * \param view 下拉刷新的view
 * \returns 是否正在loading
 */
- (BOOL)refreshTableHeaderDataSourceIsLoading:(CVDragIndicatorView*)view;

@optional

- (NSDate*)refreshTableHeaderDataSourceLastUpdated:(CVDragIndicatorView*)view;
@end

@interface CVDragIndicatorView : UIView

@property (nonatomic) PullRefreshState state;
@property (nonatomic, weak) NSObject <CVDragIndicatorViewDelegate>* delegate;

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
- (void)setBezierPathByScrollOffset:(float) offset;

@end

