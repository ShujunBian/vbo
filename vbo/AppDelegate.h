//
//  AppDelegate.h
//  vbo
//
//  Created by Emerson on 13-10-11.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
