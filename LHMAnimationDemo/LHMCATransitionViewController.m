//
//  LHMCATransitionViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/27.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//
//  小技巧：要确保CATransition添加到的图层在过渡动画发生时不会在树状结构中被移除，否则CATransition将会和图层一起被移除。一般来说，你只需要将动画添加到被影响图层的superlayer。
//https://zsisme.gitbooks.io/ios-/content/chapter8/transitions.html

#import "LHMCATransitionViewController.h"

@interface LHMCATransitionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, readwrite, strong) NSMutableArray *images;
@property (nonatomic, readwrite, assign) NSInteger index;

@end

@implementation LHMCATransitionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.images = [NSMutableArray array];
    _index = 0;
    for ( int i = 0; i < 8; ++i ){
        [self.images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"kunte_%d",i]]];
    }
    self.view.backgroundColor = [UIColor blackColor];
    [self.imageView layoutIfNeeded];
    
}

#pragma mark - private

- (void)p_changeImage
{
    _index = (_index + 1) % [self.images count];
    self.imageView.image = self.images[_index];
}

#pragma mark - action

- (IBAction)didTapSwitchImageButton:(id)sender
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 2.0f;
    
    [self.imageView.layer addAnimation:transition forKey:nil];
    
    [self p_changeImage];
}

- (IBAction)didTapUIViewTransitionButton:(id)sender
{
    //**！这个动画可以做翻牌动画，设置正反面
    [UIView transitionWithView:self.imageView duration:2.0f options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [self p_changeImage];
    } completion:nil];
}

//自定义动画
- (IBAction)didTapCustomAnimatinButton:(id)sender
{
    //获取当前快照
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, YES, 0.0);
    [self.imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //插入快照试图
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.imageView.frame;
    
    [self.view addSubview:coverView];
    [self p_changeImage];
    self.imageView.alpha = 0.1;
    [UIView animateWithDuration:2.0f animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0f;
        self.imageView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
        self.imageView.alpha = 1.0f;
    }];
}


@end
