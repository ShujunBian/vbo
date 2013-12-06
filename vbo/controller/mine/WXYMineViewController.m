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
    kRowUserDescription,
    kRowUserStatusCount,
    kRowUserStatus,
    kRowMoreStatus,
    kRowCollectionStatus,
    kRowZanStatus,
    kRowCount
};

@interface WXYMineViewController ()
@property (strong, nonatomic) WXYUserProfileNumberView* numberView;
@property (strong, nonatomic) WXYUserProfilePhotoView* photoView;
@property (strong, nonatomic) WXYUserProfileGenderAndLocationCell* genderAndLocationCell;
@property (strong, nonatomic) UITableViewCell* descriptionCell;
@property (strong, nonatomic) UITableViewCell* statusCountCell;
@property (strong, nonatomic) CastViewCell* statusCell;
@property (strong, nonatomic) UITableViewCell* moreStatusCell;
@property (strong, nonatomic) UITableViewCell* collectionCell;
@property (strong, nonatomic) UITableViewCell* zanCell;

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
        _descriptionCell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14.f];
        _descriptionCell.textLabel.textColor = [UIColor colorWithRed:35.f/255.f green:35.f/255.f blue:35.f/255.f alpha:1.f];
    }
    return _descriptionCell;
}
- (UITableViewCell*)statusCountCell
{
    if (!_statusCountCell)
    {
        _statusCountCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"USER_PROFILE_STATUS_COUNT_CELL"];
    }
    return _statusCountCell;
}

- (CastViewCell*)statusCell
{
    if (!_statusCell)
    {
//        Status * currentCellStatus = [_weiboContentArray objectAtIndex:[indexPath row]];
        
        _statusCell = [[CastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"USER_PROFILE_STATUS_IDENTIFIER"];
#warning delegate未实现
//        _statusCell.delegateForCastViewCell = self;
        
//        [cell setCellWithWeiboStatus:currentCellStatus isInCastView:YES];
    }
    return _statusCell;
}
- (UITableViewCell*)moreStatusCell
{
    if (!_moreStatusCell)
    {
        _moreStatusCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"USER_PROFILE_MORE_STATUS_CELL"];
        _moreStatusCell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17.f];
        _moreStatusCell.textLabel.text = @"查看更多微博";
        _moreStatusCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImage* separator = [UIImage imageNamed:@"hor_separator.png"];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:separator];
        imageView.frame = CGRectMake(16, 43, 304, 1);
        [_moreStatusCell.contentView addSubview:imageView];
        UIView* backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.f];
        _moreStatusCell.backgroundView = backgroundView;
    }
    return _moreStatusCell;
}
- (UITableViewCell*)collectionCell
{
    if (!_collectionCell)
    {
        _collectionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"USER_PROFILE_COLLECTION_CELL"];
        _collectionCell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17.f];
        _collectionCell.textLabel.text = @"收藏";
        _collectionCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImage* separator = [UIImage imageNamed:@"hor_separator.png"];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:separator];
        imageView.frame = CGRectMake(16, 43, 304, 1);
        [_collectionCell.contentView addSubview:imageView];
        UIView* backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.f];
        _collectionCell.backgroundView = backgroundView;
    }
    return _collectionCell;
}
- (UITableViewCell*)zanCell
{
    if (!_zanCell)
    {
        _zanCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"USER_PROFILE_ZAN_CELL"];
        _zanCell.textLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:17.f];
        _zanCell.textLabel.text = @"赞过的";
        _zanCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        _zanCell.imageView.image = [UIImage imageNamed:@"status_like.png"];
        
        UIView* backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.f];
        _zanCell.backgroundView = backgroundView;
    }
    return _zanCell;
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
    
    [SHARE_NW_ENGINE getUserInfoId:@(SHARE_LOGIN_MANAGER.currentUserInfo.userId.longLongValue)
                      orScreenName:nil succeed:^(User *user)
    {
        [self bind:user];
    }
                             error:^(NSError *error)
    {
#warning 错误处理未实现
    }];
    
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
    self.numberView.followingNumberLabel.text = user.friendCount.stringValue;
    NSString* genderStr = nil;
    if ([user.gender isEqualToString:@"m"])
    {
        genderStr = @"男";
    }
    else
    {
        genderStr = @"女";
    }
    self.genderAndLocationCell.genderLabel.text = genderStr;
    self.genderAndLocationCell.locationLabel.text = user.location;
    self.descriptionCell.textLabel.text = user.userDescription;
    self.statusCountCell.textLabel.text = user.statusCount.stringValue;
    if (user.statuses.array.count)
    {
        Status* status = user.statuses.array[0];
        [self.statusCell setCellWithWeiboStatus:status isInCastView:NO];
        self.statusCell.textLabel.text = status.text;
    }

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
            break;
        case kRowUserStatusCount:
            cell = self.statusCountCell;
            break;
        case kRowUserStatus:
            cell = self.statusCell;
            break;
        case kRowMoreStatus:
            cell = self.moreStatusCell;
            break;
        case kRowCollectionStatus:
            cell = self.collectionCell;
            break;
        case kRowZanStatus:
            cell = self.zanCell;
            break;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kRowCount;
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
