//
//  WXYTabBar.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYTabBar.h"
#import "WXYSettingManager.h"
#import "GraphicName.h"

@interface WXYTabBar ()

@property (strong, nonatomic) NSLayoutConstraint* tabBarHeightConstraint;

@property (strong, nonatomic) WXYTabBarButton* weiboButton;
@property (strong, nonatomic) WXYTabBarButton* discoverButton;
@property (strong, nonatomic) WXYTabBarButton* messageButton;
@property (strong, nonatomic) WXYTabBarButton* mineButton;

@end

@implementation WXYTabBar
#pragma mark - Getter And Setter Method
- (WXYTabBarButton*)weiboButton
{
    if (!_weiboButton)
    {
        _weiboButton = [[WXYTabBarButton alloc] initWithImageName:GRAPHIC_TAB_BAR_WEIBO_BUTTON title:@"微博"];
    }
    return _weiboButton;
}
- (WXYTabBarButton*)discoverButton
{
    if (!_discoverButton)
    {
        _discoverButton = [[WXYTabBarButton alloc] initWithImageName:GRAPHIC_TAB_BAR_DISCOVER_BUTTON title:@"发现"];
    }
    return _discoverButton;
}
- (WXYTabBarButton*)messageButton
{
    if (!_messageButton)
    {
        _messageButton = [[WXYTabBarButton alloc] initWithImageName:GRAPHIC_TAB_BAR_MESSAGE_BUTTON title:@"消息"];
    }
    return _messageButton;
}

- (WXYTabBarButton*)mineButton
{
    if (!_mineButton)
    {
        _mineButton = [[WXYTabBarButton alloc] initWithImageName:GRAPHIC_TAB_BAR_MESSAGE_BUTTON title:@"我"];
    }
    return _mineButton;
}

#pragma mark - Init Method
- (id)init
{
    self = [super init];
    if (self)
    {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.blurTintColor = SHARE_SETTING_MANAGER.rootBarTintColor;
        
        self.tabBarHeightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:ROOT_TAB_BAR_HEIGHT];
        [self addConstraint:self.tabBarHeightConstraint];
        
        [self addSubview:self.weiboButton];
        [self addSubview:self.discoverButton];
        [self addSubview:self.messageButton];
        [self addSubview:self.mineButton];
        
        NSArray* hContrains = [NSLayoutConstraint constraintsWithVisualFormat:@"|[weibo][discover][message][mine]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:@{@"weibo":self.weiboButton,@"discover":self.discoverButton,@"message":self.messageButton,@"mine":self.mineButton}];
        [self addConstraints:hContrains];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}


#pragma mark - Refresh Blur
- (void)refresh
{

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
