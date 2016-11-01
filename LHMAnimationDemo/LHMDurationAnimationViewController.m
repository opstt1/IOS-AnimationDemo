//
//  LHMDurationAnimationViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/11/1.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMDurationAnimationViewController.h"

@interface LHMDurationAnimationViewController ()

@property (nonatomic, readwrite, strong) UIImageView *ballView;
@property (nonatomic, readwrite, strong) CADisplayLink *timer;
@property (nonatomic, readwrite, assign) CFTimeInterval duration;
@property (nonatomic, readwrite, assign) CFTimeInterval timeOffset;
@property (nonatomic, readwrite, assign) CFTimeInterval lastStep;
@property (nonatomic, readwrite, strong) id fromValue;
@property (nonatomic, readwrite, strong) id toValue;

@end

@implementation LHMDurationAnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self p_creatBall];
}


- (void)p_creatBall
{
    self.ballView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 132, 50, 50)];
    self.ballView.image = [UIImage imageNamed:@"easyBall"];
    [self.view addSubview:_ballView];
}


#pragma mark - action

- (IBAction)didTapCADisplayLinkAnimation:(id)sender
{
    [self p_cadisplayLinkAnimate];
}

#pragma mark - animation

- (void)p_cadisplayLinkAnimate
{
    self.ballView.center = CGPointMake(150, 132);
 
    self.duration = 1.0;
    self.timeOffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 132)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(150, 368)];

    [self.timer invalidate];
    
    self.lastStep = CACurrentMediaTime();
    self.timer = [CADisplayLink displayLinkWithTarget:self
                                             selector:@selector(step:)];
    [self.timer addToRunLoop:[NSRunLoop mainRunLoop]
                     forMode:NSDefaultRunLoopMode];
}

- (void)step:(CADisplayLink *)timer
{
    //由于我们不能够计算出一帧真实的持续时间，所以需要手动测量。我们可以在每帧开始刷新的时候用CACurrentMediaTime()记录当前时间，然后和上一帧记录的时间去比较。
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval stepDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    
    self.timeOffset = MIN(self.timeOffset + stepDuration, self.duration);

    float time = self.timeOffset / self.duration;
    
    time = bounceEaseOuta(time);
    
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue
                                        time:time];
    
    self.ballView.center = [position CGPointValue];
    
    if (self.timeOffset >= self.duration) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - c function

float interpolate(float from, float to, float time)
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        
        const char *type = [(NSValue *)fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    
    return (time < 0.5)? fromValue: toValue;
}

float bounceEaseOuta(float t)
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
