//
//  MHCPostViewController.m
//  vbo
//
//  Created by Pursue_finky on 13-11-12.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "MHCPostViewController.h"
#import "UINavigationController+MHDismissModalView.h"
#import "WXYSettingManager.h"

@interface MHCPostViewController ()

@end

@implementation MHCPostViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //change to a global function to custom settings after.
    
    //custom font function.
    
    //need to consider.
    
//   UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 49, 17)];
//   titleLabel.font = [UIFont fontWithName:@"Helvetica Neue-Medium" size:17];
//    
//   titleLabel.text = @"新微博";
//   
//   titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//   
//   titleLabel.textColor = [UIColor blackColor];
//    
//   
//    
//    navItem.titleView = titleLabel;
//   
//    [self.postViewNavBar pushNavigationItem:navItem animated:NO];
//    
//    [self.view addSubview:self.postViewNavBar];
    
    
    
//    self.navigationItem.titleView = titleLabel;
    
    
    //navigation install.
    self.navigationItem.title = @"新微博";

    [self.navigationController installMHDismissModalViewWithOptions:[[MHDismissModalViewOptions alloc] initWithScrollView:nil
                                                                                                                    theme:MHModalThemeWhite]];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleBordered target:self action:@selector(postWeibo)];
    
    //set theme color
    
    self.navigationItem.leftBarButtonItem.tintColor = [WXYSettingManager shareSettingManager].themeColor;
    self.navigationItem.rightBarButtonItem.tintColor = [WXYSettingManager shareSettingManager].themeColor;
    
    self.postViewTextView.textColor = [UIColor blackColor];
    
    self.postViewTextView.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    
    self.postViewTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    //add redefined keyboard.
    
    [[NSBundle mainBundle]loadNibNamed:@"KeyboardView" owner:self options:nil];
    
    self.postViewTextView.inputAccessoryView = self.redefinedKeyboard;
    
    
    //items become buttons.
    UITapGestureRecognizer *singleTapLocate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DidLocatePressed)];
    
    UITapGestureRecognizer *singleTapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DidPhotoPressed)];
    
    UITapGestureRecognizer *singleTapAt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DidAtPressed)];
    
    UITapGestureRecognizer *singleTapExpress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DidExpressPressed)];
    
    [self.locateBtn addGestureRecognizer:singleTapLocate];
    
    [self.photoBtn addGestureRecognizer:singleTapPhoto];
    
    [self.atBtn addGestureRecognizer:singleTapAt];
    
    [self.expBtn addGestureRecognizer:singleTapExpress];
    

}
#pragma mark navigationItemButton implementation

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)postWeibo
{
    //add some code after...
    
}


#pragma mark keyboard button implementation
-(void)DidLocatePressed
{
    self.locateBtn.tintColor = [UIColor grayColor];
    
    int a = 1;
    
    a++;
    
    //add some code after...
}
-(void)DidPhotoPressed
{
    //add some code after...
}
-(void)DidExpressPressed
{
    //add some code after...
}
-(void)DidAtPressed
{
    //add some code after...
}




@end
