//
//  ComRepViewController.m
//  vbo
//
//  Created by Emerson on 13-11-19.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "ComRepViewController.h"
#import "CastViewCell.h"
#import "Status.h"
#import "WXYNetworkEngine.h"
#import "CastViewCell.h"
#import "ComRepCountCell.h"
#import "ComReqDetailCell.h"

#define contantHeight 108.0
#define contentLabelLineSpace 6.0
#define secondCommentCellHeight 25.0
#define commentDetailCellcontantHeight 29.0

@interface ComRepViewController ()

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * commentArray;

@end

@implementation ComRepViewController

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
    [self.view setTintColor:SHARE_SETTING_MANAGER.themeColor];
    
    [self.view setBackgroundColor:SHARE_SETTING_MANAGER.themeColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self fetchCommentContent];
    
    UINib *castNib = [UINib nibWithNibName:@"CastViewCell" bundle:[NSBundle bundleForClass:[CastViewCell class]]];
    [self.tableView registerNib:castNib forCellReuseIdentifier:@"CastViewCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredContentSizeChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)fetchCommentContent
{
    [SHARE_NW_ENGINE getCommentsOfWeibo:_currentStatus.statusID
                                   page:1
                                succeed:^(NSArray * resultArray){
                                    self.commentArray = [[NSMutableArray alloc]initWithArray:resultArray];
                                    [self.tableView reloadData];
                                }
                                  error:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.commentArray count] + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"the %ld cell height of cell is %f",(long)[indexPath row],cellHeight);
    if ([indexPath row] == 0) {
        return [self weiboCellHeightForRowAtIndex];
    }
    else if ([indexPath row] == 1){
        return secondCommentCellHeight;
    }
    else {
        return [self commentCellHeightForRowAtIndex:[indexPath row] - 2];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        static NSString * cellIdentifier = @"CastViewCell";
        CastViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
        {
            cell = [[CastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setCellWithWeiboStatus:_currentStatus isInCastView:NO];
        [self.view layoutIfNeeded];
        
        return cell;
    }
    else if ([indexPath row] == 1){
        static NSString * secondRowcellIdentifier = @"ComRepCountCell";
        ComRepCountCell * cell = [tableView dequeueReusableCellWithIdentifier:secondRowcellIdentifier];
        if (cell == nil)
        {
            cell = [[ComRepCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondRowcellIdentifier];
        }
        NSString * labelString = [NSString stringWithFormat:@"%d条评论",[_currentStatus.commentsCount integerValue]];
        [cell setComRepCountLabel:labelString];
        [self.view layoutIfNeeded];
        
        return cell;

    }
    else {
        static NSString * comRepDetailCellIdentifier = @"ComRepDetailCell";
        ComReqDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:comRepDetailCellIdentifier];
        if (cell == nil)
        {
            cell = [[ComReqDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:comRepDetailCellIdentifier];
        }
        [cell setCellWithWeiboComment:(Comment * )[_commentArray objectAtIndex:[indexPath row] - 2]];
        [self.view layoutIfNeeded];
        
        return cell;
    }

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


#pragma mark - calculate weiboCell Height
- (float)weiboCellHeightForRowAtIndex
{
    float cellHeight = contantHeight;
    if (_currentStatus.bmiddlePicURL != nil) {
        cellHeight += 106.0;
    }
    NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:_currentStatus.text]
                                                                      WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                         withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                     withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                        withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                  withLabelLineSpace:contentLabelLineSpace];
    cellHeight += [UITextViewHelper HeightForAttributedString:contentString withWidth:288.0f];
    
    if (_currentStatus.repostStatus != nil) {
        cellHeight += [CastViewCell getHeightofCastRepostViewByStatus:_currentStatus.repostStatus];
    }
    
    return cellHeight - 44.0;
}

- (float)commentCellHeightForRowAtIndex:(NSInteger)row
{
    float cellHeight = commentDetailCellcontantHeight;
    Comment * currentComment = (Comment*)[_commentArray objectAtIndex:row];
    NSMutableAttributedString * contentString = [UITextViewHelper setAttributeString:[[NSMutableAttributedString alloc]initWithString:currentComment.text]
                                                                      WithNormalFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                         withUrlFont:SHARE_SETTING_MANAGER.castViewTableCellContentLabelFont
                                                                     withNormalColor:SHARE_SETTING_MANAGER.castViewTableCellContentLabelTextColor
                                                                        withUrlColor:SHARE_SETTING_MANAGER.themeColor
                                                                  withLabelLineSpace:contentLabelLineSpace];
    cellHeight += [UITextViewHelper HeightForAttributedString:contentString withWidth:254.0f];
    return cellHeight;
}

- (void)preferredContentSizeChanged:(NSNotification *)notification
{
    [self.tableView reloadData];
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
