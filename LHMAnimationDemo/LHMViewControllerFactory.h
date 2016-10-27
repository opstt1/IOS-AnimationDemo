//
//  LHMViewControllerFactory.h
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/24.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseViewController;

@interface LHMViewControllerFactory : NSObject

+ (BaseViewController *)caLayerViewControllerWithIdentifier:(NSString *)identifier;

+ (BaseViewController *)animationViewControllerWithIdentifier:(NSString *)identifier;
                                                               
@end
