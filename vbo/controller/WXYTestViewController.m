//
//  WXYTestViewController.m
//  vbo
//
//  Created by wxy325 on 10/21/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYTestViewController.h"
#import "WeiboSDK.h"
#import "WXYNetworkEngine.h"
#import "WXYNotificationNameList.h"
#import "WXYLoginManager.h"
@interface WXYTestViewController ()

@end

@implementation WXYTestViewController

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideButtonPressed:) name:kUserLoginSucceedNotification object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)buttonPressed:(id)sender
{
    [SHARE_NW_ENGINE userLogin];
}
- (IBAction)hideButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Iden"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Iden"];
    }
    LoginUserInfo* info = SHARE_LOGIN_MANAGER.loginUserList[indexPath.row];
    cell.textLabel.text = info.userName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginUserInfo* info = SHARE_LOGIN_MANAGER.loginUserList[indexPath.row];
    [SHARE_LOGIN_MANAGER loginUser:info];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"切换成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
//    [alert show];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SHARE_LOGIN_MANAGER.loginUserList.count;
}
@end
