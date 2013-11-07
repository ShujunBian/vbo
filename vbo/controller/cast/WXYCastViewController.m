//
//  WXYCastViewController.m
//  vbo
//
//  Created by wxy325 on 11/6/13.
//  Copyright (c) 2013 BmwDev. All rights reserved.
//

#import "WXYCastViewController.h"
#import "CastViewCell.h"

@interface WXYCastViewController ()

@end

@implementation WXYCastViewController

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

    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 30.0;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"castViewCell";
    CastViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[CastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}
#pragma mark - UITableView Delegate



#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    id<UIScrollViewDelegate> delegate = nil;
    if ([self.parentViewController.parentViewController conformsToProtocol:@protocol(UIScrollViewDelegate)])
    {
        delegate = (id<UIScrollViewDelegate>) self.parentViewController.parentViewController;
    }
    [delegate scrollViewDidScroll:scrollView];
}
@end
