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
    _weiboDetailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _weiboDetailImageView.clipsToBounds = YES;
    [self.view addSubview:_weiboDetailImageView];
    
    NSLog(@"the frame is %f %f %f %f",_initialRect.origin.x,_initialRect.origin.y ,_initialRect.size.width,_initialRect.size.height);
    
//    [UIView animateWithDuration:3 animations:^{
//        _weiboDetailImageView.frame = CGRectMake(0, 0, 320, 568);
//    }];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
