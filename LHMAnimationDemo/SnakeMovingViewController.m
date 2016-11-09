//
//  SnakeMovingViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/11/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "SnakeMovingViewController.h"

@interface SnakeMovingViewController ()

@end

@implementation SnakeMovingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
   
    for ( int i = 0; i < 10; ++i) {
        CALayer *backLayer = [CALayer layer];
        backLayer.backgroundColor = [UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.4].CGColor;
        backLayer.frame = CGRectMake(100, 100+20*i, 20, 20);
        
        CALayer *layer1 = [CALayer layer];
        layer1.backgroundColor = [UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.9].CGColor;
        layer1.frame = CGRectMake(3, 0, 2, 20);
        [backLayer addSublayer:layer1];
        
        CALayer *layer2 = [CALayer layer];
        layer2.backgroundColor = [UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.9].CGColor;
        layer2.frame = CGRectMake(13, 0, 2, 20);
        [backLayer addSublayer:layer2];
        [self.view.layer addSublayer:backLayer];
    }
    
    for (int i = 0; i < 10; ++i ){
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame =  CGRectMake(150, 100+i*20, 10, 20);
        [self.view.layer addSublayer:gradientLayer];
        
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.6].CGColor,(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.9].CGColor,(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.6].CGColor,(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.3].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
        gradientLayer.locations = @[@0.0,@0.4,@0.5,@0.6,@1.0];
    }
    
    for (int i = 0; i < 10; ++i ){
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame =  CGRectMake(150+8, 100+i*20, 12, 20);
        [self.view.layer addSublayer:gradientLayer];
        
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.3].CGColor,(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.6].CGColor,(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.9].CGColor,(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.6].CGColor,(__bridge id)[UIColor colorWithRed:0.49 green:0.77 blue:0.33 alpha:0.3].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0.5);
        gradientLayer.endPoint = CGPointMake(1, 0.5);
        gradientLayer.locations = @[@0.0,@0.4,@0.5,@0.6,@1.0];
    }
}


@end
