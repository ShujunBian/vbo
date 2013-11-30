//
//  MHCPostViewController.h
//  vbo
//
//  Created by Pursue_finky on 13-11-12.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyButtonBgView : UIView

@property (nonatomic)BOOL needsDisplayBg;



@property (nonatomic)BOOL startToDrawCircleBg;

@property (nonatomic)BOOL needsClear;

@end



@interface MHCPostViewController : UIViewController
    
@property (strong, nonatomic) IBOutlet UITextView *postViewTextView;
@property (weak, nonatomic) IBOutlet UIView *redefinedKeyboard;


//keyboard button property.

@property (strong, nonatomic) IBOutlet UIImageView *locateBtn;
@property (strong, nonatomic) IBOutlet UIImageView *photoBtn;
@property (strong, nonatomic) IBOutlet UIImageView *atBtn;
@property (strong, nonatomic) IBOutlet UIImageView *expBtn;

@property (strong, nonatomic) IBOutlet UIImageView *unlockBtn;




//keboard button background view property .
@property (strong, nonatomic) IBOutlet KeyButtonBgView *locateBgView;
@property (strong, nonatomic) IBOutlet KeyButtonBgView *photoBgView;
@property (strong, nonatomic) IBOutlet KeyButtonBgView *expressBgView;

@property (strong, nonatomic) IBOutlet KeyButtonBgView *atBgView;


@property (strong, nonatomic) IBOutlet UIView *unlockBgView;

@end



