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
#import "UIImageView+MKNetworkKitAdditions.h"
#import "TTTAttributedLabel.h"
#import "WXYSettingManager.h"

#define contantHeight 120.0
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
    [self fetchWeiboContent];
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)fetchWeiboContent
{
    self.engine = SHARE_NW_ENGINE;
    [self.engine getHomeTimelineOfCurrentUserSucceed:^(NSArray * resultArray){
        self.weiboContentArray = resultArray;
        [self.tableView reloadData];
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
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Status * currentCellStatus = [_weiboContentArray objectAtIndex:[indexPath row]];
    float cellHeight = contantHeight;
    if (currentCellStatus.originalPicURL != nil) {
        cellHeight += 106.0;
    }
    cellHeight += 150.0;
    
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
    NSLog(@"url is %@",currentCellStatus.thumbnailPicURL);
    if (currentCellStatus.thumbnailPicURL != nil) {
        cell.avatorTopSpaceConstaint.constant = weiboImageHeight + weiboCellBetweenHeight;
    }
    else {
        cell.avatorTopSpaceConstaint.constant = weiboImageHeight;
    }
    
    NSURL *anImageURL = [NSURL URLWithString:currentCellStatus.thumbnailPicURL];
    [cell.weiboImage setImageFromURL:anImageURL placeHolderImage:nil animation:YES];

    return cell;
}
#pragma mark - UITableView Delegate


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
    
    return frameSize.height;
}
@end
