//
//  WXYNavigationBar.h
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMBlurView.h"
#define ROOT_NAV_BAR_HEIGHT 65.f

@interface WXYNavigationBar : AMBlurView

@property (strong, nonatomic) NSLayoutConstraint* navBarHeightConstraint;

@property (weak, nonatomic) UIView* snapShotView;

- (id)init;

- (void)refresh;

@end
