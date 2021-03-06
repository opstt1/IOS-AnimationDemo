//
//  Constants.h
//  card
//
//  Created by Hale Chan on 15/4/7.
//  Copyright (c) 2015年 Papaya Mobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+random.h"

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UISCREEN_SCALE [UIScreen mainScreen].scale

#define SYSTEM_COLOR 0xFD6E37

#define IS_IPONE_5 (([UIScreen mainScreen].bounds.size.width > 320 )? NO : YES)

#define IS_IPONE_6 (([UIScreen mainScreen].bounds.size.width > 370 && [UIScreen mainScreen].bounds.size.width < 400  )? YES : NO)

#define IS_IPONE_6p (([UIScreen mainScreen].bounds.size.width > 400  )? YES : NO)


#define COLOR_BBBBBB [UIColor colorWithRGB:0xBBBBBB]
#define COLOR_666666 [UIColor colorWithRGB:0x666666]
#define COLOR_FD6E37 [UIColor colorWithRGB:0xFD6E37]
#define COLOR_FFFFFF [UIColor colorWithRGB:0xFFFFFF]
#define COLOR_333333 [UIColor colorWithRGB:0x333333]
#define COLOR_F4F4F4 [UIColor colorWithRGB:0xF4F4F4]
#define COLOR_999999 [UIColor colorWithRGB:0x999999]
#define COLOR_FD6E37 [UIColor colorWithRGB:0xFD6E37]
#define COLOR_SYSTEM [UIColor colorWithRGB:0xFD6E37]


#pragma mark - animation key

static NSString * const AnimationKeyPosition = @"position";

static const CGFloat normCellHeight = 44.0f;



