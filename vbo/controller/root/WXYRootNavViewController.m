//
//  WXYRootNavViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYRootNavViewController.h"
#import "WXYNavigationBar.h"
#import "WXYSolidNavigationBar.h"
#import "WXYLoginManager.h"
#import "DDLogLevelGlobal.h"
#import "DDLog.h"
//static int ddLogLevel = LOG_LEVEL_VERBOSE;
@interface WXYRootNavViewController ()

@property (strong, nonatomic) WXYSolidNavigationBar* navBar;

@end

@implementation WXYRootNavViewController

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

    self.navBar = [[WXYSolidNavigationBar alloc] init];
    self.navBar.title = SHARE_LOGIN_MANAGER.currentUserInfo.userName;
    [self.view addSubview:self.navBar];

//    self.navBar.snapShotView = ((UIViewController*)self.childViewControllers[0]).view;
    
    NSLayoutConstraint* navBarTopConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.navBar attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSArray* navBarHoriConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navBar]|" options:0 metrics:nil views:@{@"navBar":self.navBar}];
    [self.view addConstraint:navBarTopConstraint];
    [self.view addConstraints:navBarHoriConstraints];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    [self.navBar refresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WXYScrollHidden Delegate
- (void)wxyScrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    DDLogVerbose(@"scroll view will begin dragging");
    
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewWillBeginDragging:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewWillBeginDragging:scrollView];
    }
}
- (void)wxyScrollViewDidScroll:(UIScrollView *)scrollView
{
    
    DDLogVerbose(@"scroll view did end dragging");
    
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidScroll:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewDidScroll:scrollView];
    }
}
- (void)wxyScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    DDLogVerbose(@"scroill view did end dragging");
    
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidEndDragging:willDecelerate:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    
}
@end
