//
//  CastImageViewController.m
//  vbo
//
//  Created by Emerson on 13-11-27.
//  Copyright (c) 2013年 BmwDev. All rights reserved.
//

#import "CastImageViewController.h"

@interface CastImageViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic) BOOL isInDismissProgress;

@end

@implementation CastImageViewController

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
    
    _weiboDetailImageView.frame = _initialRect;
    _weiboDetailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _weiboDetailImageView.clipsToBounds = YES;
    [self.view addSubview:_weiboDetailImageView];
    
    self.view.multipleTouchEnabled = YES;
    [self prepareTapGestureRecognizerInView:self.view];
    [self prepareRotateGestureRecognizerInView:self.view];
    [self preparePinchGestureRecoginizerInView:self.view];
    [self preparePanGestureRecoginizerInView:self.view];
    
    _isInDismissProgress = NO;
}


#pragma mark - 初始化手势检测
- (void)prepareTapGestureRecognizerInView:(UIView *)view {
    [view setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    [view addGestureRecognizer:tapGesture];
}

- (void)prepareRotateGestureRecognizerInView:(UIView *)view {
    [view setUserInteractionEnabled:YES];
    UIRotationGestureRecognizer * rotateGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    rotateGesture.delegate = self;
    [view addGestureRecognizer:rotateGesture];
}

- (void)preparePinchGestureRecoginizerInView:(UIView *)view {
    [view setUserInteractionEnabled:YES];
    UIPinchGestureRecognizer * pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    [view addGestureRecognizer:pinchGesture];
}

- (void)preparePanGestureRecoginizerInView:(UIView *)view {
    UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [view addGestureRecognizer:panGesture];
}

#pragma mark - 手势检测处理
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer {
    if (self.delegate && [self.delegate respondsToSelector:@selector(castImageDidDismiss:)]) {
        [self.delegate castImageDidDismiss:self];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)panGesture {
    CGPoint translation = [panGesture translationInView:self.view];
    _weiboDetailImageView.center = CGPointMake(_weiboDetailImageView.center.x + translation.x, _weiboDetailImageView.center.y + translation.y);
    [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [panGesture velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 2000;
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(_weiboDetailImageView.center.x + (velocity.x * slideFactor),
                                         _weiboDetailImageView.center.y + (velocity.y * slideFactor));
        
        
        if (_weiboDetailImageView.frame.size.width >= self.view.frame.size.width) {
            finalPoint.x = MIN(MAX(finalPoint.x, self.view.frame.size.width - _weiboDetailImageView.frame.size.width  / 2),
                               _weiboDetailImageView.frame.size.width / 2);
        }
        else {
            finalPoint.x = self.view.frame.size.width / 2;
        }
        
        if (_weiboDetailImageView.frame.size.height >= self.view.frame.size.height) {
            finalPoint.y = MIN(MAX(finalPoint.y, self.view.frame.size.height - _weiboDetailImageView.frame.size.height / 2),
                               _weiboDetailImageView.frame.size.height / 2);
        }
        else {
            finalPoint.y = self.view.frame.size.height / 2;
        }
        
        
        [UIView animateWithDuration:slideFactor * 2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _weiboDetailImageView.center = finalPoint;
        } completion:nil];
    }
    
}

- (void)handleRotate:(UIRotationGestureRecognizer*)rotateGesture {
    _weiboDetailImageView.transform = CGAffineTransformRotate(_weiboDetailImageView.transform, rotateGesture.rotation);
    rotateGesture.rotation = 0;
}

- (void)handlePinch:(UIPinchGestureRecognizer*)pinchGestureRecognizer {
    
//    CGPoint touchPoint = [pinchGestureRecognizer locationOfTouch:0 inView:self.view];
////    CGPoint touchPoint2 = [pinchGestureRecognizer locationOfTouch:1 inView:self.view];
//    NSLog(@"the point is %f %f",touchPoint.x,touchPoint.y);
////    NSLog(@"the point2 is %f %f",touchPoint2.x, touchPoint2.y);
//    [_weiboDetailImageView setCenter:CGPointMake(100,100)];
    
    _weiboDetailImageView.transform = CGAffineTransformScale(_weiboDetailImageView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1;
    
    switch (pinchGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self.transitionDelegate openDelegateInteraction];
            break;
        case UIGestureRecognizerStateChanged: {
            if ([self getPercentofPinchGesture] < 1) {
                if (!_isInDismissProgress) {
                    if (self.delegate && [self.delegate respondsToSelector:@selector(castImageDidDismiss:)]) {
                        [self.delegate castImageDidDismiss:self];
                        _isInDismissProgress = YES;
                    }
                }
                if (self.transitionDelegate && [self.transitionDelegate respondsToSelector:@selector(cvDelegateupdateInteractiveTransition:)]) {
                    float fraction = MAX(0.0, 1 - [self getPercentofPinchGesture]);
                    [self.transitionDelegate cvDelegateupdateInteractiveTransition:fraction];
//                    NSLog(@"the fraction is %f",fraction);
                }
            }
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            _isInDismissProgress = NO;
            [self.transitionDelegate closeDelegateInteraction];
            if (! ([self getPercentofPinchGesture] < 1) || pinchGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self.transitionDelegate cvDelegatecancelInteractiveTransition];
            } else {
                [self.transitionDelegate cvDelegatefinishInteractiveTransition];
                _weiboDetailImageView.hidden = YES;
            }
            break;
        }
        default:
            break;
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return  YES;
}

- (float)getPercentofPinchGesture
{
    return _weiboDetailImageView.frame.size.height / (_initialFullScreenRect.size.height );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
