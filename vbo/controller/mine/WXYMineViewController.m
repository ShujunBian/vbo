//
//  WXYMineViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYLoginManager.h"
#import "WXYMineViewController.h"
#import "WXYUserProfileView.h"
#import "WXYDataModel.h"
//#import "DDLogLevelGlobal.h"
#import "DDLog.h"
static int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface WXYMineViewController ()
- (void)accountButtonPressed;
- (void)settingButtonPressed;
@end

@implementation WXYMineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"账户" style:UIBarButtonItemStylePlain target:self action:@selector(accountButtonPressed)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonPressed)];
    self.title = SHARE_LOGIN_MANAGER.currentUserInfo.userName;

    
    WXYUserProfileView* provileView = [WXYUserProfileView makeView];
    
    User* currentUser = [SHARE_DATA_MODEL getUserById:SHARE_LOGIN_MANAGER.currentUserInfo.userId.longLongValue];
    [provileView bind:currentUser];
    [self.contentScrollView addSubview:provileView];
    
}

- (void)accountButtonPressed
{
    DDLogVerbose(@"account button pressed");
}
- (void)settingButtonPressed
{
    DDLogVerbose(@"setting button pressed");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
