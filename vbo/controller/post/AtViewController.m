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
#import "WXYNetworkEngine.h"

@interface AtViewController ()

@end

@implementation AtViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.0f];
    
    
    // Navigation settings
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0,0,0,44)];
    
    title.text = @"@";
    
    title.textColor = [UIColor blackColor];
    
    title.font = [UIFont fontWithName:@"Helvetica Neue-Medium" size:17];
    
    self.navigationItem.titleView = title;
    
    //custom nav left back button
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 67, 21);
    
    [backBtn setImage:[UIImage imageNamed:@"backToPost.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    //right button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分组" style:UIBarButtonItemStyleBordered target:self action:@selector(postWeibo)];
    
    self.navigationItem.leftBarButtonItem.tintColor = SHARE_SETTING_MANAGER.themeColor;
    self.navigationItem.rightBarButtonItem.tintColor = SHARE_SETTING_MANAGER.themeColor;
    
}
-(void)cancel
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)postWeibo
{
}



@end
