//
//  WXYRootTabbarViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYRootTabbarViewController.h"
#import "WXYTabBar.h"

@interface WXYRootTabbarViewController ()

@property (strong, nonatomic) WXYTabBar* tabbar;

@end

@implementation WXYRootTabbarViewController

#pragma mark - Init Method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.tabbar = [[WXYTabBar alloc] init];
    [self.view addSubview:self.tabbar];
    
    
    NSLayoutConstraint* tabBarTopConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tabbar attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSArray* tabBarHoriConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tabbar]|" options:0 metrics:nil views:@{@"tabbar":self.tabbar}];
    [self.view addConstraint:tabBarTopConstraint];
    [self.view addConstraints:tabBarHoriConstraints];
     

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScroll View Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tabbar refresh];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
@end
