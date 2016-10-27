//
//  LHMImplicitAnimationViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/26.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMImplicitAnimationViewController.h"
#import "Constants.h"

@interface LHMImplicitAnimationViewController ()

@property (nonatomic, readwrite, strong) CALayer *caLayer;
@property (nonatomic, readwrite, strong) CALayer *transitionLayer;

@end

@implementation LHMImplicitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_addSubView];
    [self p_addTransitionView];
    
}

- (void)p_addSubView
{
    self.caLayer = [CALayer layer];
    self.caLayer.frame = CGRectMake(UISCREEN_WIDTH/2-100, UISCREEN_HEIGHT/2-100, 200, 200);
    self.caLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_caLayer];
}

- (void)p_addTransitionView
{
    self.transitionLayer = [CALayer layer];
    self.transitionLayer.frame = CGRectMake(UISCREEN_WIDTH/2, UISCREEN_HEIGHT/2+50+20+50, 100, 100);
    self.transitionLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.transitionLayer.actions = @{@"backgroundColor" : transition};
    [self.view.layer addSublayer:_transitionLayer];
}


- (UIColor *)p_randomColor
{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark - action

- (IBAction)didTapButton:(id)sender
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.caLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.caLayer.affineTransform = transform;
    }];
    
    self.caLayer.backgroundColor = [self p_randomColor].CGColor;
    
    [CATransaction commit];
}


- (IBAction)didTapTranstitionButton:(id)sender
{
    self.transitionLayer.backgroundColor = [self p_randomColor].CGColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    if ( [self.transitionLayer.presentationLayer hitTest:point] ){
        [self didTapTranstitionButton:nil];
    }else{
        [CATransaction begin];
        [CATransaction setAnimationDuration:2.0];
        self.transitionLayer.position = point;
        [CATransaction commit];
    }
}


@end
