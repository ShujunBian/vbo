//
//  CVPercentDismissTransitionAnimation.h
//  vbo
//
//  Created by Emerson on 13-12-2.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CastImageViewController.h"

@interface CVImagePercentDismissTransition : UIPercentDrivenInteractiveTransition <CastImageViewControllerTransitionDelegate>

@property (nonatomic, assign) BOOL interacting;

//- (void)wireToViewController:(UIViewController*)viewController;

@end
