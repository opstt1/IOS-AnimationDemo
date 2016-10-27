//
//  UIColor+random.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/27.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "UIColor+random.h"

@implementation UIColor(random)

+ (UIColor *)randomColor
{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}
@end
