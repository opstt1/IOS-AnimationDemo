 //
//  CAGradientLayerViewController.m
//  CALayerTest
//
//  Created by LiHaomiao on 16/9/13.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMCAGradientLayerViewController.h"

@interface LHMCAGradientLayerViewController ()

@end

@implementation LHMCAGradientLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sigleGradient];
    [self multipleGradient];
}

- (void)sigleGradient
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:view];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    [view.layer addSublayer:gradientLayer];
    
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1, 1);
    
}

- (void)multipleGradient
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100+100+200, 200, 200)];
    [self.view addSubview:view];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    [view.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor orangeColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor cyanColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    gradientLayer.locations = @[@0.0,@0.17,@0.34,@0.51,@0.68,@0.85,@1.0];
}


@end
