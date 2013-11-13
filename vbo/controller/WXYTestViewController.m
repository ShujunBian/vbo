//
//  WXYTestViewController.m
//  vbo
//
//  Created by wxy325 on 10/21/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYTestViewController.h"
#import "WeiboSDK.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WEIBO_REDIRECT_URI;
    request.scope = @"all";
//    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
//                         @"Other_Info_1": [NSNumber numberWithInt:123],
//                         @"Other_Info_2": @[@"obj1", @"obj2"],
//                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}
- (IBAction)hideButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
