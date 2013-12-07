//
//  TShowViewController.m
//  vbo
//
//  Created by Emerson on 13-12-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "TShowViewController.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+MKNetworkKitAdditions.h"
#import "CastViewCell.h"

#define kContantHeight 110.0
#define kContentLabelLineSpace 6.0

@interface TShowViewController ()<CastViewCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, weak) IBOutlet UILabel * label;
@property (nonatomic, strong) NSArray * currentShowArray;


@end

@implementation TShowViewController

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
    UINib *castNib = [UINib nibWithNibName:@"CastViewCell" bundle:[NSBundle bundleForClass:[CastViewCell class]]];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:castNib forCellReuseIdentifier:@"CastViewCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fetchBlock(^(NSArray* array)
    {
        self.currentShowArray = array;
        [self.tableView reloadData];
    },^(NSError* error)
    {
        
    });
}

- (void)setShowControllerByType:(ShowType)showType
                       andArray:(NSArray *)array
{
//    _currentShowArray = [[NSArray alloc]initWithArray:array];
    _currentShowType = showType;
    switch (_currentShowType) {
        case ShowUser:
            [_label setText:@"用户"];
            break;
        case ShowTalk:
            [_label setText:@"话题"];
            break;
        case ShowWeibo:
            [_label setText:@"微博"];
        default:
            break;
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentShowArray == nil) {
        return 0;
    }
    return [_currentShowArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_currentShowType) {
        case ShowUser:
            return 25.0;
        case ShowWeibo:
            return [self cellHeightForRowAtIndex:[indexPath row]];
        case ShowTalk:
            return 25.0;
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_currentShowType) {
        case ShowWeibo: {
            Status * currentCellStatus = [_currentShowArray objectAtIndex:[indexPath row]];
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
        case ShowTalk: {
            static NSString * comRepDetailCellIdentifier = @"UserCell";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:comRepDetailCellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:comRepDetailCellIdentifier];
            }
            [self.view layoutIfNeeded];
            
            return cell;
        }
        case ShowUser: {
            
            User* user = [_currentShowArray objectAtIndex:indexPath.row];
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
            
            
            return cell;
        }
        default:
            return nil;
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - calculate weiboCell Height
- (float)cellHeightForRowAtIndex:(NSInteger)row
{
    if (_currentShowType == ShowWeibo)
    {
        Status * currentCellStatus = [_currentShowArray objectAtIndex:row];
        return [self cellHeightForStatus:currentCellStatus];
    }
    else
    {
        return 44.f;
    }

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

- (void)clickCommentButtonByStatus:(Status *)status
{
    
}

- (void)clickMoreButtonByStatus:(Status *)status
{
    
}

- (void)clickRepostButtonByStatus:(Status *)status
{
    
}

- (void)presentDetailImageViewWithImageView:(UIImageView *)imageView withInitalRect:(CGRect)initalRect
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
