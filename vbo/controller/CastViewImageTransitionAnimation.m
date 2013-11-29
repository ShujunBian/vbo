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
    return 3.0f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    CastImageViewController *toVC = (CastImageViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    toVC.view.frame = [transitionContext initialFrameForViewController:toVC];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0.0 options:7 << 12 animations:^{
        fromVC.view.alpha = 0.0;
        toVC.weiboDetailImageView.frame = CGRectMake(0, 0, 320, 568);
    }completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

@end