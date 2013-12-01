//
//  WXYRootTabbarViewController.h
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXYSolidTabBar.h"
#import "WXYScrollHiddenDelegate.h"

@interface WXYRootTabbarViewController : UITabBarController<WXYScrollHiddenDelegate, WXYSolidTabBarDelegate>

@end
