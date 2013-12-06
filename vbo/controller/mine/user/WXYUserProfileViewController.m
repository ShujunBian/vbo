//
//  WXYUserProfileViewController.m
//  vbo
//
//  Created by wxy325 on 12/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYUserProfileViewController.h"
#import "WXYProfileTableViewDelegateObject.h"
#import "WXYNetworkEngine.h"

@interface WXYUserProfileViewController ()

@property (strong, nonatomic) WXYProfileTableViewDelegateObject* tableViewDelegateObject;
@property (strong, nonatomic) User* user;
@end

@implementation WXYUserProfileViewController

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
    self.tableViewDelegateObject = [[WXYProfileTableViewDelegateObject alloc] initWithTableView:self.tableView];
    if (self.user)
    {
        [self.tableViewDelegateObject bind:self.user];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
