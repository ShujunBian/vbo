//
//  WXYUserProfileViewController.m
//  vbo
//
//  Created by wxy325 on 12/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYUserProfileViewController.h"
#import "TShowViewController.h"
#import "TCommentViewController.h"
#import "WXYNetworkEngine.h"
#import "WXYNetworkEngine.h"

@interface WXYUserProfileViewController ()

@property (strong, nonatomic) WXYProfileTableViewDelegateObject* tableViewDelegateObject;
@property (strong, nonatomic) UIBarButtonItem* rightItem;
- (void)rightItemPressed;
@end

@implementation WXYUserProfileViewController
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
	// Do any additional setup after loading the view.
    self.tableViewDelegateObject = [[WXYProfileTableViewDelegateObject alloc] initWithTableView:self.tableView];
    self.tableViewDelegateObject.delegate = self;
    self.tableView.dataSource = self.tableViewDelegateObject;
    self.tableView.delegate = self.tableViewDelegateObject;
    self.rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemPressed)];


    self.navigationItem.rightBarButtonItem = self.rightItem;
    if (self.userName)
    {
        self.user = [SHARE_DATA_MODEL getUserByScreenName:self.userName];
    }
    else
    {
        self.userName = self.user.screenName;
    }
    self.title = self.userName;
    if (self.user)
    {
        [self.tableViewDelegateObject bind:self.user];
    }
    [SHARE_NW_ENGINE getUserInfoId:nil
                      orScreenName:self.userName
                           succeed:^(User *user)
     {
         self.user = user;
         [self.tableViewDelegateObject  bind:user];
         if (self.user)
         {
             if (self.user.following.boolValue)
             {
                 self.rightItem.title = @"已关注";
             }
             else
             {
                 self.rightItem.title = @"关注";
             }
         }
     }
                             error:^(NSError *error)
     {
#warning 错误未处理
     }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    if (self.user)
    {
        if (self.user.following.boolValue)
        {
            self.rightItem.title = @"已关注";
        }
        else
        {
            self.rightItem.title = @"关注";
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Profile Delegate
- (void)allButtonPressed
{
    TShowViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TShowViewController"];
    
    vc.fetchBlock = ^(ArrayBlock succeedBlock, ErrorBlock errorBlock)
    {
        [SHARE_NW_ENGINE getTimelineOfUser:self.user page:1 succeed:succeedBlock error:errorBlock];
    };
    vc.currentShowType = ShowWeibo;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)collectButtonPressed
{
//    TShowViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TShowViewController"];
//    vc.title = @"收藏";
//    vc.fetchBlock = ^(ArrayBlock succeedBlock, ErrorBlock errorBlock){
//        [SHARE_NW_ENGINE getFavoriteStatusPage:1 succeed:succeedBlock error:errorBlock];
//    };
//    vc.currentShowType = ShowWeibo;
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)followingPressed
{
    TShowViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TShowViewController"];
    vc.title = @"收藏";
    vc.fetchBlock = ^(ArrayBlock succeedBlock, ErrorBlock errorBlock){
        [SHARE_NW_ENGINE getFirstFriendListById:self.user.userID succeed:succeedBlock error:errorBlock];
    };
    vc.currentShowType = ShowUser;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)rightItemPressed
{
    if (!self.user.following.boolValue)
    {
        [SHARE_NW_ENGINE friendshipAdd:self.user.userID succeed:^(User *user) {
            self.user = user;
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"关注成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            self.rightItem.title = @"已关注";
        } error:^(NSError *error) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"关注失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }];
    }
    else
    {
        [SHARE_NW_ENGINE friendshipDestroy:self.user.userID succeed:^(User *user) {
            self.user = user;
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"取消关注成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            self.rightItem.title = @"关注";
        } error:^(NSError *error) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"取消关注失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }];
    }
}
@end
