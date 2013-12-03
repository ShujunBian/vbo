//
//  CVImagePercentDismissTransitionAnimation.m
//  vbo
//
//  Created by Emerson on 13-12-2.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CVImagePercentDismissTransitionAnimation.h"
#import "WXYCastViewController.h"
#import "CastImageViewController.h"

@implementation CVImagePercentDismissTransitionAnimation

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
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [fromVC.view setBackgroundColor:[UIColor clearColor]];
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
