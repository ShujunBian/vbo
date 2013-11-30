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
    
    [self prepareTapGestureRecognizerInView:self.view];
}


#pragma mark - 初始化手势检测
- (void)prepareTapGestureRecognizerInView:(UIView *)view{
    [view setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tapGesture];
}

#pragma mark - 手势检测处理
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.delegate && [self.delegate respondsToSelector:@selector(castImageDidDismiss:)]) {
        [self.delegate castImageDidDismiss:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
