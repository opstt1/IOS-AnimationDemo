//
//  LHMViewControllerFactory.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/24.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMViewControllerFactory.h"
#import "LHMCAGradientLayerViewController.h"
#import "LHMCATransformLayerViewController.h"
#import "LHMCAReplicatiorLayerViewController.h"

static NSString *const LHMCAGradientLayerVCIdentifier = @"LHMCAGradientLayerViewController";
static NSString *const LHMCATransformLayerVCIdentifier = @"LHMCATransformLayerViewController";
static NSString *const LHMCAReplicatiorLayerVCIdentifier = @"LHMCAReplicatiorLayerViewController";

@implementation LHMViewControllerFactory

+ (BaseViewController *)caLayerViewControllerWithIdentifier:(NSString *)identifier
{
    identifier = identifier ?:@"";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LHMCALayerTest" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}


+ (BaseViewController *)animationViewControllerWithIdentifier:(NSString *)identifier
{
    identifier = identifier ?:@"";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LHMAnimationTest" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
