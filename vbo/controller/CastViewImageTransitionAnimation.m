//
//  CastViewImageTransitionAnimation.m
//  vbo
//
//  Created by Emerson on 13-11-27.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CastViewImageTransitionAnimation.h"
#import "CastImageViewController.h"

@implementation CastViewImageTransitionAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    CastImageViewController *toVC = (CastImageViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
#pragma mark - 先放大后缩小动画效果
//    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
//        
//        [toVC.view setBackgroundColor:[UIColor blackColor]];
//        CGSize imageSize = toVC.weiboDetailImageView.image.size;
//        float widthScaleRate = imageSize.width / [UIScreen mainScreen].bounds.size.width;
//        float heightScaleRate = imageSize.height / [UIScreen mainScreen].bounds.size.height;
//        BOOL fillWidth;
//        fillWidth = widthScaleRate > heightScaleRate ? YES : NO;
//        if (fillWidth) {
//            toVC.weiboDetailImageView.frame = CGRectMake(-imageSize.height / widthScaleRate * 0.05,
//                                                         ([UIScreen mainScreen].bounds.size.height - imageSize.height / widthScaleRate * 1.1) / 2,
//                                                         imageSize.width / widthScaleRate * 1.1,
//                                                         imageSize.height / widthScaleRate * 1.1);
//        }
//        else {
//            toVC.weiboDetailImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - imageSize.width / heightScaleRate * 1.1) / 2,
//                                                         - imageSize.height / heightScaleRate * 0.05,
//                                                         imageSize.width / heightScaleRate * 1.1,
//                                                         imageSize.height / heightScaleRate * 1.1);
//        }
//    }completion:^(BOOL finished){
//        if (finished) {
//            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                CGSize imageSize = toVC.weiboDetailImageView.image.size;
//                float widthScaleRate = imageSize.width / [UIScreen mainScreen].bounds.size.width;
//                float heightScaleRate = imageSize.height / [UIScreen mainScreen].bounds.size.height;
//                BOOL fillWidth;
//                fillWidth = widthScaleRate > heightScaleRate ? YES : NO;
//                if (fillWidth) {
//                    toVC.weiboDetailImageView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - imageSize.height / widthScaleRate) / 2,
//                                                                 imageSize.width / widthScaleRate ,
//                                                                 imageSize.height / widthScaleRate );
//                }
//                else {
//                    toVC.weiboDetailImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - imageSize.width / heightScaleRate) / 2, 0,
//                                                                 imageSize.width / heightScaleRate,
//                                                                 imageSize.height / heightScaleRate);
//                }
//            }completion:^(BOOL finished) {
//                [transitionContext completeTransition:YES];
//            }];
//        }
//    }];
    
#pragma mark - 正常动画效果
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        
        [toVC.view setBackgroundColor:[UIColor blackColor]];
        float widthScaleRate = toVC.weiboDetailImageView.image.size.width / [UIScreen mainScreen].bounds.size.width;
        float heightScaleRate = toVC.weiboDetailImageView.image.size.height / [UIScreen mainScreen].bounds.size.height;
        CGSize imageSize = toVC.weiboDetailImageView.image.size;
        BOOL fillWidth;
        fillWidth = widthScaleRate > heightScaleRate ? YES : NO;
        if (fillWidth) {
            toVC.weiboDetailImageView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - imageSize.height / widthScaleRate) / 2,
                                                         imageSize.width / widthScaleRate,
                                                         imageSize.height / widthScaleRate);
        }
        else {
            toVC.weiboDetailImageView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - imageSize.width / heightScaleRate) / 2, 0,
                                                         imageSize.width / heightScaleRate,
                                                         imageSize.height / heightScaleRate);
        }
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end