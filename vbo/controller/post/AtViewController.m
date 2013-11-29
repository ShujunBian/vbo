//
//  atViewController.m
//  vbo
//
//  Created by Pursue_finky on 13-11-27.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "atViewController.h"
#import "WXYSettingManager.h"
#import "UINavigationController+MHDismissModalView.h"

@interface AtViewController ()

@end

@implementation AtViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.title = @"@";
    
    [self.navigationController installMHDismissModalViewWithOptions:[[MHDismissModalViewOptions alloc] initWithScrollView:nil
                                                                                                                    theme:MHModalThemeWhite]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"新微博" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分组" style:UIBarButtonItemStyleBordered target:self action:@selector(postWeibo)];
    
    self.navigationItem.leftBarButtonItem.tintColor = SHARE_SETTING_MANAGER.themeColor;
    self.navigationItem.rightBarButtonItem.tintColor = SHARE_SETTING_MANAGER.themeColor;
    
}
-(void)cancel
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
-(void)postWeibo
{
}



@end
