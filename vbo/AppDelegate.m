//
//  AppDelegate.m
//  vbo
//
//  Created by Emerson on 13-10-11.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "AppDelegate.h"
#import "DDLog.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDLogLevelGlobal.h"
#import "WeiboSDK.h"
#import "WXYSettingManager.h"
#import "WXYLoginManager.h"
#import "WXYNetworkEngine.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //WeiboSDK 初始化
    [WeiboSDK registerApp:WEIBO_APP_KEY];
    [WeiboSDK enableDebugMode:YES];
    
    //DDLog 初始化
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    //DDLogVerbose(@"DDLog Test");
    
    
    // Override point for customization after application launch.
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - Weibo SDK Delegate
/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        WBAuthorizeResponse* wbResponse = (WBAuthorizeResponse *)response;
        __block LoginUserInfo* info = [[LoginUserInfo alloc] init];
        info.userId = wbResponse.userID;
        info.accessToken = wbResponse.accessToken;
        info.expireDate = wbResponse.expirationDate;
        [SHARE_LOGIN_MANAGER loginUser:info];
#warning 未获取用户信息，需要再次发送网络请求
        
        SHARE_SETTING_MANAGER.testAccessToken = [(WBAuthorizeResponse *)response accessToken];
        UIAlertView* alert = nil;
        if (SHARE_SETTING_MANAGER.testAccessToken)
        {
            alert = [[UIAlertView alloc] initWithTitle:@"成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        }
        else
        {
            alert = [[UIAlertView alloc] initWithTitle:@"失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        }
        [alert show];
        //        NSString *title = @"认证结果";
        //        NSString *message = [NSString stringWithFormat:@"响应状态: %d\nresponse.userId: %@\nresponse.accessToken: %@\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",
        //                             response.statusCode, [(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken], response.userInfo, response.requestUserInfo];
        //        UIAlertView *alert =
        //        [[UIAlertView alloc] initWithTitle:title
        //                                   message:message
        //                                  delegate:nil
        //                         cancelButtonTitle:@"确定"
        //                         otherButtonTitles:nil];
        
        //        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        
        //        [alert show];
        //        [alert release];
    }
}


@end
