//
//  CastViewImageDismissAnimation.m
//  vbo
//
//  Created by Emerson on 13-11-30.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CastViewImageDismissTransitionAnimation.h"
#import "WXYCastViewController.h"
#import "CastImageViewController.h"

@implementation CastViewImageDismissTransitionAnimation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    WXYCastViewController *toVC = (WXYCastViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CastImageViewController * fromVC = (CastImageViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    [UIView animateWithDuration:duration animations:^{
//        [fromVC.view setBackgroundColor:[UIColor clearColor]];
//        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
//        fromVC.weiboDetailImageView.frame = fromVC.initialRect;
//    }completion:^(BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
    
#warning 选用7 << 16 options后调节时间无效
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [fromVC.view setBackgroundColor:[UIColor clearColor]];
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        fromVC.weiboDetailImageView.frame = fromVC.initialRect;
        
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end
