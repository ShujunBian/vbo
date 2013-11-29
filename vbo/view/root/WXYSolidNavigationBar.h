//
//  WXYSolidNavigationBar.h
//  vbo
//
//  Created by wxy325 on 11/29/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ROOT_NAV_BAR_LONG_HEIGHT 65.f


@interface WXYSolidNavigationBar : UIView

@property (copy, nonatomic) NSString* title;
@property (strong, nonatomic) NSLayoutConstraint* heightConstraint;
@property (strong, nonatomic) UILabel* titleLabel;
@end
