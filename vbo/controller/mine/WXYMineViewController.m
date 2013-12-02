//
//  WXYMineViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYLoginManager.h"
#import "WXYMineViewController.h"
//#import "WXYUserProfileView.h"

#import "WXYUserProfileNumberView.h"
#import "WXYUserProfilePhotoView.h"
#import "WXYUserProfileGenderAndLocationCell.h"

#import "UIImageView+MKNetworkKitAdditions.h"

#import "WXYDataModel.h"
//#import "DDLogLevelGlobal.h"
#import "DDLog.h"
static int ddLogLevel = LOG_LEVEL_VERBOSE;

enum
{
    kRowGenderAndLocation = 0,
    kRowUserDescription = 1
};

@interface WXYMineViewController ()
@property (strong, nonatomic) WXYUserProfileNumberView* numberView;
@property (strong, nonatomic) WXYUserProfilePhotoView* photoView;
@property (strong, nonatomic) WXYUserProfileGenderAndLocationCell* genderAndLocationCell;
@property (strong, nonatomic) UITableViewCell* descriptionCell;

- (void)accountButtonPressed;
- (void)settingButtonPressed;

- (void)bind:(User*)user;
@end

@implementation WXYMineViewController
#pragma mark - Getter And Setter Method
- (WXYUserProfileNumberView*)numberView
{
    if (!_numberView)
    {
        _numberView = [WXYUserProfileNumberView makeView];
    }
    return _numberView;
}
- (WXYUserProfilePhotoView*)photoView
{
    if (!_photoView)
    {
        _photoView = [WXYUserProfilePhotoView makeView];
    }
    return _photoView;
}
- (WXYUserProfileGenderAndLocationCell*)genderAndLocationCell
{
    if (!_genderAndLocationCell)
    {
        [self.tableView registerNib:[UINib nibWithNibName:@"WXYUserProfileCells" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"WXYUserProfileGenderAndLocationCell"];
        _genderAndLocationCell = [self.tableView dequeueReusableCellWithIdentifier:@"WXYUserProfileGenderAndLocationCell"];
    }
    return _genderAndLocationCell;
}
- (UITableViewCell*)descriptionCell
{
    if (!_descriptionCell)
    {
        _descriptionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"USER_PROFILE_DESCRIPTION_CELL"];
        _descriptionCell.contentView.backgroundColor = [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.f];
    }
    return _descriptionCell;
}


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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"账户" style:UIBarButtonItemStylePlain target:self action:@selector(accountButtonPressed)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonPressed)];
    self.title = SHARE_LOGIN_MANAGER.currentUserInfo.userName;

    self.tableView.tableHeaderView = self.photoView;
    [self bind:SHARE_LOGIN_MANAGER.currentUser];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
//        [self.tableView registerNib:[UINib nibWithNibName:@"WatchListTableViewCell" bundle:nil] forCellReuseIdentifier:@"WatchListTableCell"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (void)accountButtonPressed
{
    DDLogVerbose(@"account button pressed");
}
- (void)settingButtonPressed
{
    DDLogVerbose(@"setting button pressed");
}
#pragma mark - Private Method
- (void)bind:(User*)user
{
    [self.photoView.headPhotoImageView setImageFromURL:[NSURL URLWithString:user.avatarLargeUrl]];
    self.numberView.followerNumberLabel.text = user.followersCount.stringValue;
    self.numberView.followingNumberLabel.text = user.following.stringValue;
    self.genderAndLocationCell.genderLabel.text = user.gender;
    self.genderAndLocationCell.locationLabel.text = user.location;
    self.descriptionCell.textLabel.text = user.userDescription;
}

#pragma mark - UITableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    switch (indexPath.row) {
        case kRowGenderAndLocation:
            cell = self.genderAndLocationCell;
            break;
        case kRowUserDescription:
            cell = self.descriptionCell;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark - UITableView Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.numberView;
    }
    else
    {
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 44.f;
    }
    else
    {
        return 0.f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}
@end
