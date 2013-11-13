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

#define contantHeight 108.0
#define weiboImageHeight 106.0
#define weiboCellBetweenHeight 10.0
#define contentLabelPadding 10.0
#define contentLabelLineSpace 6.0
#define tableViewSeprateLine [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]

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
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
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

    
//    NSLog(@"the %ld cell height of cell is %f",(long)[indexPath row],cellHeight);
    
    return [self cellHeightForRowAtIndex:[indexPath row]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"castViewCell";
    CastViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[CastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.cellBackgroundView setBackgroundColor:[WXYSettingManager shareSettingManager].castViewTableCellBackgroundColor];

    Status * currentCellStatus = [_weiboContentArray objectAtIndex:[indexPath row]];
//    [cell.weiboContentLabel setBackgroundColor:[UIColor greenColor]];
    [cell.weiboContentLabel setAttributedText:[self weiboContentLabelAttributedStringAtIndex:[indexPath row]]];
    [cell.weiboContentLabel setFont:[WXYSettingManager shareSettingManager].castViewTableCellContentLabelFont];
    cell.contentLabelHeight.constant = [self cellContentHeightForRowAtIndex:[indexPath row]];
    
    if (currentCellStatus.bmiddlePicURL != nil) {
        cell.avatorTopSpaceConstaint.constant = weiboImageHeight + weiboCellBetweenHeight;
    }
    else {
        cell.avatorTopSpaceConstaint.constant = weiboCellBetweenHeight;
    }
//    NSLog(@"the %ld cell height of constant is %f",(long)[indexPath row],cell.avatorTopSpaceConstaint.constant);
    
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
- (float)cellHeightForRowAtIndex:(NSInteger)row
{
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:row];
    float cellHeight = contantHeight;
    if (currentCellStatus.bmiddlePicURL != nil) {
        cellHeight += 106.0;
    }
    cellHeight += [self cellContentHeightForRowAtIndex:row];
    return cellHeight;
}

- (float)cellContentHeightForRowAtIndex:(NSInteger)row
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)[self weiboContentLabelAttributedStringAtIndex:row]);
    CFRange fitRange;
    CFRange textRange = CFRangeMake(0, [self weiboContentLabelAttributedStringAtIndex:row].length);
    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, textRange, NULL, CGSizeMake(288, CGFLOAT_MAX), &fitRange);
    CFRelease(framesetter);
    
    return frameSize.height + contentLabelPadding;
}

- (NSAttributedString *)weiboContentLabelAttributedStringAtIndex:(NSInteger)row
{
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:row];
    NSMutableAttributedString * contentString = [[NSMutableAttributedString alloc]initWithString:currentCellStatus.text];
    [contentString addAttribute:NSFontAttributeName
                          value:[WXYSettingManager shareSettingManager].castViewTableCellContentLabelFont
                          range:NSMakeRange(0, contentString.length)];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:contentLabelLineSpace];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    [contentString addAttribute:NSParagraphStyleAttributeName
                          value:style
                          range:NSMakeRange(0, contentString.length)];
    
    return contentString;
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
@end
