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
@property (nonatomic, readwrite, strong) CALayer *shipLayer;
@property (nonatomic, readwrite, strong) CAShapeLayer *shipPathLayer;
@property (nonatomic, readwrite, strong) CAKeyframeAnimation *shipAnimation;

@property (weak, nonatomic) IBOutlet UISlider *timeOffsetSlider;
@property (weak, nonatomic) IBOutlet UILabel *tiemOffsetLabel;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@end

@implementation LHMDisplayAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_creatSubCALayer];
    [self p_creatShip];
    [self updateSlider:nil];
}

- (void)p_creatSubCALayer
{
    self.calayer = [CALayer layer];
    self.calayer.frame = CGRectMake(0,40+64+15, UISCREEN_WIDTH, UISCREEN_HEIGHT-40-64-15-10-60);
    self.calayer.backgroundColor = [UIColor blueColor].CGColor;
    
    [self.view.layer addSublayer:_calayer];
}

//创建飞船和路径
- (void)p_creatShip
{
    //创建UIBezierPath曲线
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(150, 200)];
    [bezierPath addCurveToPoint:CGPointMake(150, 500) controlPoint1:CGPointMake(0, 280) controlPoint2:CGPointMake(450, 350)];
    
    //创建飞船路径
    _shipPathLayer = [CAShapeLayer layer];
    _shipPathLayer.path = bezierPath.CGPath;
    _shipPathLayer.fillColor = [UIColor clearColor].CGColor;
    _shipPathLayer.strokeColor = [UIColor redColor].CGColor;
    _shipPathLayer.lineWidth = 2.5f;
    
    //创建飞船
    _shipLayer = [CALayer layer];
    _shipLayer.contents = (__bridge id)[UIImage imageNamed:@"eveship"].CGImage;
    _shipLayer.position = CGPointMake(150, 0);
    _shipLayer.frame = CGRectMake(0, 0, 64, 32);
    
    [self.view.layer addSublayer:_shipLayer];

}
#pragma mark - 

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
    
    
    //创建飞船动画，并且使用UIBezierPath
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = _shipPathLayer.path;
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
    
    [_shipLayer addAnimation:groupAnimation forKey:nil];
    
}


#pragma mark - CAMediaTiming

- (IBAction)updateSlider:(id)sender
{
    CFTimeInterval timeOffset = self.timeOffsetSlider.value;
    self.tiemOffsetLabel.text = [NSString stringWithFormat:@"%.2f",timeOffset];
    float speed = self.speedSlider.value;
    self.speedLabel.text = [NSString stringWithFormat:@"%.2f",speed];
}

- (IBAction)didTapBeginButton:(id)sender
{
    [_shipLayer removeAnimationForKey:@"slide"];
    _shipAnimation = [CAKeyframeAnimation animation];
    _shipAnimation.keyPath = @"position";
    _shipAnimation.path = _shipPathLayer.path;
    _shipAnimation.timeOffset = _timeOffsetSlider.value;
    _shipAnimation.speed = _speedSlider.value;
    
    NSLog(@"tiimeoff %lf  speed %lf",_shipAnimation.timeOffset,_shipAnimation.speed);
    _shipAnimation.duration = 5.0f;
    _shipAnimation.rotationMode = kCAAnimationRotateAuto;
    _shipAnimation.removedOnCompletion = NO;
    [_shipLayer addAnimation:_shipAnimation forKey:@"slide"];

}


@end
