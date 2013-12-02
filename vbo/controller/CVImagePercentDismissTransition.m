//
//  CVPercentDismissTransitionAnimation.m
//  vbo
//
//  Created by Emerson on 13-12-2.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CVImagePercentDismissTransition.h"

@interface CVImagePercentDismissTransition()

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;

@end


@implementation CVImagePercentDismissTransition

//-(void)wireToViewController:(UIViewController *)viewController
//{
//    self.presentingVC = viewController;
//}

- (void)openDelegateInteraction
{
    self.interacting = YES;
}

- (void)closeDelegateInteraction
{
    self.interacting = NO;
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)cvDelegateupdateInteractiveTransition:(float)fraction {
    [self updateInteractiveTransition:fraction];
}

- (void)cvDelegatefinishInteractiveTransition {
    [self finishInteractiveTransition];
}

- (void)cvDelegatecancelInteractiveTransition {
    [self cancelInteractiveTransition];
}

@end
