//
//  screenShotHelper.m
//  vbo
//
//  Created by Emerson on 13-11-20.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "ScreenShotHelper.h"

static ScreenShotHelper * sharedScreenShotHelper;

@implementation ScreenShotHelper

+ (ScreenShotHelper *)sharedScreenShotHelper
{
    if (!sharedScreenShotHelper) {
        sharedScreenShotHelper = [[ScreenShotHelper alloc] init];
        sharedScreenShotHelper.currentContentOffsetPage = -1;
        sharedScreenShotHelper.blurredImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
        sharedScreenShotHelper.nextBlurredImageView = [[UIImageView alloc]init];
    }
    return sharedScreenShotHelper;
}

/*在需要动态截图的地方设置一个scrollview 在最开始截一次图（全屏大小）放于scrollview中
 *然后让这个scrollview随着tableview一起滚动，当contentOffSet.y到一定距离，例如504（568 - 64（导航栏高度））
 *时，再截一次图，让新截图在这个scrollview中继续滚动。
 *下面代码已处理向下滚动时截图，未处理向上滚动时截图，如果用这个方法需要再写向上滚动时的截图处理。
 *
 */
//- (void)screenShotSolution
//{
//    if ([ScreenShotHelper sharedScreenShotHelper].currentContentOffsetPage != floorf(self.tableView.contentOffset.y / 500.0) ) {
//        for (UIView * testView in self.testScrollView.subviews) {
//            [testView removeFromSuperview];
//        }
//        
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(320,568), NO, 2);
//        [self.view drawViewHierarchyInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) afterScreenUpdates:NO];
//        UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        [[ScreenShotHelper sharedScreenShotHelper].blurredImageView setImage:snapshot];
//        
//        [self.testScrollView addSubview:[ScreenShotHelper sharedScreenShotHelper].blurredImageView];
//        [self.testScrollView setContentSize:[ScreenShotHelper sharedScreenShotHelper].blurredImageView.frame.size];
//        [self.testScrollView setUserInteractionEnabled:NO];
//        
//        [ScreenShotHelper sharedScreenShotHelper].currentContentOffsetPage = floorf(self.tableView.contentOffset.y / 500.0);
//    }
//    CGPoint point = self.tableView.contentOffset;
//    point.y = ((int)(floorf(point.y)) % 500);
//    if (point.y < 0) {
//        point.y = 0;
//    }
//    
//    [self.testScrollView setContentOffset:point];
//
//}
@end
