//
//  MHCPostViewController.m
//  vbo
//
//  Created by Pursue_finky on 13-11-12.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "MHCPostViewController.h"


#import "UIView+Effects.h"

#import "WXYSettingManager.h"
#import "AtViewController.h"

@interface MHCPostViewController ()

@end

@implementation MHCPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor blueColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png" ]];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[self.view makeScreenShot]];
    [self.view blur];
    
    
    //navigation install.
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:248.f/255.f green:248.f/255.f  blue:248.f/255.f  alpha:1.0f];

//    
    self.navigationItem.title = @"新微博";
//    
//    [self.navigationController installMHDismissModalViewWithOptions:[[MHDismissModalViewOptions alloc] initWithScrollView:nil
//                                                                                                                    theme:MHModalThemeWhite]];

    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleBordered target:self action:@selector(postWeibo)];
    
    //set theme color
    
    self.navigationItem.leftBarButtonItem.tintColor = SHARE_SETTING_MANAGER.themeColor;
    self.navigationItem.rightBarButtonItem.tintColor = SHARE_SETTING_MANAGER.themeColor;
    
    self.postViewTextView.textColor = [UIColor blackColor];
    
    self.postViewTextView.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    
    self.postViewTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    //add redefined keyboard.
    
    [[NSBundle mainBundle]loadNibNamed:@"KeyboardView" owner:self options:nil];
    
    self.postViewTextView.inputAccessoryView = self.redefinedKeyboard;
    
    self.keyBoardMainView.backgroundColor = [UIColor colorWithRed:248.f/255.f green:248.f/255.f  blue:248.f/255.f  alpha:1.0f];
    
  
    
    
    //add Tap Gesture that make items become buttons.
    UITapGestureRecognizer *singleTapLocate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didLocatePressed)];
    
    UITapGestureRecognizer *singleTapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPhotoPressed)];
    
    UITapGestureRecognizer *singleTapAt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didAtPressed)];
    
    UITapGestureRecognizer *singleTapExpress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didExpressPressed)];
    
    [self.locateBgView addGestureRecognizer:singleTapLocate];
    
    [self.photoBgView addGestureRecognizer:singleTapPhoto];
    
    [self.atBgView addGestureRecognizer:singleTapAt];
    
    [self.expressBgView addGestureRecognizer:singleTapExpress];
    
    
    

}

-(void)viewWillAppear:(BOOL)animated
{
    
}

#pragma mark getScreenShot method
-(UIImage *)getImageWith:(UIImage *)screenShot
{
    return screenShot;
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
-(void)didLocatePressed
{
    self.locateBgView.needsDisplayBg = !self.locateBgView.needsDisplayBg;
    
    if(self.locateBgView.needsDisplayBg)
    {
        self.locateBgView.startToDrawCircleBg = YES;
        
        [self.locateBgView setNeedsDisplay];
        self.locateBtn.image = [self.locateBtn.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.locateBtn.tintColor = [UIColor whiteColor];
        
        
    }
    else
    {
        self.locateBgView.needsClear = YES;
        
        [self.locateBgView setNeedsDisplay];
        
        self.locateBtn.image = [self.locateBtn.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.locateBtn.tintColor = [UIColor colorWithRed:150.f/255.f green:150.f/255.f blue:150.f/255.f alpha:1.0f];
    }
}
-(void)didPhotoPressed
{
    self.photoBgView.needsDisplayBg = !self.photoBgView.needsDisplayBg;
    
    if(self.photoBgView.needsDisplayBg)
    {
        self.photoBgView.startToDrawCircleBg = YES;
        
        [self.photoBgView setNeedsDisplay];
        self.photoBtn.image = [self.photoBtn.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.photoBtn.tintColor = [UIColor whiteColor];
        
        
    }
    else
    {
        self.photoBgView.needsClear = YES;
        
        [self.photoBgView setNeedsDisplay];
        
        self.photoBtn.image = [self.photoBtn.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.photoBtn.tintColor = [UIColor colorWithRed:150.f/255.f green:150.f/255.f blue:150.f/255.f alpha:1.0f];
    }
}
-(void)didExpressPressed
{
    self.expressBgView.needsDisplayBg = !self.expressBgView.needsDisplayBg;
    
    if(self.expressBgView.needsDisplayBg)
    {
        self.expressBgView.startToDrawCircleBg = YES;
        
        [self.expressBgView setNeedsDisplay];
        self.expBtn.image = [self.expBtn.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.expBtn.tintColor = [UIColor whiteColor];
        
        
    }
    else
    {
        self.expressBgView.needsClear = YES;
        
        [self.expressBgView setNeedsDisplay];
        
        self.expBtn.image = [self.expBtn.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.expBtn.tintColor = [UIColor colorWithRed:150.f/255.f green:150.f/255.f blue:150.f/255.f alpha:1.0f];
    }

}
-(void)didAtPressed
{
    self.atBgView.needsDisplayBg = !self.atBgView.needsDisplayBg;
    
    if(self.atBgView.needsDisplayBg)
    {
        self.atBgView.startToDrawCircleBg = YES;
        
        [self.atBgView setNeedsDisplay];
        self.atBtn.image = [self.atBtn.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.atBtn.tintColor = [UIColor whiteColor];
        
//        AtViewController *atViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AtViewController"];
        
        [self performSegueWithIdentifier:@"atViewControllerSegue" sender:nil];
        
        
    }
    else
    {
        self.atBgView.needsClear = YES;
        
        [self.atBgView setNeedsDisplay];
        
       self.atBtn.image = [self.atBtn.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.atBtn.tintColor = [UIColor colorWithRed:150.f/255.f green:150.f/255.f blue:150.f/255.f alpha:1.0f];
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end


@implementation KeyButtonBgView

-(void)viewDidLoad
{
    //var init
    
    self.needsDisplayBg = NO;
    
    self.startToDrawCircleBg = NO;
    
    self.needsClear = NO;
    
}
-(void)viewWillAppear
{
    //var init
    
    self.needsDisplayBg = NO;
    
    self.startToDrawCircleBg = NO;
    
    self.needsClear = NO;
    
}

- (void)drawRect:(CGRect)rect
{
    
    if(self.startToDrawCircleBg)
    {
        
        CGRectMake(0, 0, 44 , 44);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, SHARE_SETTING_MANAGER.themeColor.CGColor);
        
        CGContextAddEllipseInRect(context, self.bounds);
    
        CGContextDrawPath(context, kCGPathEOFill);
        
        self.startToDrawCircleBg = NO;
    }
    if(self.needsClear)
    {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, self.bounds);
        self.needsClear = NO;
       
    }
    
}


@end
