//
//  LHMTimingFunctionViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/31.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//
//  http://www.robertpenner.com/easing

#import "LHMTimingFunctionViewController.h"
#import "Constants.h"

@interface LHMTimingFunctionViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *easyBall;

@end

@implementation LHMTimingFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_creatEasyBall];
}

- (void)p_creatEasyBall
{
    self.easyBall = [[UIImageView alloc] initWithFrame:CGRectMake(50, 132, 50, 50)];
    self.easyBall.image = [UIImage imageNamed:@"easyBall"];
    [self.view addSubview:_easyBall];
    
}

#pragma mark - action

- (IBAction)didTapEasyBallButton:(id)sender
{
    [self p_seayBallAnimation];
}

- (IBAction)didTapCustomTiming:(id)sender
{
    [self p_customAnimation];
}

#pragma mark - p animition

//简单的通过关键帧上添加缓冲，计算出时间偏移量来实现（不太好好方法）
- (void)p_seayBallAnimation
{
    self.easyBall.center = CGPointMake(50, 132);
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = AnimationKeyPosition;
    animation.duration = 1.0f;
    animation.delegate = self;
    animation.values = @[
                         [NSValue valueWithCGPoint:CGPointMake(150, 132)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 368)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 240)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 368)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 320)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 368)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 350)],
                         [NSValue valueWithCGPoint:CGPointMake(150, 368)]
                         ];
    //缓冲关键帧
    animation.timingFunctions = @[
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                   [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                   [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                   [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                                   [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
                                   [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                                  ];
    
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    self.easyBall.layer.position = CGPointMake(150, 368);
    [self.easyBall.layer addAnimation:animation forKey:nil];
}


- (id)interpolateFromValus:(id)fromVale toValue:(id)toValue time:(float)time
{
    if ( [fromVale isKindOfClass:[NSValue class]] ){
        const char *type = [fromVale objCType];
        if (strcmp(type, @encode(CGPoint)) == 0 ){
            CGPoint from = [fromVale CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interplatre(from.x, to.x, time), interplatre(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    
    return (time < 0.5 ) ? fromVale: toValue;
}

//避开CAMediaTimingFunction的限制，创建完全自定义的缓冲函数。 分割多个关键帧。仅仅交换缓冲函数，现在就可以选择任意的缓冲类型创建动画了
- (void)p_customAnimation
{
    self.easyBall.center = CGPointMake(150, 132);
    
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 132)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(150, 368)];
    
    NSTimeInterval duration = 1.0f;
    
    NSInteger numFrames = duration * 60;
    
    NSMutableArray *frames = [NSMutableArray array];
    
    for ( int i = 0; i < numFrames; ++i ){
        float time = 1 / (float)numFrames * i;
        //只需要在这里定义缓存，罗伯特·彭纳有一个网页关于缓冲函数（http://www.robertpenner.com/easing）
        time = bounceEaseOut(time);
        [frames addObject:[self interpolateFromValus:fromValue toValue:toValue time:time]];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = AnimationKeyPosition;
    animation.duration = 1.0f;
    animation.delegate = self;
    animation.values = frames;
    self.easyBall.layer.position = CGPointMake(150, 368);
    [self.easyBall.layer addAnimation:animation forKey:nil];
}

#pragma mark - C function

float interplatre(float from, float to, float time){
    return (to - from ) * time + from;
}

//缓冲进入动画
float bounceEaseOut(float t)
{
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

@end
