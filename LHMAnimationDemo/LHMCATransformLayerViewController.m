//
//  CATransformLayerViewController.m
//  CALayerTest
//
//  Created by LiHaomiao on 16/9/13.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//  CATransformLayer不同于普通的CALayer，因为它不能显示它自己的内容。只有当存在了一个能作用域子图层的变换它才真正存在。CATransformLayer并不平面化它的子图层，所以它能够用于构造一个层级的3D结构

#import "LHMCATransformLayerViewController.h"

@interface LHMCATransformLayerViewController ()

@property (nonatomic, strong) UIView *containerView;


@end

@implementation LHMCATransformLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(65, 100, 250,300)];
    [self.view addSubview:_containerView];
    [self addLayer];
}

- (void)addLayer
{
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = pt;
    
    CATransform3D c1t = CATransform3DIdentity;
    c1t = CATransform3DTranslate(c1t, -100, 0, 0);
    
    CALayer *cube1 = [self cubeWithTransform:c1t];
    [self.containerView.layer addSublayer:cube1];
    
    CATransform3D c2t = CATransform3DIdentity;
    c2t = CATransform3DTranslate(c2t, 100, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 1, 0, 0);
    c2t = CATransform3DRotate(c2t, -M_PI_4, 0, 1, 0);
    CALayer *cube2 = [self cubeWithTransform:c2t];
    [self.containerView.layer addSublayer:cube2];
    
}

//生成立方体
- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    CATransformLayer *cube = [CATransformLayer layer];
    
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct index:1]];
    
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct index:2]];
    
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct index:3]];
    
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct index:4]];
    
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct index:5]];
    
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct index:6]];
    
    CGSize containerSize = self.containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width/2.0, containerSize.height/2.0f);
    
    cube.transform = transform;
    
    return cube;
}

- (CALayer *)faceWithTransform:(CATransform3D)transform index:(NSInteger)index
{
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(-50, -50, 100, 100);
    
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
    
    face.transform = transform;
    
    //******  CATextLayer 添加文字
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = CGRectMake(41,35, 18, 30);
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    UIFont *font = [UIFont systemFontOfSize:30];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
    
    textLayer.string = [NSString stringWithFormat:@"%d",(int)index];
    
    [face addSublayer:textLayer];
    
    return face;
}
@end
