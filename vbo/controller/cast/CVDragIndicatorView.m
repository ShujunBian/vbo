//
//  CVDragIndicator.m
//  vbo
//
//  Created by Emerson on 13-11-30.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//
//  Created by Devin Doty on 10/14/09October14.
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

#import "CVDragIndicatorView.h"

#define FLIP_ANIMATION_DURATION 0.18f
#define DEGREETORADIANS  3.1415926 / 180.0
#define maxScrollOffset 105.0
#define theCircleRadius 10.0
#define navigationbarHeight 64.0
#define statusBarHeight 20.0

@interface CVDragIndicatorView()

@property (nonatomic) float currentEndDegree;
- (void)setState:(PullRefreshState)aState;

@end

@implementation CVDragIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setState:PullRefreshNormal];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setState:(PullRefreshState)aState{
	
	switch (aState) {
		case PullRefreshPulling:
			
			break;
		case PullRefreshNormal:
			
			if (_state == PullRefreshPulling) {
                
			}
			
			break;
		case PullRefreshLoading:
            
			break;
		default:
			break;
	}
	
	_state = aState;
}

#pragma mark -
#pragma mark ScrollView Methods

- (void)refreshScrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"the state is %u",_state);
    if (_state == PullRefreshLoading) {
//		
//        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
//        offset = MIN(offset, 44);
//        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
		
	} else if (scrollView.isDragging) {
        
		BOOL _loading = NO;
        _loading = [_delegate refreshTableHeaderDataSourceIsLoading:self];
		
		if (_state == PullRefreshPulling && scrollView.contentOffset.y > - (navigationbarHeight + maxScrollOffset)
            && scrollView.contentOffset.y < -statusBarHeight && !_loading) {
			[self setState:PullRefreshNormal];
		} else if (_state == PullRefreshNormal && scrollView.contentOffset.y < - (navigationbarHeight + maxScrollOffset) && !_loading) {
			[self setState:PullRefreshPulling];
		}
	}

    [self setBezierPathByScrollOffset:- (scrollView.contentOffset.y + navigationbarHeight )];
}

- (void)refreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
    _loading = [_delegate refreshTableHeaderDataSourceIsLoading:self];
    
	if (scrollView.contentOffset.y <= - (navigationbarHeight + maxScrollOffset) && !_loading) {
		
        [_delegate refreshTableHeaderDidTriggerRefresh:self];
		[self setState:PullRefreshLoading];
        
        UIEdgeInsets previousInset = scrollView.contentInset;
        id<UIScrollViewDelegate> aDelegate = scrollView.delegate;
        scrollView.delegate = nil;
        
        [UIView animateWithDuration:2.0 animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(previousInset.top + (navigationbarHeight - statusBarHeight),
                                                       previousInset.left,
                                                       previousInset.bottom,
                                                       previousInset.right);
        }completion:^(BOOL finished) {
            scrollView.delegate = aDelegate;
        }];
	}
	
}

- (void)refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {

    UIEdgeInsets previousInset = scrollView.contentInset;
    id<UIScrollViewDelegate> aDelegate = scrollView.delegate;
    scrollView.delegate = nil;

    [UIView animateWithDuration:0.5 animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(previousInset.top - (navigationbarHeight - statusBarHeight),
                                                   previousInset.left,
                                                   previousInset.bottom,
                                                   previousInset.right);
    }completion:^(BOOL finished) {
        scrollView.delegate = aDelegate;
    }];
    
	[self setState:PullRefreshNormal];

}

- (void)setBezierPathByScrollOffset:(float)offset
{
    if (offset > maxScrollOffset) {
        offset = maxScrollOffset;
    }
    else if (offset <0.0) {
        offset = 0.0;
    }
    else if (offset < maxScrollOffset / 7.0) {
        _currentEndDegree = (1 - offset / (maxScrollOffset / 7)) * (- 90.0);
    }
    else {
        _currentEndDegree = (offset - maxScrollOffset/ 7) / (maxScrollOffset / 7 * 6) * 225.0;
    }
//    NSLog(@"the currentEnd Degree is %f",_currentEndDegree);
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//绘制原点
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    UIBezierPath* pointPath;
    float point_x_point = sinf((_currentEndDegree + 90.0) * DEGREETORADIANS) * theCircleRadius;
    float point_y_point = cosf((_currentEndDegree + 90.0) * DEGREETORADIANS) * theCircleRadius;
    pointPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(160.0 + point_x_point, 22.0 - point_y_point)
                                           radius:1
                                       startAngle:-90.0 * DEGREETORADIANS
                                         endAngle:270.0 * DEGREETORADIANS
                                        clockwise:YES];
    pointPath.lineWidth = 2.0;
    [pointPath stroke];
    CGContextStrokePath(context);

//    NSLog(@"the current point_x_point is %f %f",point_x_point,point_y_point);
//绘制圆圈
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    UIBezierPath* aPath;
    aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(160.0, 22.0)
                                               radius:theCircleRadius
                                           startAngle:-90.0 * DEGREETORADIANS
                                             endAngle:_currentEndDegree * DEGREETORADIANS
                                            clockwise:YES];
    aPath.lineWidth = 1.0;
    [aPath stroke];
    CGContextStrokePath(context);
}

@end
