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
#import "CastViewImageTransitionAnimation.h"
#import "CastViewImageDismissTransitionAnimation.h"
#import "CastImageViewController.h"

#define contantHeight 110.0
#define contentLabelLineSpace 6.0
#define tableViewSeprateLine [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]

@interface WXYCastViewController ()<CastImageViewControllerDelegate>

//@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSArray * weiboContentArray;
@property (nonatomic, weak) UIImageView * selectedImageView;
@property (nonatomic, strong) CastViewImageTransitionAnimation * imageTransitionAnimation;
@property (nonatomic, strong) CastViewImageDismissTransitionAnimation * imageDismissTransitionAnimation;

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
    _imageTransitionAnimation = [CastViewImageTransitionAnimation new];
    _imageDismissTransitionAnimation = [CastViewImageDismissTransitionAnimation new];
    
    UIView *bgview = [[UIView alloc]init];
    [bgview setBackgroundColor:SHARE_SETTING_MANAGER.themeColor];
    [self.tableView setBackgroundView:bgview];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self fetchWeiboContent];
    
    UINib *castNib = [UINib nibWithNibName:@"CastViewCell" bundle:[NSBundle bundleForClass:[CastViewCell class]]];
    [self.tableView registerNib:castNib forCellReuseIdentifier:@"CastViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
}

- (void)fetchWeiboContent
{
    [SHARE_NW_ENGINE getHomeTimelineOfCurrentUserSucceed:^(NSArray * resultArray){
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
    return [_weiboContentArray count];;
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
    cell.backgroundColor = [UIColor clearColor];
    
//    UIView *selectedBackgroundView = [[UIView alloc]init];
//    [selectedBackgroundView setBackgroundColor:[UIColor clearColor]];
//    cell.selectedBackgroundView = selectedBackgroundView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewWillBeginDragging:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewWillBeginDragging:scrollView];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidScroll:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewDidScroll:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidEndDragging:willDecelerate:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidEndDecelerating:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewDidEndDecelerating:scrollView];
    }
}
#pragma mark - calculate weiboCell Height
- (float)cellHeightForRowAtIndex:(NSInteger)row
{
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:row];
    float cellHeight = contantHeight;
    if (currentCellStatus.bmiddlePicURL != nil) {
        cellHeight += 180.0;
    }
    NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:currentCellStatus.text]
                                                                      WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                         withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                     withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                        withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                  withLabelLineSpace:contentLabelLineSpace];
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
    
    [self.navigationController pushViewController:comRepViewController animated:YES];
}

- (void)clickRepostButtonByStatus:(Status *)status
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL];
    ComRepViewController * comRepViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ComRepViewController"];
    comRepViewController.currentStatus = status;
    [self.navigationController pushViewController:comRepViewController animated:YES];
}

- (void)presentDetailImageViewWithImageView:(UIImageView *)imageView
                             withInitalRect:(CGRect)initalRect
{
    _selectedImageView = imageView;
    _selectedImageView.hidden = YES;
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL];
    CastImageViewController * toVc = [storyBoard instantiateViewControllerWithIdentifier:@"CastImageViewController"];
    
    toVc.delegate = self;
    CGPoint offsetRect = [_tableView contentOffset];
    initalRect.origin.y -= offsetRect.y;
    
    UIImageView * testView = [[UIImageView alloc]initWithImage:imageView.image];
    toVc.weiboDetailImageView = testView;
    toVc.initialRect = initalRect;
    
    toVc.transitioningDelegate = self;
    [self presentViewController:toVc animated:YES completion:nil];
}

#pragma mark - CastImageViewDelegate
- (void)castImageDidDismiss:(CastImageViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        _selectedImageView.hidden = NO;
    }];
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
    return self.imageDismissTransitionAnimation;
}
@end
