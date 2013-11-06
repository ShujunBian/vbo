//
//  WXYRootNavViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYRootNavViewController.h"
#import "WXYNavigationBar.h"


@interface WXYRootNavViewController ()

@property (strong, nonatomic) WXYNavigationBar* navBar;

@end

@implementation WXYRootNavViewController

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
//    self.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
//    self.navigationBar.frame = CGRectMake(0, 0, 480, 50);
    self.navBar = [[WXYNavigationBar alloc] init];
    [self.view addSubview:self.navBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
