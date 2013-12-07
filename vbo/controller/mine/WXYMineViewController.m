//
//  WXYMineViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYLoginManager.h"
#import "WXYNetworkEngine.h"
#import "WXYMineViewController.h"
#import "TShowViewController.h"


#import "UIImageView+MKNetworkKitAdditions.h"

#import "WXYDataModel.h"
//#import "DDLogLevelGlobal.h"
#import "DDLog.h"
static int ddLogLevel = LOG_LEVEL_VERBOSE;



@interface WXYMineViewController ()

- (void)accountButtonPressed;
- (void)settingButtonPressed;

@property (strong, nonatomic) WXYProfileTableViewDelegateObject* tableViewDelegateObject;
@end

@implementation WXYMineViewController
#pragma mark - Init Method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:248.f/255.f green:248.f/255.f blue:248.f/255.f alpha:1.f];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"账户" style:UIBarButtonItemStylePlain target:self action:@selector(accountButtonPressed)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonPressed)];
    self.title = SHARE_LOGIN_MANAGER.currentUserInfo.userName;

    self.tableViewDelegateObject = [[WXYProfileTableViewDelegateObject alloc] initWithTableView:self.tableView];
    self.tableViewDelegateObject.delegate = self;
    self.tableView.dataSource = self.tableViewDelegateObject;
    self.tableView.delegate = self.tableViewDelegateObject;
//        [self.tableView registerNib:[UINib nibWithNibName:@"WatchListTableViewCell" bundle:nil] forCellReuseIdentifier:@"WatchListTableCell"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.tableViewDelegateObject bind:SHARE_LOGIN_MANAGER.currentUser];
    
    [SHARE_NW_ENGINE getUserInfoId:@(SHARE_LOGIN_MANAGER.currentUserInfo.userId.longLongValue)
                      orScreenName:nil succeed:^(User *user)
     {
         [self.tableViewDelegateObject bind:user];
     }
                             error:^(NSError *error)
     {
#warning 错误处理未实现
     }];
}


#pragma mark - IBAction
- (void)accountButtonPressed
{

    UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WXYTestViewControllerIdentity"];
    [self presentViewController:vc animated:YES completion:nil];
    DDLogVerbose(@"account button pressed");
}
- (void)settingButtonPressed
{
    DDLogVerbose(@"setting button pressed");
}

#pragma mark - Profile Delegate
- (void)allButtonPressed
{
    TShowViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TShowViewController"];

    vc.fetchBlock = ^(ArrayBlock succeedBlock, ErrorBlock errorBlock)
    {
        [SHARE_NW_ENGINE getTimelineOfUser:SHARE_LOGIN_MANAGER.currentUser page:1 succeed:succeedBlock error:errorBlock];
    };
    vc.currentShowType = ShowWeibo;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)collectButtonPressed
{
    TShowViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TShowViewController"];
    vc.title = @"收藏";
    vc.fetchBlock = ^(ArrayBlock succeedBlock, ErrorBlock errorBlock){
        [SHARE_NW_ENGINE getFavoriteStatusPage:1 succeed:succeedBlock error:errorBlock];
    };
    vc.currentShowType = ShowWeibo;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)followerPressed
{

}
- (void)followingPressed
{
    TShowViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TShowViewController"];
    vc.title = @"收藏";
    vc.fetchBlock = ^(ArrayBlock succeedBlock, ErrorBlock errorBlock){
        [SHARE_NW_ENGINE getFirstFriendListById:SHARE_LOGIN_MANAGER.currentUser.userID succeed:succeedBlock error:errorBlock];
    };
    vc.currentShowType = ShowUser;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
