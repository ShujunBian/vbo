//
//  TCommentViewController.m
//  vbo
//
//  Created by Emerson on 13-12-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "TCommentViewController.h"
#import "Status.h"
#import "WXYNetworkEngine.h"

@interface TCommentViewController ()

@property (nonatomic, weak) IBOutlet UILabel * label;
@property (nonatomic, weak) IBOutlet UITextView * textView;
@property (nonatomic, weak) IBOutlet UIButton * button;

@end

@implementation TCommentViewController

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
    [_label setTextColor:SHARE_SETTING_MANAGER.themeColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickButton:(id)sender
{
    [SHARE_NW_ENGINE createCommentOfWeibo:self.status.statusID content:self.textView.text commentOnOrigin:NO succeed:^(Comment *comment) {
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];
}

@end
