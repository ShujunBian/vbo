//
//  WXYCastViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYCastViewController.h"
#import "WXYNetworkEngine.h"
#import "ComRepViewController.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+MKNetworkKitAdditions.h"
#import "NSNotificationCenter+Addition.h"
#import "WXYSettingManager.h"
#import "UIImage+ImageEffects.h"
#import "ScreenShotHelper.h"
#import "WXYScrollHiddenDelegate.h"
#import "CVImageTransitionAnimation.h"
#import "CVImageDismissTransitionAnimation.h"
#import "CastImageViewController.h"
#import "CVDragIndicatorView.h"
#import "CVLoadIndicatorView.h"
#import "CVImagePercentDismissTransition.h"
#import "CVImagePercentDismissTransitionAnimation.h"

#define kContantHeight 110.0
#define kContentLabelLineSpace 6.0
#define kNavigationbarHeight 64.0
#define kScreenShotTableView_Y_PointContentOffset -109.0
#define kRefreshViewHeight 44.0
#define tableViewSeprateLine [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]

@interface WXYCastViewController ()<CastImageViewControllerDelegate,CVDragIndicatorViewDelegate,CVLoadIndicatorViewDelegate>

//@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSArray * weiboContentArray;
@property (nonatomic, weak) UIImageView * selectedImageView;
@property (nonatomic, strong) CVImageTransitionAnimation * imageTransitionAnimation;
@property (nonatomic, strong) CVImageDismissTransitionAnimation * imageDismissTransitionAnimation;
@property (nonatomic, strong) CVImagePercentDismissTransitionAnimation * imagePercentDismissTransitionAnimation;
@property (nonatomic, strong) CVImagePercentDismissTransition * imagePercentDismissTransition;
@property (nonatomic, strong) CVDragIndicatorView * dragIndicatorView;
@property (nonatomic, strong) CVLoadIndicatorView * loadIndicatorView;

@property (nonatomic) BOOL reloading;
//@property (nonatomic) float test;
@end

@implementation WXYCastViewController

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
	// Do any additional setup after loading the view.
    _imageTransitionAnimation = [CVImageTransitionAnimation new];
    _imageDismissTransitionAnimation = [CVImageDismissTransitionAnimation new];
    _imagePercentDismissTransition = [CVImagePercentDismissTransition new];
    _imagePercentDismissTransitionAnimation = [CVImagePercentDismissTransitionAnimation new];
    
    UIView *bgview = [[UIView alloc]init];
    [bgview setBackgroundColor:SHARE_SETTING_MANAGER.themeColor];
    [self.tableView setBackgroundView:bgview];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self fetchWeiboContent];
    
    UINib *castNib = [UINib nibWithNibName:@"CastViewCell" bundle:[NSBundle bundleForClass:[CastViewCell class]]];
    [self.tableView registerNib:castNib forCellReuseIdentifier:@"CastViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
    
    [self.tableView addSubview:self.dragIndicatorView];
    [self.tableView addSubview:self.loadIndicatorView];
//    _test = 0.0;
}

- (void)fetchWeiboContent
{
    [SHARE_NW_ENGINE getHomeTimelineOfCurrentUserPage:1
                                              Succeed:^(NSArray * resultArray){
                                                  self.weiboContentArray = resultArray;
                                                  [self.tableView reloadData];
                                                  [NSNotificationCenter postDidFetchCurrentUserNameNotification];
        
        //        [self performSelector:@selector(snap) withObject:nil afterDelay:5.0];
        
    }error:nil];
}


//- (void)snap
//{
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320,568), NO, 2);
//    [self.view drawViewHierarchyInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) afterScreenUpdates:NO];
//    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    UIImageView * testView = [[UIImageView alloc]initWithImage:[snapshot applyTintEffectWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]]];
//    [testView setFrame:CGRectMake(0.0, 0.0, 320.0, 568.0)];
//    [self.view addSubview:testView];
//}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_dragIndicatorView setFrame:CGRectMake(0,
                                            -kRefreshViewHeight ,
                                            [UIScreen mainScreen].bounds.size.width,
                                            kRefreshViewHeight)];
    [_loadIndicatorView setFrame:CGRectMake(0,
                                            _tableView.bounds.size.height,
                                            [UIScreen mainScreen].bounds.size.width,
                                            kRefreshViewHeight)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_weiboContentArray == nil) {
        return 0;
    }
    return [_weiboContentArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"the %ld cell height of cell is %f",(long)[indexPath row],cellHeight);
    
    return [self cellHeightForRowAtIndex:[indexPath row]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:[indexPath row]];
    static NSString* cellIdentifier = @"CastViewCell";
    CastViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.delegateForCastViewCell = self;
    if (cell == nil)
    {
        cell = [[CastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setCellWithWeiboStatus:currentCellStatus isInCastView:YES];
    [self.view layoutIfNeeded];
    
    //    if (!_animator) {
    //        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    //    }
    
    return cell;
}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    if (scrollView.contentOffset.y >= -kNavigationbarHeight) {
        id<WXYScrollHiddenDelegate> delegate = nil;
        if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewWillBeginDragging:)])
        {
            delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
            [delegate wxyScrollViewWillBeginDragging:scrollView];
        }
//    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= -kNavigationbarHeight) {
        id<WXYScrollHiddenDelegate> delegate = nil;
        if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidScroll:)])
        {
            delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
            [delegate wxyScrollViewDidScroll:scrollView];
        }
    }
    [_dragIndicatorView refreshScrollViewDidScroll:scrollView];
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y >= -kNavigationbarHeight) {
        id<WXYScrollHiddenDelegate> delegate = nil;
        if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidEndDragging:willDecelerate:)])
        {
            delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
            [delegate wxyScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        }
    }

    [_dragIndicatorView refreshScrollViewDidEndDragging:scrollView];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= -kNavigationbarHeight) {
        id<WXYScrollHiddenDelegate> delegate = nil;
        if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidEndDecelerating:)])
        {
            delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
            [delegate wxyScrollViewDidEndDecelerating:scrollView];
        }
    }
}

#pragma mark - CVDragIndicatorViewDelegate
- (BOOL)refreshTableHeaderDataSourceIsLoading:(CVDragIndicatorView *)view
{
    //待取好数据后返回yes
    return _reloading;
}

- (void)refreshTableHeaderDidTriggerRefresh:(CVDragIndicatorView *)view
{
    [self reloadTableViewDataSource];
    [self.tableView setUserInteractionEnabled:NO];
    [SHARE_NW_ENGINE getHomeTimelineOfCurrentUserPage:1 Succeed:^(NSArray * resultArray){
        self.weiboContentArray = resultArray;
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
    }error:nil];

}

- (void)reloadTableViewDataSource{
	_reloading = YES;
}

- (void)doneLoadingTableViewData{
    _reloading = NO;
    [self.tableView setUserInteractionEnabled:YES];
    
    CGRect windowRect = [UIScreen mainScreen].bounds;
    UIImageView * screenShotImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                                                     - (kScreenShotTableView_Y_PointContentOffset + kRefreshViewHeight),
                                                                                     windowRect.size.width,
                                                                                     windowRect.size.height + kScreenShotTableView_Y_PointContentOffset)];
    [screenShotImageView setImage:[self viewScreenshot]];
    [self.view addSubview:screenShotImageView];
    self.tableView.hidden = YES;
    self.tableView.frame = CGRectMake(0, -windowRect.size.height, windowRect.size.width, windowRect.size.height);
    [self.tableView reloadData];
    [UIView animateWithDuration:0.7 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.hidden = NO;
        self.tableView.frame = CGRectMake(0, 0, windowRect.size.width, windowRect.size.height);
        screenShotImageView.alpha = 0.0;
        screenShotImageView.frame = CGRectMake(0,
                                               windowRect.size.height,
                                               windowRect.size.width,
                                               windowRect.size.height + kScreenShotTableView_Y_PointContentOffset);
    }completion:^(BOOL finished){
    }];
	[_dragIndicatorView refreshScrollViewDataSourceDidFinishedLoading:_tableView];
}

#pragma mark - CVLoadIndicatorView Delegate
- (void)loadMoreTableFooterDidTriggerLoadMore:(CVLoadIndicatorView *)view
{
    
}

#pragma mark - ScreenShot
- (UIImage *)viewScreenshot
{
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(windowSize.width, windowSize.height + kScreenShotTableView_Y_PointContentOffset), NO, 2);
    [self.view drawViewHierarchyInRect:CGRectMake(0, kScreenShotTableView_Y_PointContentOffset, self.view.frame.size.width, self.view.frame.size.height) afterScreenUpdates:NO];
    UIImage * snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshot;
}

#pragma mark - calculate weiboCell Height
- (float)cellHeightForRowAtIndex:(NSInteger)row
{
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:row];
//    _test += [self cellHeightForStatus:currentCellStatus];
//    NSLog(@"the test is %f",_test);
    return [self cellHeightForStatus:currentCellStatus];
}

- (float)cellHeightForStatus:(Status *)currentCellStatus
{
    float cellHeight = kContantHeight;
    if (currentCellStatus.bmiddlePicURL != nil) {
        cellHeight += 180.0;
    }
    NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:currentCellStatus.text]
                                                                      WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                         withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                     withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                        withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                  withLabelLineSpace:kContentLabelLineSpace];
    cellHeight += [UITextViewHelper HeightForAttributedString:contentString withWidth:288.0f];
    
    if (currentCellStatus.repostStatus != nil) {
        cellHeight += [CastViewCell getHeightofCastRepostViewByStatus:currentCellStatus.repostStatus] + 20.0;
    }
    
    return cellHeight;
}

- (void)preferredContentSizeChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
}

#pragma mark - CastViewCellDelegate
- (void)clickCommentButtonByStatus:(Status *)status
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL];
    ComRepViewController * comRepViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ComRepViewController"];
    comRepViewController.currentStatus = status;
    comRepViewController.currentType = CommentType;
    [self.navigationController pushViewController:comRepViewController animated:YES];
}

- (void)clickRepostButtonByStatus:(Status *)status
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL];
    ComRepViewController * comRepViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ComRepViewController"];
    comRepViewController.currentStatus = status;
    comRepViewController.currentType = RepostType;
    [self.navigationController pushViewController:comRepViewController animated:YES];
}

- (void)clickMoreButtonByStatus:(Status *)status
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL];
    ComRepViewController * comRepViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ComRepViewController"];
    comRepViewController.currentStatus = status;
    comRepViewController.currentType = MoreType;
    [self.navigationController pushViewController:comRepViewController animated:YES];
}

- (void)presentDetailImageViewWithImageView:(UIImageView *)imageView
                             withInitalRect:(CGRect)initalRect
{
    _selectedImageView = imageView;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL];
    CastImageViewController * toVc = [storyBoard instantiateViewControllerWithIdentifier:@"CastImageViewController"];
    
    
    toVc.transitionDelegate = self.imagePercentDismissTransition;
    toVc.delegate = self;
    CGPoint offsetRect = [_tableView contentOffset];
    initalRect.origin.y -= offsetRect.y;
    
    UIImageView * testView = [[UIImageView alloc]initWithImage:imageView.image];
    toVc.weiboDetailImageView = testView;
    toVc.initialRect = initalRect;
    
    toVc.transitioningDelegate = self;
    [self presentViewController:toVc animated:YES completion:^{
        _selectedImageView.hidden = YES;
    }];
}

#pragma mark - CastImageViewDelegate
- (void)castImageDidDismiss:(CastImageViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        _selectedImageView.hidden = NO;
    }];
}

#pragma mark - Property
- (CVDragIndicatorView *)dragIndicatorView
{
    if (!_dragIndicatorView) {
        _dragIndicatorView = [[CVDragIndicatorView alloc]initWithFrame:CGRectMake(0,
                                                                                  - kRefreshViewHeight,
                                                                                  [UIScreen mainScreen].bounds.size.width,
                                                                                  kRefreshViewHeight)];
        _dragIndicatorView.delegate = self;
    }
    return _dragIndicatorView;
}

- (CVLoadIndicatorView *)loadIndicatorView
{
    if (!_loadIndicatorView) {
        _loadIndicatorView = [[CVLoadIndicatorView alloc]initWithFrame:CGRectMake(0,
                                                                                  kRefreshViewHeight,
                                                                                  [UIScreen mainScreen].bounds.size.width,
                                                                                  kRefreshViewHeight)];
        _loadIndicatorView.delegate = self;
    }
    return _loadIndicatorView;
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewDidUnload];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return self.imageTransitionAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.imagePercentDismissTransition.interacting ? self.imagePercentDismissTransitionAnimation : self.imageDismissTransitionAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.imagePercentDismissTransition.interacting ? self.imagePercentDismissTransition : nil;
}
@end
