#import "UIView+Effects.h"
#import <CoreImage/CoreImage.h>
#import "UIImage+ImageEffects.h"

@implementation UIView (Effects)

- (void)blur{

    UIImage *blurredImage = [UIImage imageNamed:@"bg.png"];
    
    blurredImage = [blurredImage applyLightEffect];
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.tag = -1;
    imageView.image = blurredImage;
    
    [self insertSubview:imageView atIndex:0];
    //[self insertSubview:overlay atIndex:1];
    
//    [imageView release];
//    [overlay release];
}

-(void)unBlur{
    [[self viewWithTag:-1] removeFromSuperview];
  
}

- (UIImage *)makeScreenShot{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
