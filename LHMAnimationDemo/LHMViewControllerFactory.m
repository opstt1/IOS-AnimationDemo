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
//    if ( [identifier isEqualToString:LHMCAGradientLayerVCIdentifier] ){
//        return [storyboard instantiateViewControllerWithIdentifier:identifier];
//        LHMCAGradientLayerViewController *vc = [[LHMCAGradientLayerViewController alloc] init];
//        return vc;
//    }
//    
//    if ( [identifier isEqualToString:LHMCAReplicatiorLayerVCIdentifier] ){
//        LHMCAReplicatiorLayerViewController *vc = [[LHMCAReplicatiorLayerViewController alloc] init];
//        return vc;
//    }
//    
//    if ( [identifier isEqualToString:LHMCATransformLayerVCIdentifier] ){
//        LHMCATransformLayerViewController *vc = [[LHMCATransformLayerViewController alloc] init];
//        return vc;
//    }
//    BaseViewController *vc = [[BaseViewController alloc] init];
//    return vc;
}

@end
