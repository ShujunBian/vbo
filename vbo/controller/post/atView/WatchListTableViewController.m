//
//  WatchListTableViewController.m
//  vbo
//
//  Created by Pursue_finky on 13-12-1.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "WatchListTableViewController.h"
#import "WatchListTableViewCell.h"
#import "WXYSettingManager.h"
#import "WXYNetworkEngine.h"
#import "UIImageView+MKNetworkKitAdditions.h"

@interface WatchListTableViewController ()

@end

@implementation WatchListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WatchListTableViewCell" bundle:nil] forCellReuseIdentifier:@"WatchListTableCell"];
    [SHARE_NW_ENGINE getAllFriendOfCurrentUserSucceed:^(NSArray *resultArray) {
        NSLog(@"%d",resultArray.count);
        self.atUserArray = [[NSMutableArray alloc]initWithArray:resultArray];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.view)
        return 24;
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WatchListTableCell";
    WatchListTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[WatchListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WatchListTableCell"];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.0f];
    User* user = [self.atUserArray objectAtIndex:indexPath.row];
    
    cell.userName.text = user.screenName;
    
    [cell.userHeadPhoto setImageFromURL:[NSURL URLWithString:user.avatarLargeUrl]];
    
    [cell.checkView removeFromSuperview];
    
    // Configure the cell..
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WatchListTableViewCell *cell = (WatchListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    cell.selectedView.backgroundColor = SHARE_SETTING_MANAGER.themeColor;
    
    [cell addSubview:cell.checkView];
    
   
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WatchListTableViewCell *cell = (WatchListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.checkView removeFromSuperview];
}


@end
