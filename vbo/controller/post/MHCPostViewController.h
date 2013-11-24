//
//  MHCPostViewController.h
//  vbo
//
//  Created by Pursue_finky on 13-11-12.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@property (strong, nonatomic) IBOutlet UIView *atBgView;


@end
