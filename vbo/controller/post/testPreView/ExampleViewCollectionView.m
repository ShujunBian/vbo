//
//  ExampleViewCollectionView.m
//  MHDismissModalView
//
//  Created by Mario Hahn on 04.10.13.
//  Copyright (c) 2013 Mario Hahn. All rights reserved.
//

#import "ExampleViewCollectionView.h"
//#import "ModalViewController.h"
//#import "ModalViewControllerWithoutScrollView.h"
#import "UIImage+ImageEffects.h"
//#import "UINavigationController+MHDismissModalView.h"

#import "MHCPostViewController.h"

@implementation IVCollectionViewCell

@end
@interface ExampleViewCollectionView ()

@end

@implementation ExampleViewCollectionView

-(void)viewDidLoad{
    
    if (self.navigationController.viewControllers.count ==1) {
        self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]initWithTitle:@"写微博" style:UIBarButtonItemStyleBordered target:self action:@selector(writeANewWeiboAtNewView)]];

    }
}


-(void)writeANewWeiboAtNewView{
    MHCPostViewController *testViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PostViewController"];
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:testViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}





-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{    
    NSString *cellIdentifier = nil;
    cellIdentifier = @"IVCollectionViewCell";
    IVCollectionViewCell *cell = (IVCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row %3  == 0) {
        cell.iv.image = [UIImage imageNamed:@"multitasking_screen_2x"];
    }else if(indexPath.row % 2  ==0){
        cell.iv.image = [UIImage imageNamed:@"photos_moments_screen_2x"];
    }else{
        cell.iv.image = [UIImage imageNamed:@"itunesradio_mystations_2x"];
    }
    
    return cell;
}


@end
