//
//  WXYCastViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYCastViewController.h"
#import "CastViewCell.h"
#import "WXYNetworkEngine.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+MKNetworkKitAdditions.h"
#import "NSNotificationCenter+Addition.h"
#import "TTTAttributedLabel.h"
#import "WXYSettingManager.h"

#define contantHeight 132.0
#define weiboImageHeight 106.0
#define weiboCellBetweenHeight 10.0

@interface WXYCastViewController ()

@property (strong, nonatomic) WXYNetworkEngine* engine;
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
    [bgview setBackgroundColor:[WXYSettingManager shareSettingManager].castViewTableViewBackgroundColor];
    [self.tableView setBackgroundView:bgview];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self fetchWeiboContent];

}

- (void)fetchWeiboContent
{
    self.engine = SHARE_NW_ENGINE;
    [self.engine getHomeTimelineOfCurrentUserSucceed:^(NSArray * resultArray){
        self.weiboContentArray = resultArray;
        [self.tableView reloadData];
        [NSNotificationCenter postDidFetchCurrentUserNameNotification];
    }error:nil];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.backgroundColor = [UIColor blackColor];
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
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:[indexPath row]];
    float cellHeight = contantHeight;
    if (currentCellStatus.bmiddlePicURL != nil) {
        cellHeight += 106.0;
    }
    cellHeight += [self cellContentHeightForRowAtIndex:[indexPath row]];
    
    NSLog(@"the %ld cell height of cell is %f",(long)[indexPath row],cellHeight);
    
    return cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"castViewCell";
    CastViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[CastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:[indexPath row]];
    [cell.weiboContentLabel setText:currentCellStatus.text];
    [cell.weiboContentLabel setBackgroundColor:[UIColor greenColor]];
    if (currentCellStatus.bmiddlePicURL != nil) {
        cell.avatorTopSpaceConstaint.constant = weiboImageHeight + weiboCellBetweenHeight;
    }
    else {
        cell.avatorTopSpaceConstaint.constant = weiboCellBetweenHeight;
    }
    NSLog(@"the %ld cell height of constant is %f",(long)[indexPath row],cell.avatorTopSpaceConstaint.constant);
    
    [cell.cellBackgroundView setBackgroundColor:[WXYSettingManager shareSettingManager].castViewTableCellBackgroundColor];
    
    [cell.weiboImage setImage:nil];
    NSURL *anImageURL = [NSURL URLWithString:currentCellStatus.bmiddlePicURL];
    [cell.weiboImage setImageFromURL:anImageURL placeHolderImage:nil animation:YES completion:nil];
    cell.weiboImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.weiboImage.clipsToBounds = YES;
    
    [cell.userAvator setImageFromURLString:currentCellStatus.author.profileImageUrl
                          placeHolderImage:nil animation:YES completion:nil];
    cell.userAvator.layer.cornerRadius = 16.0;
    cell.userAvator.layer.masksToBounds = YES;
    
    [cell.userNickname setText:currentCellStatus.author.screenName];
    [self.view layoutIfNeeded];
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
- (float)cellContentHeightForRowAtIndex:(NSInteger)row
{
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:row];
    NSMutableAttributedString * contentString = [[NSMutableAttributedString alloc]initWithString:currentCellStatus.text];
    [contentString addAttribute:NSFontAttributeName
                          value:[WXYSettingManager shareSettingManager].castViewTableCellContentLabelFont
                          range:NSMakeRange(0, contentString.length)];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)contentString);
    CFRange fitRange;
    CFRange textRange = CFRangeMake(0, contentString.length);
    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, textRange, NULL, CGSizeMake(288, CGFLOAT_MAX), &fitRange);
    CFRelease(framesetter);
    
//    NSLog(@"The %@ Label height is %f",contentString,frameSize.height);
    return frameSize.height + 10.0;
//    return 0.0;
}
@end
