//
//  LHMDisplayAnimationViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/27.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMDisplayAnimationViewController.h"
#import "Constants.h"

@interface LHMDisplayAnimationViewController ()<CAAnimationDelegate>

@property (nonatomic, readwrite, strong) CALayer *calayer;

@end

@implementation LHMDisplayAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_creatSubCALayer];
}

- (void)p_creatSubCALayer
{
    self.calayer = [CALayer layer];
    self.calayer.frame = CGRectMake(UISCREEN_WIDTH/2-100, UISCREEN_HEIGHT/2-100, 200, 100);
    self.calayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:_calayer];
}

- (IBAction)didTapChangeColor:(id)sender
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)[UIColor randomColor].CGColor;
    animation.delegate = self;
    
    [self.calayer addAnimation:animation forKey:nil];
}
- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.calayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

#pragma mark - 关键帧动画

//变色
- (IBAction)didTapCAKeyframeAnimationButton:(id)sender
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0f;
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor yellowColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor,
                         ];
    [self.calayer addAnimation:animation forKey:nil];
}


//UIBezierPath 动画
- (IBAction)didTapBezierPathAnimation:(id)sender {
    
    //创建UIBezierPath曲线
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(150, 200)];
    [bezierPath addCurveToPoint:CGPointMake(150, 500) controlPoint1:CGPointMake(0, 280) controlPoint2:CGPointMake(450, 350)];
    
    //创建飞船路径
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 2.5f;
//    [self.view.layer addSublayer:pathLayer];
    
    //创建飞船
    CALayer *shipLayer = [CALayer layer];
    shipLayer.contents = (__bridge id)[UIImage imageNamed:@"eveship"].CGImage;
    shipLayer.position = CGPointMake(150, 0);
    shipLayer.frame = CGRectMake(0, 0, 64, 32);
    [self.view.layer addSublayer:shipLayer];
    
    //创建飞船动画，并且使用UIBezierPath
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    //自动对齐图层到曲线
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    //创建一个不断缩小的飞船
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"transform.scale";
    animation2.toValue = @0.2;
    
    //创建动画组
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1,animation2];
    groupAnimation.duration = 5.0f;
    
    [shipLayer addAnimation:groupAnimation forKey:nil];
    
    
    

}

@end
