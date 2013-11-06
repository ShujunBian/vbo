//
//  WXYNavigationBar.h
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMBlurView.h"
#import "WXYBlurTextView.h"

@interface WXYNavigationBar : AMBlurView

@property (strong, nonatomic) WXYBlurTextView* titleTextView;

@property (strong, nonatomic) NSLayoutConstraint* navBarHeightConstraint;

@end
