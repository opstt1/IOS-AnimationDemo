//
//  LHMCAEmitterLayerViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/25.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//
//  API - http://www.jianshu.com/p/2d9b64af4d66 (中文)
//
//

#import "LHMCAEmitterLayerViewController.h"

@interface LHMCAEmitterLayerViewController ()
    
@property (weak, nonatomic) IBOutlet UIView *contentView;
    
@property (nonatomic) CAEmitterLayer *emitterLayer;
    
@end

@implementation LHMCAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_createEimmterView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_emitterLayer setValue:@0 forKeyPath:@"emitterCells.emoji.birthRate"];
    });
}

- (void)p_createEimmterView
{
    _emitterLayer = [CAEmitterLayer layer];
    
    //指定发射源位置
    _emitterLayer.emitterPosition = CGPointMake(self.view.bounds.size.width/2, -10);
    //指定发射源的大小
    _emitterLayer.emitterSize = CGSizeMake(self.view.bounds.size.width, 10.0f);
    //指定发射源的形状和模式
    _emitterLayer.emitterShape = kCAEmitterLayerLine;
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    cell.name = @"emoji";
    //每秒数量
    cell.birthRate = 5.0f;
    //存活时间
    cell.lifetime = 50.0f;
    //初速度
    cell.velocity = 10;
    //初速的范围
    cell.velocityRange = 5;
    //y轴加速的
    cell.yAcceleration = 2;
    
    cell.contents = (__bridge id)[UIImage imageNamed:@"emoji_1"].CGImage;

    _emitterLayer.emitterCells = @[cell];
    
    [self.view.layer addSublayer:_emitterLayer];
    
 
}

@end
