//
//  WXYTabBar.h
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMBlurView.h"
#import "WXYTabBarButton.h"

#define ROOT_TAB_BAR_HEIGHT 50.f

@class WXYTabBar;
typedef enum
{
    WXYTabBarButtonTypeWeibo,
    WXYTabBarButtonTypeDiscover,
    WXYTabBarButtonTypeMessage,
    WXYTabBarButtonTypeMine,
    WXYTabBarButtonTypePost
}WXYTabBarButtonType;

@protocol WXYTabBarDelegate <NSObject>

- (void)tabBar:(WXYTabBar*)tabBar buttonPressed:(WXYTabBarButtonType)type;

@end


@interface WXYTabBar : AMBlurView

- (id)init;

- (void)refresh;
@property (weak, nonatomic) NSObject<WXYTabBarDelegate>* delegate;

@end
