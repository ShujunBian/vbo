//
//  WXYScroillHiddenDelegate.h
//  vbo
//
//  Created by wxy325 on 11/29/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
//用于tabBar navBar滑动缩小、隐藏
@class UIScrollView;

@protocol WXYScrollHiddenDelegate <NSObject>

- (void)wxyScrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)wxyScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)wxyScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)wxyScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
