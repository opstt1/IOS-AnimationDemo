//
//  Snake.h
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/11/10.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static CGFloat const snakeSize = 20.0f;

typedef NS_ENUM(NSInteger, SnakeDirection){
    SnakeUp,
    SnakeRight,
    SnakeDown,
    SnakeLeft,
    SnakeDefault
};

typedef NS_ENUM(NSInteger, SnakePiece){
    SnakeHead,
    SnakeBody,
    SnakeTail
};

@interface Snake : NSObject


@property (nonatomic, readwrite, assign) SnakeDirection frontDirection;
@property (nonatomic, readwrite, assign) SnakeDirection backDirection;
@property (nonatomic, readwrite, assign) SnakePiece snakePiece;

@property (nonatomic, readwrite, strong) NSString *imageStr;
@property (nonatomic, readwrite, assign) CGPoint center;
@property (nonatomic, readwrite, strong) UIImageView *snakeLayer;

+ (Snake *)snakeInView:(UIView *)view piece:(SnakePiece)piece frontDirection:(SnakeDirection)frontDirection backDirect:(SnakeDirection)backDirect center:(CGPoint)center;


- (void)setFrontDirection:(SnakeDirection)frontDirection backDirection:(SnakeDirection)backDirection snakePiece:(SnakePiece)snakePice;

- (void)frontPieceCenter:(CGPoint)center goDirection:(SnakeDirection)goDirection;

- (void)addToSuperView;

@end
