//
//  CastImageViewController.m
//  vbo
//
//  Created by Emerson on 13-11-27.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CastImageViewController.h"

@interface CastImageViewController ()

@end

@implementation CastImageViewController

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
    
    _weiboDetailImageView.frame = _initialRect;
    _weiboDetailImageView.contentMode = UIViewContentModeScaleAspectFit;
    _weiboDetailImageView.clipsToBounds = YES;
    [self.view addSubview:_weiboDetailImageView];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
