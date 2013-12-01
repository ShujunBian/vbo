//
//  atViewController.m
//  vbo
//
//  Created by Pursue_finky on 13-11-27.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "atViewController.h"
#import "WXYSettingManager.h"
#import "WXYNetworkEngine.h"
#import "WatchListTableViewController.h"

@interface AtViewController ()

@end

@implementation AtViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //subView Controller init.
    self.watchListTvc = [[WatchListTableViewController alloc]init];
    
    self.view.backgroundColor = [UIColor colorWithRed:246.f/255.f green:244.f/255.f blue:240.f/255.f alpha:1.0f];
    
    
    // Navigation settings
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0,0,0,44)];
    
    title.text = @"@";
    
    title.textColor = [UIColor blackColor];
    
    title.font = [UIFont fontWithName:@"Helvetica Neue-Medium" size:17];
    
    self.navigationItem.titleView = title;
    
    //custom nav left back button
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 67, 21);
    
    [backBtn setImage:[UIImage imageNamed:@"backToPost.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    //right button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"分组" style:UIBarButtonItemStyleBordered target:self action:@selector(postWeibo)];
    
    self.navigationItem.leftBarButtonItem.tintColor = SHARE_SETTING_MANAGER.themeColor;
    self.navigationItem.rightBarButtonItem.tintColor = SHARE_SETTING_MANAGER.themeColor;
    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:248.f/255.f green:248.f/255.f  blue:248.f/255.f  alpha:1.0f];
    
    
    //cancel auto resizing
    [self.commonlyUsedCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.abcView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.hasAtCollectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    /*
     change the code later..
    */
    //if user not has the commonly-used friend.
    
    [self.commonlyUsedCollectionView removeFromSuperview];
    
    [self.abcView removeFromSuperview];
    
    [self.view addSubview:self.abcView];
    
    
    [self.view addSubview:self.watchListTvc.view];
    [self.watchListTvc.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //table view constraint.
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.watchListTvc.view
                                attribute:NSLayoutAttributeTop
      
                                  relatedBy:NSLayoutRelationEqual
      
                                     toItem:self.view
      
                                  attribute:NSLayoutAttributeTop
      
                                 multiplier:1
      
                                   constant:128]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.watchListTvc.view
                                  attribute:NSLayoutAttributeBottom
      
                                  relatedBy:NSLayoutRelationEqual
      
                                     toItem:self.view
      
                                  attribute:NSLayoutAttributeBottom
      
                                 multiplier:1
      
                                   constant:0]];
    
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.watchListTvc.view
                                  attribute:NSLayoutAttributeLeft
      
                                  relatedBy:NSLayoutRelationEqual
      
                                     toItem:self.view
      
                                  attribute:NSLayoutAttributeLeft
      
                                 multiplier:1
      
                                   constant:0]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.watchListTvc.view
                                  attribute:NSLayoutAttributeRight
      
                                  relatedBy:NSLayoutRelationEqual
      
                                     toItem:self.view
      
                                  attribute:NSLayoutAttributeRight
      
                                 multiplier:1
      
                                   constant:-16]];
   
    
    //abc view constraint
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.abcView
      
                                  attribute:NSLayoutAttributeTop
      
                                  relatedBy:NSLayoutRelationEqual
      
                                     toItem:self.view
      
                                  attribute:NSLayoutAttributeTop
      
                                 multiplier:1
      
                                   constant:128]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.abcView
      
                                  attribute:NSLayoutAttributeBottom
      
                                  relatedBy:NSLayoutRelationEqual
      
                                     toItem:self.view
      
                                  attribute:NSLayoutAttributeBottom
      
                                 multiplier:1
      
                                   constant:0]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.abcView
      
                                  attribute:NSLayoutAttributeLeft
      
                                  relatedBy:NSLayoutRelationEqual
      
                                     toItem:self.view
      
                                  attribute:NSLayoutAttributeLeft
      
                                 multiplier:1
      
                                   constant:302]];
    
}
-(void)cancel
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)postWeibo
{
}

-(void)network
{
 
}





@end
