//
//  MHCPostViewController.m
//  vbo
//
//  Created by Pursue_finky on 13-11-12.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "PostViewController.h"
#import "UINavigationController+MHDismissModalView.h"

@interface MHCPostViewController ()

@end

@implementation MHCPostViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //change to a global function to custom settings after.
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 98, 32)];
    titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:34];
    
    titleLabel.text = @"新微博";
    
    titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    self.navigationItem.titleView = titleLabel;
    
    [self.navigationController installMHDismissModalViewWithOptions:[[MHDismissModalViewOptions alloc] initWithScrollView:nil
                                                                                                                    theme:MHModalThemeWhite]];
}



@end
