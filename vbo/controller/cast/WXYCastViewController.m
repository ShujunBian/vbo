//
//  WXYCastViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYCastViewController.h"
#import "CastRepostView.h"
#import "WXYNetworkEngine.h"
#import "ComRepViewController.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+MKNetworkKitAdditions.h"
#import "NSNotificationCenter+Addition.h"
#import "WXYSettingManager.h"
#import "UIImage+ImageEffects.h"
#import "ScreenShotHelper.h"

#define contantHeight 110.0
#define contentLabelLineSpace 6.0
#define tableViewSeprateLine [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]

@interface WXYCastViewController ()

//@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSArray * weiboContentArray;

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
    
    UIView *normalView = [[UIView alloc]init];
    [normalView setBackgroundColor:[UIColor clearColor]];
    cell.backgroundView = normalView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    id<UIScrollViewDelegate> delegate = nil;
    if ([self.parentViewController.parentViewController conformsToProtocol:@protocol(UIScrollViewDelegate)])
    {
        delegate = (id<UIScrollViewDelegate>) self.parentViewController.parentViewController;
    }
    [delegate scrollViewDidScroll:scrollView];
}

#pragma mark - calculate weiboCell Height
- (float)cellHeightForRowAtIndex:(NSInteger)row
{
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:row];
    float cellHeight = contantHeight;
    if (currentCellStatus.bmiddlePicURL != nil) {
        cellHeight += 106.0;
    }
    NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:currentCellStatus.text]
                                                                      WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                         withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                     withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                        withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                  withLabelLineSpace:contentLabelLineSpace];
    cellHeight += [UITextViewHelper HeightForAttributedString:contentString withWidth:288.0f];
    
    if (currentCellStatus.repostStatus != nil) {
        cellHeight += [CastViewCell getHeightofCastRepostViewByStatus:currentCellStatus.repostStatus] + 10.0 + 10.0;
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
    
    [self.navigationController presentViewController:comRepViewController animated:YES completion:nil];
//  [self.navigationController pushViewController:comRepViewController animated:YES];
}

- (void)clickRepostButtonByStatus:(Status *)status
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL];
    ComRepViewController * comRepViewController = [storyBoard instantiateViewControllerWithIdentifier:@"ComRepViewController"];
    comRepViewController.currentStatus = status;
    [self.navigationController pushViewController:comRepViewController animated:YES];
}

#warning castView分隔线 待完成
- (void)drawLineOnTableViewCell:(CastViewCell* )cell
                       atYpoint:(float)height
{
    UIGraphicsBeginImageContext(CGSizeMake(320.0, 1.0));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [tableViewSeprateLine CGColor]);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, 320.0, 0.0);
    CGContextStrokePath(context);
    UIImage * newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView * nnView = [[UIImageView alloc]initWithImage:newPic];
    [nnView setFrame:CGRectMake(0.0, height, 320.0, 5.0)];
    [cell addSubview:nnView];
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
@end
