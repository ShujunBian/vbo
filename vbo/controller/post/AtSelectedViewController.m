//
//  AtSelectedViewController.m
//  vbo
//
//  Created by Pursue_finky on 13-12-6.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "AtSelectedViewController.h"
#import "WXYNetworkEngine.h"
#import <QuartzCore/QuartzCore.h>


#define VIEW_HEIGHT 34
@interface AtSelectedViewController ()

@end

@implementation AtSelectedViewController

- (id)init
{
    self = [super initWithNibName:@"atSelectedView" bundle:nil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedViewArray = [[NSMutableArray alloc]init];
    
    self.correspondsToSelectedViewOfUserArray = [[NSMutableArray alloc]init];
    
    
}

-(void)sendSelectedUserData:(User *)user
{
    self.selectedUser = user;
    
    NSLog(@"%@",user.userID);
    
    [self createSelectedView];
    
    
}

-(void)createSelectedView
{
    UIView *atUserView = [[UIView alloc]init];
    
    UILabel *label = [[UILabel alloc]init];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica Neue-Light" size:16];
    
    label.font = font;
    
    label.tintColor = [UIColor whiteColor];
    
    label.attributedText =[[NSAttributedString alloc]initWithString:self.selectedUser.screenName] ;
    
    CGSize maxSize = CGSizeMake(90, VIEW_HEIGHT);
    CGSize requiredSize = [label sizeThatFits:maxSize];
    
    //CGSize labelSize = [label.text sizeWithAttributes:s];
    
    label.frame = CGRectMake(8, 0,requiredSize.width, 30);
    
    //label.backgroundColor = SHARE_SETTING_MANAGER.themeColor;
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    
    [cancel setImage:[UIImage imageNamed:@"cancelAtSelected"] forState:UIControlStateNormal];
    
    [cancel setContentMode: UIViewContentModeCenter];
    
    cancel.frame = CGRectMake(17+requiredSize.width, 0,34, 30);
    
    [cancel addTarget:self action:@selector(pressMeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if([self.selectedViewArray count] == 0)
    {
        atUserView.frame = CGRectMake(0, 0, requiredSize.width+48, 30);
        atUserView.backgroundColor = SHARE_SETTING_MANAGER.themeColor;
    }
    else
    {
        CGRect rect = ((UIView *)[self.selectedViewArray lastObject]).frame;
        
        rect.origin.x = rect.origin.x + rect.size.width + 5;
        
        rect.size.width = requiredSize.width + 48;
        
        atUserView.frame = rect;

        atUserView.backgroundColor = SHARE_SETTING_MANAGER.themeColor;
        
        
    }
    
    atUserView.layer.cornerRadius = 2;//设置那个圆角的有多圆

    atUserView.layer.masksToBounds = YES;
    
    [atUserView addSubview:label];
    
    [atUserView addSubview:cancel];
    
    [self.container addSubview:atUserView];
    
    [self.selectedViewArray addObject:atUserView];
    
    [self.correspondsToSelectedViewOfUserArray addObject:self.selectedUser];
    
}

-(void)sendDeSelectedUserData:(User *)user
{
    self.deSelectedUser = user;
    
    [self removeSelectedView];
}

-(void)removeSelectedView
{
    for(int i = 0 ; i < [self.correspondsToSelectedViewOfUserArray count] ; i ++)
    {
        if (self.deSelectedUser == (User *)[self.correspondsToSelectedViewOfUserArray objectAtIndex:i]) {
           
            [[self.selectedViewArray objectAtIndex:i]removeFromSuperview];
            
            CGRect record_rect;
            
        
            for(int j = i + 1 ; j < [self.selectedViewArray count] ; j ++)
            {
                
                [[self.selectedViewArray objectAtIndex:j]removeFromSuperview];
                
                CGRect post_rect;
                if(j == i + 1)
                {
                    post_rect =((UIView *)[self.selectedViewArray objectAtIndex:i]).frame;
                }
                else
                {
                    post_rect = record_rect;
                }
                CGRect cur_rect =
                ((UIView *)[self.selectedViewArray objectAtIndex:j]).frame;
                
                record_rect = cur_rect;
                
                cur_rect.origin.x -= post_rect.size.width + 5;
                
                ((UIView *)[self.selectedViewArray objectAtIndex:j]).frame = cur_rect;
                
                [self.container addSubview:[self.selectedViewArray objectAtIndex:j]];
                
            }
           
            
            [self.selectedViewArray removeObjectAtIndex:i];
            [self.correspondsToSelectedViewOfUserArray removeObjectAtIndex:i];
            break;
            
        }
    }
}

- (void)pressMeAction:(id)sender {
   
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
