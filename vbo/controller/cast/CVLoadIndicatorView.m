//
//  CVLoadIndicatorView.m
//  vbo
//
//  Created by Emerson on 13-12-6.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CVLoadIndicatorView.h"

@interface CVLoadIndicatorView ()

- (void)setState:(PullRefreshState)aState;
- (CGFloat)scrollViewOffsetFromBottom:(UIScrollView *) scrollView;
- (CGFloat)visibleTableHeightDiffWithBoundsHeight:(UIScrollView *) scrollView;

@end

@implementation CVLoadIndicatorView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		
        _isLoading = NO;
		[self setBackgroundColor:[UIColor greenColor]];
		[self setState:PullRefreshNormal]; // Also transform the image
    }
	
    return self;
	
}

#pragma mark - Util
- (CGFloat)scrollViewOffsetFromBottom:(UIScrollView *) scrollView
{
    CGFloat scrollAreaContenHeight = scrollView.contentSize.height;
    
    CGFloat visibleTableHeight = MIN(scrollView.bounds.size.height, scrollAreaContenHeight);
    CGFloat scrolledDistance = scrollView.contentOffset.y + visibleTableHeight; // If scrolled all the way down this should add upp to the content heigh.
    
    CGFloat normalizedOffset = scrollAreaContenHeight -scrolledDistance;
    
    return normalizedOffset;
}

- (CGFloat)visibleTableHeightDiffWithBoundsHeight:(UIScrollView *) scrollView
{
    return (scrollView.bounds.size.height - MIN(scrollView.bounds.size.height, scrollView.contentSize.height));
}


#pragma mark - Setters


- (void)setState:(PullRefreshState)aState{
	
	switch (aState) {
		case PullRefreshPulling:
			
			break;
		case PullRefreshNormal:
            
			break;
		case PullRefreshLoading:
			
			break;
		default:
            
			break;
	}
	
	_state = aState;
}

#pragma mark - ScrollView Methods

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat bottomOffset = [self scrollViewOffsetFromBottom:scrollView];
	if (_state == PullRefreshLoading) {
		
	} else if (scrollView.isDragging) {
		if (_state == PullRefreshPulling /* && bottomOffset > -PULL_TRIGGER_HEIGHT && bottomOffset < 0.0f*/ && !_isLoading) {
			[self setState:PullRefreshNormal];
		} else if (_state == PullRefreshNormal /* && bottomOffset < -PULL_TRIGGER_HEIGHT*/ && !_isLoading) {
			[self setState:PullRefreshPulling];
		}
		
		if (scrollView.contentInset.bottom != 0) {
            UIEdgeInsets currentInsets = scrollView.contentInset;
            currentInsets.bottom = 0;
            scrollView.contentInset = currentInsets;
		}
		
	}
	
}

- (void)startAnimatingWithScrollView:(UIScrollView *) scrollView {
//    _isLoading = YES;
//    [self setState:PullRefreshLoading];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:0.2];
//    UIEdgeInsets currentInsets = scrollView.contentInset;
//    currentInsets.bottom = PULL_AREA_HEIGTH + [self visibleTableHeightDiffWithBoundsHeight:scrollView];
//    scrollView.contentInset = currentInsets;
//    [UIView commitAnimations];
//    if([self scrollViewOffsetFromBottom:scrollView] == 0){
//        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + PULL_TRIGGER_HEIGHT) animated:YES];
//    }
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	if (/*[self scrollViewOffsetFromBottom:scrollView] <= - PULL_TRIGGER_HEIGHT &&*/ !_isLoading) {
        if ([_delegate respondsToSelector:@selector(loadMoreTableFooterDidTriggerLoadMore:)]) {
            [_delegate loadMoreTableFooterDidTriggerLoadMore:self];
        }
        [self startAnimatingWithScrollView:scrollView];
	}
	
}

- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
	
    _isLoading = NO;
    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:.3];
    UIEdgeInsets currentInsets = scrollView.contentInset;
    currentInsets.bottom = 0;
    scrollView.contentInset = currentInsets;
	[UIView commitAnimations];
	
	[self setState:PullRefreshNormal];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
