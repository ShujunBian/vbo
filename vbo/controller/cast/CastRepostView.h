//
//  CastRepostView.h
//  vbo
//
//  Created by Emerson on 13-11-15.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Status;
@interface CastRepostView : UIView<UITextViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) Status * currentRepostStatus;

@property (nonatomic, weak) IBOutlet UIImageView * repostImageView;
@property (nonatomic, weak) IBOutlet UIView * backgroundView;
@property (nonatomic, weak) IBOutlet UILabel * repostUserNameLabel;
@property (nonatomic, weak) IBOutlet UITextView * repostContentTextView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * repostContentTextViewHeightConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * repostUserNameTopConstraint;

- (void)setCastRepostViewByStatus:(Status *)currentStatus;

+ (float)getHeightofCastRepostViewByStatus:(Status *) status;

@end
