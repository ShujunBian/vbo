//
//  WXYDiscoverViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYDiscoverViewController.h"
#import "Status.h"
#import "User.h"
#import "WXYNetworkEngine.h"
#import "DVRecommandCell.h"
#import "DVTableSectionView.h"
#import "CastViewCell.h"
#import "TShowViewController.h"
#import "WXYUserProfileViewController.h"

#define kContantHeight 110.0
#define kContentLabelLineSpace 6.0
#define kSectionHeaderHeight 79.0
#define kRecommandHeight 118.0

@interface WXYDiscoverViewController ()<CastViewCellDelegate,DVTableSectionViewDelegate>

@property (nonatomic, strong) NSArray * recommandArray;
@property (nonatomic, strong) NSArray * hotWeiboArray;
@property (nonatomic, strong) NSArray * hotTalkArray;
@property (nonatomic, strong) NSArray * hotUserArray;

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, strong) UISearchBar * searchBar;

@property (nonatomic, strong) DVTableSectionView * discoverTableSectionView;
@property (nonatomic) DiscoverSegmentType currentSegmentType;

@end

@implementation WXYDiscoverViewController

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
    
    _searchBar = [[UISearchBar alloc]init];
    self.navigationItem.titleView = _searchBar;
    [_searchBar setPlaceholder:@"搜索"];
    _searchBar.delegate = self;

    UITapGestureRecognizer * touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchInView)];
//    [self.view addGestureRecognizer:touch];
    
	// Do any additional setup after loading the view.
    UIView *bgview = [[UIView alloc]init];
    [bgview setBackgroundColor:SHARE_SETTING_MANAGER.themeColor];
    [self.tableView setBackgroundView:bgview];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    self.discoverTableSectionView.delegate = self;
    _currentSegmentType = DCSegmentWeibo;
    
    UINib *castNib = [UINib nibWithNibName:@"CastViewCell" bundle:[NSBundle bundleForClass:[CastViewCell class]]];
    [self.tableView registerNib:castNib forCellReuseIdentifier:@"CastViewCell"];
    
    [self fetchRecommandUserArray];
    [self fetchHotWeiboArray];
    [self fetchHotTopic];
    
}

- (void)fetchRecommandUserArray
{
    [SHARE_NW_ENGINE getHotUserSucceed:^(NSArray *resultArray) {
        _recommandArray = resultArray;
        _hotUserArray = resultArray;
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}

- (void)fetchHotWeiboArray
{
    [SHARE_NW_ENGINE getHotWeiboPage:1 succeed:^(NSArray *resultArray) {
        _hotWeiboArray = resultArray;
        [_tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}
- (void)fetchHotTopic
{
    [SHARE_NW_ENGINE getHotTopicSucceed:^(NSArray *resultArray) {
        _hotTalkArray = resultArray;
    } error:^(NSError *error) {
        
    }];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    else
        return kSectionHeaderHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    else {
        return _discoverTableSectionView;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else {
        switch (_currentSegmentType) {
            case DCSegmentTalk: {
                if (!_hotTalkArray)
                    return 0;
                else
                    return [_hotTalkArray count];
            }
            case DCSegmentWeibo: {
                if (!_hotWeiboArray)
                    return 0;
                else
                    return [_hotWeiboArray count];
            }
            case DCSegmentUser: {
                if (!_hotUserArray)
                    return 0;
                else
                    return [_hotUserArray count];
            }
            default: {
                return 0;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kRecommandHeight;
    }
    else {
        switch (_currentSegmentType) {
            case DCSegmentTalk: {
                return 44;
            }
            case DCSegmentWeibo: {
                return [self cellHeightForRowAtIndex:[indexPath row]];

            }
            case DCSegmentUser: {
                return 44;
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger sectionNumber = indexPath.section;
    if (sectionNumber == 0) {
        return;
    }
    else {
        switch (_currentSegmentType) {
            case DCSegmentTalk:
            {
                
                NSString* topic = [_hotTalkArray objectAtIndex:indexPath.row];
                
                TShowViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TShowViewController"];
                vc.title = [NSString stringWithFormat:@"#%@#",topic];
                vc.currentShowType = ShowWeibo;
                vc.fetchBlock = ^(ArrayBlock succeedBlock, ErrorBlock errorBlock)
                {
                    [SHARE_NW_ENGINE searchTopic:topic page:1 succeed:succeedBlock error:errorBlock];
                };

                [self.navigationController pushViewController:vc animated:YES];
                
                break;
            }
            case DCSegmentWeibo:
            {
                Status * currentCellStatus = [_hotWeiboArray objectAtIndex:[indexPath row]];
                break;
            }
            case DCSegmentUser:
            {
                User* user = [_hotUserArray objectAtIndex:indexPath.row];
                WXYUserProfileViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"WXYUserProfileViewController"];
                vc.user = user;
                [self.navigationController pushViewController:vc animated:YES];

                break;
            }

        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger sectionNumber = indexPath.section;
    if (sectionNumber == 0) {
        static NSString* cellIdentifier = @"DVRecommandCell";
        DVRecommandCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[DVRecommandCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setRecommandCellByUserArray:_recommandArray];
        [self.view layoutIfNeeded];
        
        return cell;
    }
    else {
        switch (_currentSegmentType) {
            case DCSegmentTalk: {

                NSString* topic = [_hotTalkArray objectAtIndex:indexPath.row];
                static NSString* cellIdentifier = @"TalkViewCell";
                UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                //                cell.delegateForCastViewCell = self;
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                //                [cell setCellWithWeiboStatus:currentCellStatus isInCastView:YES];
//                [cell.imageView setImageFromURLString:user.avatarLargeUrl placeHolderImage:nil animation:YES completion:nil];
                cell.textLabel.text = [NSString stringWithFormat:@"#%@#",topic];
                [self.view layoutIfNeeded];
                
                return cell;
                
                
            }
            case DCSegmentWeibo: {
                Status * currentCellStatus = [_hotWeiboArray objectAtIndex:[indexPath row]];
                static NSString* cellIdentifier = @"CastViewCell";
                CastViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                cell.delegateForCastViewCell = self;
                if (cell == nil)
                {
                    cell = [[CastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                [cell setCellWithWeiboStatus:currentCellStatus isInCastView:YES];
                [self.view layoutIfNeeded];
                
                return cell;
            }
            case DCSegmentUser: {
                User* user = [_hotUserArray objectAtIndex:indexPath.row];
                static NSString* cellIdentifier = @"UserViewCell";
                UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//                cell.delegateForCastViewCell = self;
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
//                [cell setCellWithWeiboStatus:currentCellStatus isInCastView:YES];
                [cell.imageView setImageFromURLString:user.avatarLargeUrl placeHolderImage:nil animation:YES completion:nil];
                cell.textLabel.text = user.screenName;
                [self.view layoutIfNeeded];
                
                return cell;
            }
            default:
                return nil;
        }
    }
}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)cellHeightForRowAtIndex:(NSInteger)row
{
    Status * currentCellStatus = [_hotWeiboArray objectAtIndex:row];
    return [CastViewCell getHeightForCastCellViewByStatus:currentCellStatus];
}

#pragma mark - CastViewCell Delegate
- (void)clickCommentButtonByStatus:(Status *)status
{
    
}

- (void)clickRepostButtonByStatus:(Status *)status
{
    
}

- (void)clickMoreButtonByStatus:(Status *)status
{
    
}

- (void)presentDetailImageViewWithImageView:(UIImageView *)imageView withInitalRect:(CGRect)initalRect
{
#warning 实现点击图片后Transition
}

#pragma mark - DVTableSectionView Delegate
- (void)segmentControlPressed:(DiscoverSegmentType)segmentType
{
    _currentSegmentType = segmentType;
    [_tableView reloadData];
}

#pragma private methods
- (void)touchInView
{
    [_searchBar resignFirstResponder];
}

#pragma mark - Property
- (DVTableSectionView *)discoverTableSectionView
{
    if (!_discoverTableSectionView) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"DVTableSectionView"
                                                      owner:self
                                                    options:nil];
        _discoverTableSectionView = [nibs objectAtIndex:0];
    }
    return _discoverTableSectionView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self touchInView];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString* topic = searchBar.text;
    
    TShowViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"TShowViewController"];
    vc.title = [NSString stringWithFormat:@"#%@#",topic];
    vc.currentShowType = ShowWeibo;
    vc.fetchBlock = ^(ArrayBlock succeedBlock, ErrorBlock errorBlock)
    {
        [SHARE_NW_ENGINE searchTopic:topic page:1 succeed:succeedBlock error:errorBlock];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
