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

@property (assign, nonatomic) float scrollViewPreviousOffsetY;
@property (assign, nonatomic) BOOL fScrollViewDragging;
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
    
    self.scrollViewPreviousOffsetY = 0.f;
    self.fScrollViewDragging = NO;
    
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
    self.fScrollViewDragging = YES;
    
    self.scrollViewPreviousOffsetY = scrollView.contentOffset.y;
    
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewWillBeginDragging:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewWillBeginDragging:scrollView];
    }
}
- (void)wxyScrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.fScrollViewDragging)
    {
        return;
    }
    float deltaHeight = self.scrollViewPreviousOffsetY - scrollView.contentOffset.y;

    //改变NavBar高度
    [self.navBar changeNavBarHeightBy:deltaHeight];
//    self.navBar.heightConstraint.constant = - scrollView.contentOffset.y;

    UIEdgeInsets previousInset = scrollView.contentInset;
    if (previousInset.top != self.navBar.navBarHeight)
    {
        //防止因delegate导致无限递归
        id<UIScrollViewDelegate> aDelegate = scrollView.delegate;
        scrollView.delegate = nil;
        scrollView.contentInset = UIEdgeInsetsMake(self.navBar.navBarHeight, previousInset.left, previousInset.bottom, previousInset.right);
        scrollView.delegate = aDelegate;
    }
    self.scrollViewPreviousOffsetY = scrollView.contentOffset.y;
    
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

    self.fScrollViewDragging = NO;
    
    
    
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidEndDragging:willDecelerate:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
    
    if (!decelerate)
    {
        [self wxyScrollViewDidEndDecelerating:scrollView];
    }
    
}

- (void)wxyScrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float height = self.navBar.navBarHeight < ((ROOT_NAV_BAR_LONG_HEIGHT + ROOT_NAV_BAR_SHORT_HEIGHT) / 2)? ROOT_NAV_BAR_SHORT_HEIGHT : ROOT_NAV_BAR_LONG_HEIGHT;
    float deltaHeight = height - self.navBar.navBarHeight;
    
    [UIView animateWithDuration:0.1f animations:^{
        [self.navBar changeNavBarHeightTo:height];
        [self.navBar layoutIfNeeded];
        UIEdgeInsets previousInset = scrollView.contentInset;
        id<UIScrollViewDelegate> aDelegate = scrollView.delegate;
        scrollView.delegate = nil;
        scrollView.contentInset = UIEdgeInsetsMake(self.navBar.navBarHeight, previousInset.left, previousInset.bottom, previousInset.right);
        CGPoint previousOffset = scrollView.contentOffset;
        scrollView.contentOffset = CGPointMake(previousOffset.x, previousOffset.y - deltaHeight);
        scrollView.delegate = aDelegate;
    }];
    
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidEndDecelerating:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewDidEndDecelerating:scrollView];
    }
    
}
@end
