//
//  TRepostViewController.m
//  vbo
//
//  Created by Emerson on 13-12-7.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "TRepostViewController.h"

@interface TRepostViewController ()

@property (nonatomic, weak) IBOutlet UILabel * label;
@property (nonatomic, weak) IBOutlet UIButton * button;
@property (nonatomic, weak) IBOutlet UITextView * textView;

@end

@implementation TRepostViewController

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
- (IBAction)clickButton:(id)sender {
}

@end
