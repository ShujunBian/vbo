//
//  WXYUserProfileViewController.m
//  vbo
//
//  Created by wxy325 on 12/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYUserProfileViewController.h"
#import "WXYProfileTableViewDelegateObject.h"
#import "WXYNetworkEngine.h"

@interface WXYUserProfileViewController ()

@property (strong, nonatomic) WXYProfileTableViewDelegateObject* tableViewDelegateObject;
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
    
    self.tableView.dataSource = self.tableViewDelegateObject;
    self.tableView.delegate = self.tableViewDelegateObject;
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
