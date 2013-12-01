//
//  WXYRootTabbarViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYRootTabbarViewController.h"
#import "WXYSettingManager.h"
#import "MHCPostViewController.h"
#import "DDLogLevelGlobal.h"
#import "WXYSolidNavigationBar.h"
#import "DDLog.h"
//static int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface WXYRootTabbarViewController ()

@property (strong, nonatomic) WXYSolidTabBar* tabbar;

@property (assign, nonatomic) BOOL fScrollViewDragging;
@property (assign, nonatomic) float scrollViewPreviousOffsetY;
@property (strong, nonatomic) NSLayoutConstraint* tabBarBottomConstraint;

- (void)changeTabBarHeightBy:(float)height;
- (void)changeTabBarHeightTo:(float)height;

@property (readonly, nonatomic) float tabbarTopHeight;

@end

@implementation WXYRootTabbarViewController
@dynamic tabbarTopHeight;
#pragma mark - Getter And Setter Method
- (float)tabbarTopHeight
{
    if (self.tabBarBottomConstraint)
    {
        return self.tabBarBottomConstraint.constant + ROOT_TAB_BAR_HEIGHT;
    }
    else
    {
        return 0;
    }
}

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
    self.view.tintColor = SHARE_SETTING_MANAGER.themeColor;
	// Do any additional setup after loading the view.

//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.tabbar = [[WXYSolidTabBar alloc] init];
    self.tabbar.delegate = self;
    [self.view addSubview:self.tabbar];
    self.fScrollViewDragging = NO;

    self.tabBarBottomConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tabbar attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSArray* tabBarHoriConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tabbar]|" options:0 metrics:nil views:@{@"tabbar":self.tabbar}];
    [self.view addConstraint:self.tabBarBottomConstraint];
    [self.view addConstraints:tabBarHoriConstraints];
    
#warning 以后需改成退出时的index
    [self.tabbar weiboButtonPressed];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tabbar Hidden
- (void)changeTabBarHeightBy:(float)height
{
    float h = self.tabbarTopHeight + height;
    [self changeTabBarHeightTo:h];
}
- (void)changeTabBarHeightTo:(float)height
{

    height = height > ROOT_TAB_BAR_HEIGHT? ROOT_TAB_BAR_HEIGHT : height;
    height = height < 0 ? 0 : height;
    
    self.tabBarBottomConstraint.constant = height - ROOT_TAB_BAR_HEIGHT;
}

#pragma mark - UIScroll View Delegate
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
    
#warning 暂时先如此处理
    deltaHeight = deltaHeight / (ROOT_NAV_BAR_LONG_HEIGHT - ROOT_NAV_BAR_SHORT_HEIGHT) * ROOT_TAB_BAR_HEIGHT;
    
    //改变NavBar高度
    [self changeTabBarHeightBy:deltaHeight];
    //    self.navBar.heightConstraint.constant = - scrollView.contentOffset.y;
    
    UIEdgeInsets previousInset = scrollView.contentInset;
    if (previousInset.top != self.tabbarTopHeight)
    {
        //防止因delegate导致无限递归
        id<UIScrollViewDelegate> aDelegate = scrollView.delegate;
        scrollView.delegate = nil;
        scrollView.contentInset = UIEdgeInsetsMake(previousInset.top, previousInset.left, self.tabbarTopHeight, previousInset.right);
        scrollView.delegate = aDelegate;
    }
    self.scrollViewPreviousOffsetY = scrollView.contentOffset.y;
    
    DDLogVerbose(@"scroll view did scroll");
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
    float height = self.tabbarTopHeight < (ROOT_TAB_BAR_HEIGHT/ 2)? 0 : ROOT_TAB_BAR_HEIGHT;
    float deltaHeight = height - self.tabbarTopHeight;
    
    [UIView animateWithDuration:0.1f animations:^{
        [self changeTabBarHeightTo:height];
        [self.view layoutIfNeeded];
        UIEdgeInsets previousInset = scrollView.contentInset;
        id<UIScrollViewDelegate> aDelegate = scrollView.delegate;
        scrollView.delegate = nil;
        scrollView.contentInset = UIEdgeInsetsMake(previousInset.top, previousInset.left, self.tabbarTopHeight, previousInset.right);
        scrollView.delegate = aDelegate;
    }];
    
    id<WXYScrollHiddenDelegate> delegate = nil;
    if ([self.parentViewController conformsToProtocol:@protocol(WXYScrollHiddenDelegate)] && [self.parentViewController respondsToSelector:@selector(wxyScrollViewDidEndDecelerating:)])
    {
        delegate = (id<WXYScrollHiddenDelegate>) self.parentViewController;
        [delegate wxyScrollViewDidEndDecelerating:scrollView];
    }
}
#pragma mark - WXYSolidTabBarDelegate
- (void)tabBar:(WXYSolidTabBar*)tabBar buttonPressed:(WXYTabBarButtonType)type
{
    switch (type)
    {
        case WXYTabBarButtonTypePost:
        {
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"postViewStoryBoard" bundle:nil];
            MHCPostViewController *testViewController = [storyboard instantiateViewControllerWithIdentifier:@"PostViewController"];
            
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:testViewController];
            
            [self presentViewController:nav animated:YES completion:nil];
            break;
        }
        case WXYTabBarButtonTypeWeibo:
        case WXYTabBarButtonTypeMessage:
        case WXYTabBarButtonTypeDiscover:
        case WXYTabBarButtonTypeMine:
            self.selectedIndex = (int)type;
            break;
        
    }
}
@end
