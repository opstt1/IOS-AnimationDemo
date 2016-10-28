//
//  LHMCAMediaTimingViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/28.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMCAMediaTimingViewController.h"
#import "Constants.h"


@interface LHMCAMediaTimingViewController ()

@property (nonatomic, readwrite, strong) CALayer *doorLayer;
@property (nonatomic, readwrite, strong) UIView *contentsView;
@property (nonatomic, readwrite, strong) UIImageView *imageView;

@property (nonatomic, readwrite, assign) CGFloat contentsWidth;
@property (nonatomic, readwrite, assign) CGFloat contentsHeight;
@property (nonatomic, readwrite, assign) BOOL canChangeImage;
@end


@implementation LHMCAMediaTimingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentsWidth = UISCREEN_WIDTH / 3 * 2;
    self.contentsHeight = UISCREEN_HEIGHT / 3 * 2;
    [self p_createContentsView];
    [self p_createDoorLayer];
    [self p_creatTransForm];
    [self p_creatGesture];
    [self p_creatAnimation];
}

- (void)p_createContentsView
{
    
    CALayer *wallLayer = [CALayer layer];
    wallLayer.frame = CGRectMake(0, -64, UISCREEN_WIDTH, UISCREEN_HEIGHT/2 + _contentsHeight/2);
    wallLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0.3 alpha:1].CGColor;
    [self.view.layer addSublayer:wallLayer];
    
    UIImageView *floorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT/2-64+_contentsHeight/2, UISCREEN_WIDTH, UISCREEN_HEIGHT- (UISCREEN_HEIGHT/2+_contentsHeight/2-64))];
    floorView.image = [UIImage imageNamed:@"floor"];
    [self.view addSubview:floorView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2-_contentsWidth/3, UISCREEN_HEIGHT/2-_contentsHeight/3, _contentsWidth/3*2, _contentsHeight/3*2)];
    self.imageView.image = [UIImage imageNamed:@"kunte_0"];
    [self.view addSubview:_imageView];
    
    UIImageView *doorOutView = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2-_contentsWidth/3-8, UISCREEN_HEIGHT/2-_contentsHeight/3-8, _contentsWidth/3*2+16, _contentsHeight/3*2+8)];
    doorOutView.image = [UIImage imageNamed:@"door_out"];
    [self.view addSubview:doorOutView];
    
    
    self.contentsView = [[UIView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2-_contentsWidth/2, UISCREEN_HEIGHT/2-_contentsHeight/2, _contentsWidth, _contentsHeight)];
    self.contentsView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_contentsView];
}
- (void)p_createDoorLayer
{
    self.doorLayer = [CALayer layer];
    self.doorLayer.frame = CGRectMake(0, 0, _contentsWidth/3*2, _contentsHeight/3*2);
    self.doorLayer.backgroundColor = [UIColor clearColor].CGColor;
    self.doorLayer.position = CGPointMake(_contentsWidth/2-(_contentsWidth/3),_contentsHeight/2);
    self.doorLayer.anchorPoint = CGPointMake(0, 0.5);
    self.doorLayer.contents = (__bridge id)[UIImage imageNamed:@"door_in"].CGImage;
    self.contentsView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentsView.layer addSublayer:_doorLayer];
    
    
    
}

- (void)p_creatTransForm
{
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    self.contentsView.layer.sublayerTransform = perspective;
}

- (void)p_creatGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)p_creatAnimation
{
    self.doorLayer.speed = 0.0f;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0f;
    [self.doorLayer addAnimation:animation forKey:nil];
}

#pragma mark - aciont

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGFloat x = [pan translationInView:self.view].x;
    x /= 200.0f;
    CFTimeInterval timeOffset = self.doorLayer.timeOffset;
    timeOffset = MIN(0.999, MAX(0.0, timeOffset - x));
    self.doorLayer.timeOffset = timeOffset;
    if ( timeOffset > 0.25 ){
        self.canChangeImage = YES;
    }
    if ( timeOffset < 0.01 && _canChangeImage ){
        self.canChangeImage = NO;
        [self p_changeImage];
    }
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)p_changeImage
{
    NSInteger radom = (NSInteger)arc4random() % 8;
    NSLog(@"sdfsdf  %d",radom);
    if ( radom < 0 ) radom = -radom;
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"kunte_%d",radom]];
}
@end
