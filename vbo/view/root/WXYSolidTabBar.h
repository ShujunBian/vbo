//
//  WXYTabBar.h
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXYTabBarSolidButton.h"

#define ROOT_TAB_BAR_HEIGHT 50.f

@class WXYSolidTabBar;
typedef enum
{
    WXYTabBarButtonTypeWeibo,
    WXYTabBarButtonTypeDiscover,
    WXYTabBarButtonTypeMessage,
    WXYTabBarButtonTypeMine,
    WXYTabBarButtonTypePost
}WXYTabBarButtonType;

@protocol WXYSolidTabBarDelegate <NSObject>

- (void)tabBar:(WXYSolidTabBar*)tabBar buttonPressed:(WXYTabBarButtonType)type;

@end


@interface WXYSolidTabBar : UIView

- (id)init;

- (void)refresh;
@property (weak, nonatomic) NSObject<WXYSolidTabBarDelegate>* delegate;

@end
