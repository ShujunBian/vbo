//
//  WXYTabBar.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYSolidTabBar.h"
#import "WXYTabBarPostButton.h"
#import "WXYSettingManager.h"
#import "GraphicName.h"

@interface WXYSolidTabBar ()

@property (strong, nonatomic) NSLayoutConstraint* tabBarHeightConstraint;

@property (strong, nonatomic) WXYTabBarSolidButton* weiboButton;
@property (strong, nonatomic) WXYTabBarSolidButton* discoverButton;
@property (strong, nonatomic) WXYTabBarSolidButton* messageButton;
@property (strong, nonatomic) WXYTabBarSolidButton* mineButton;
@property (strong, nonatomic) WXYTabBarPostButton* postButton;

- (void)deselectAllButton;



@end

@implementation WXYSolidTabBar
#pragma mark - Getter And Setter Method
- (WXYTabBarSolidButton*)weiboButton
{
    if (!_weiboButton)
    {
        _weiboButton = [[WXYTabBarSolidButton alloc] initWithImageName:GRAPHIC_TAB_BAR_WEIBO_BUTTON highlightImageName:GRAHPIC_TAB_BAR_WEIBO_BUTTON_HIGHLIGHT title:@"微博"];
        [_weiboButton addTarget:self selector:@selector(weiboButtonPressed)];
    }
    return _weiboButton;
}
- (WXYTabBarSolidButton*)discoverButton
{
    if (!_discoverButton)
    {
        _discoverButton = [[WXYTabBarSolidButton alloc] initWithImageName:GRAPHIC_TAB_BAR_DISCOVER_BUTTON highlightImageName:GRAPHIC_TAB_BAR_DISCOVER_BUTTON_HIGHLIGHT title:@"发现"];
        [_discoverButton addTarget:self selector:@selector(discoverButtonPressed)];
    }
    return _discoverButton;
}
- (WXYTabBarSolidButton*)messageButton
{
    if (!_messageButton)
    {
        _messageButton = [[WXYTabBarSolidButton alloc] initWithImageName:GRAPHIC_TAB_BAR_MESSAGE_BUTTON highlightImageName:GRAPHIC_TAB_BAR_MESSAGE_BUTTON_HIGHLIGHT title:@"消息"];
        [_messageButton addTarget:self selector:@selector(messageButtonPressed)];
    }
    return _messageButton;
}

- (WXYTabBarSolidButton*)mineButton
{
    if (!_mineButton)
    {
        _mineButton = [[WXYTabBarSolidButton alloc] initWithImageName:GRAPHIC_TAB_BAR_MINE_BUTTON highlightImageName:GRAPHIC_TAB_BAR_MINE_BUTTON_HIGHLIGHT title:@"我"];
        [_mineButton addTarget:self selector:@selector(mineButtonPressed)];
    }
    return _mineButton;
}
- (WXYTabBarPostButton*)postButton
{
    if (!_postButton)
    {
        _postButton = [[WXYTabBarPostButton alloc] init];
        [_postButton addTarget:self selector:@selector(postButtonPressed)];
    }
    return _postButton;
}

#pragma mark - Init Method
- (id)init
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor colorWithRed:35.f/255.f green:35.f/255.f blue:35.f/255.f alpha:1.f];
        
        self.tabBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:ROOT_TAB_BAR_HEIGHT];
        [self addConstraint:self.tabBarHeightConstraint];
        
        [self addSubview:self.weiboButton];
        [self addSubview:self.discoverButton];
        [self addSubview:self.messageButton];
        [self addSubview:self.mineButton];
        [self addSubview:self.postButton];
        
        NSArray* hContrains = [NSLayoutConstraint constraintsWithVisualFormat:@"|[weibo][discover(weibo)][message(weibo)][mine(weibo)][post(weibo)]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"weibo":self.weiboButton,@"discover":self.discoverButton,@"message":self.messageButton,@"mine":self.mineButton,@"post":self.postButton}];
        [self addConstraints:hContrains];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)postButtonPressed
{
    if ([self.delegate conformsToProtocol:@protocol(WXYSolidTabBarDelegate)] && [self.delegate respondsToSelector:@selector(tabBar:buttonPressed:)])
    {
        [self.delegate tabBar:self buttonPressed:WXYTabBarButtonTypePost];
    }
}

- (void)deselectAllButton
{
    self.weiboButton.highlight = NO;
    self.discoverButton.highlight = NO;
    self.messageButton.highlight = NO;
    self.mineButton.highlight = NO;
}
- (void)weiboButtonPressed
{
    [self deselectAllButton];
    self.weiboButton.highlight = YES;
    
    if ([self.delegate conformsToProtocol:@protocol(WXYSolidTabBarDelegate)] && [self.delegate respondsToSelector:@selector(tabBar:buttonPressed:)])
    {
        [self.delegate tabBar:self buttonPressed:WXYTabBarButtonTypeWeibo];
    }
}
- (void)discoverButtonPressed
{
    [self deselectAllButton];
    self.discoverButton.highlight = YES;
    if ([self.delegate conformsToProtocol:@protocol(WXYSolidTabBarDelegate)] && [self.delegate respondsToSelector:@selector(tabBar:buttonPressed:)])
    {
        [self.delegate tabBar:self buttonPressed:WXYTabBarButtonTypeDiscover];
    }
}
- (void)mineButtonPressed
{
    [self deselectAllButton];
    self.mineButton.highlight = YES;
    if ([self.delegate conformsToProtocol:@protocol(WXYSolidTabBarDelegate)] && [self.delegate respondsToSelector:@selector(tabBar:buttonPressed:)])
    {
        [self.delegate tabBar:self buttonPressed:WXYTabBarButtonTypeMine];
    }
}
- (void)messageButtonPressed
{
    [self deselectAllButton];
    self.messageButton.highlight = YES;
    if ([self.delegate conformsToProtocol:@protocol(WXYSolidTabBarDelegate)] && [self.delegate respondsToSelector:@selector(tabBar:buttonPressed:)])
    {
        [self.delegate tabBar:self buttonPressed:WXYTabBarButtonTypeMessage];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
