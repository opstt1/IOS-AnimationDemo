//
//  CAReplicatiorLayerViewController.m
//  CALayerTest
//
//  Created by LiHaomiao on 16/9/13.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMCAReplicatiorLayerViewController.h"
#import "Constants.h"

static const CGFloat Circle_Dia = 340.0f;

@interface LHMCAReplicatiorLayerViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIButton *repeatingLayerButton;
@property (weak, nonatomic) IBOutlet UIButton *reflectionButton;

@end

@implementation LHMCAReplicatiorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_drawRunPeople];
    [self p_drawFloor];
    
}

- (void)p_drawRunPeople
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake( UISCREEN_WIDTH / 2,  (UISCREEN_HEIGHT - Circle_Dia) / 2 - 30, 40, 30)];
    UIImage *image =[UIImage animatedImageNamed:@"run-people-" duration:0.55];
    [imageview setImage:image];
    [imageview startAnimating];
    [self.view addSubview:imageview];
}
//大地转动
- (void)p_drawFloor
{
    UIView *floorView = [[UIView alloc] initWithFrame:CGRectMake((UISCREEN_WIDTH - Circle_Dia) / 2, (UISCREEN_HEIGHT - Circle_Dia) / 2, Circle_Dia, Circle_Dia)];
    [floorView setBackgroundColor:[UIColor greenColor]];
    
    //绘画斑点 ************** CAReplicatorLayer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer new];
    replicatorLayer.bounds = CGRectMake(20, 20, Circle_Dia - 20 * 2, Circle_Dia - 20 * 2);
    replicatorLayer.position = CGPointMake(Circle_Dia/2, Circle_Dia/2);
    [floorView.layer addSublayer:replicatorLayer];
    
    CALayer *subLayer = [CALayer layer];
    subLayer.bounds = CGRectMake(0, 0, 3, 5);
    subLayer.position = CGPointMake(Circle_Dia/2,10+2.5);
    subLayer.backgroundColor = [UIColor greenColor].CGColor;
    [replicatorLayer addSublayer:subLayer];
    replicatorLayer.instanceCount = 90;
    CGFloat agnle = (2*M_PI)/90;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(agnle, 0, 0, 1.0);
    
    //绘画外弧圆
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(0, 0, Circle_Dia,Circle_Dia);
    circleLayer.position = CGPointMake(Circle_Dia/2, Circle_Dia/2);
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.lineWidth = 2.0f;
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    CGRect circleFrame = CGRectMake(0, 0, Circle_Dia, Circle_Dia);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:circleFrame];
    circleLayer.path = circlePath.CGPath;
    [floorView.layer addSublayer:circleLayer];
    
    //绘画内实心园
    CAShapeLayer *circleFullLayer = [CAShapeLayer layer];
    circleFullLayer.frame = CGRectMake(0, 0, Circle_Dia - 30,Circle_Dia-30);
    circleFullLayer.position = CGPointMake(Circle_Dia/2, Circle_Dia/2);
    circleFullLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.5].CGColor;
    circleFullLayer.lineWidth = 0.0f;
    circleFullLayer.strokeColor = [UIColor clearColor].CGColor;
    CGRect circleFullFrame = CGRectMake(0, 0, Circle_Dia-30,Circle_Dia-30);
    UIBezierPath *circleFullPath = [UIBezierPath bezierPathWithOvalInRect:circleFullFrame];
    circleFullLayer.path = circleFullPath.CGPath;
    
    [floorView.layer addSublayer:circleFullLayer];
    
    [floorView setBackgroundColor:[UIColor clearColor]];
    
    [UIView animateWithDuration:3.0f delay:0.0f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear  animations:^{
        floorView.transform = CGAffineTransformRotate(floorView.transform, -M_PI * 0.2 );
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view addSubview:floorView];
    
}
@end
