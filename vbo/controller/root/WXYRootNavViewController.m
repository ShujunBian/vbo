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
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    

    self.navBar = [[WXYNavigationBar alloc] init];
    [self.view addSubview:self.navBar];
    
    NSLayoutConstraint* navBarTopConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.navBar attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSArray* navBarHoriConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navBar]|" options:0 metrics:nil views:@{@"navBar":self.navBar}];
    [self.view addConstraint:navBarTopConstraint];
    [self.view addConstraints:navBarHoriConstraints];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
