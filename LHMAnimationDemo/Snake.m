//
//  Snake.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/11/10.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "Snake.h"

@interface Snake()

@property (nonatomic, readwrite, strong) UIView *superView;

@end

@implementation Snake


+ (Snake *)snakeInView:(UIView *)view piece:(SnakePiece)piece frontDirection:(SnakeDirection)frontDirection backDirect:(SnakeDirection)backDirect center:(CGPoint)center
{
    Snake *snake = [[Snake alloc] init];
    UIImageView *snakeLayer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, snakeSize, snakeSize)];
    snakeLayer.center = center;
    snake.snakeLayer = snakeLayer;
    [view addSubview:snake.snakeLayer];
    snake.center = center;
    
    [snake setFrontDirection:frontDirection backDirection:backDirect snakePiece:piece];
    snake.superView = view;
    
    return snake;
}

- (void)setFrontDirection:(SnakeDirection)frontDirection backDirection:(SnakeDirection)backDirection snakePiece:(SnakePiece)snakePice
{
    self.backDirection = backDirection;
    self.frontDirection = frontDirection;
    self.snakePiece = snakePice;
    [self snakeHead];
    [self snakeBody];
    [self snakeTail];
}


- (void)snakeHead
{
    if ( _snakePiece != SnakeHead ){
        return;
    }
    self.imageStr = [NSString stringWithFormat:@"snake-head-%d",(int)_backDirection];
}


- (void)snakeTail
{
    if ( _snakePiece != SnakeTail ){
        return;
    }
    self.imageStr = [NSString stringWithFormat:@"snake-tail-%d",(int)_frontDirection];
}


- (void)snakeBody
{
    if ( _snakePiece != SnakeBody ){
        return;
    }
    SnakeDirection smallDirection = _frontDirection;
    SnakeDirection bigDirection = _backDirection;
    if ( smallDirection > bigDirection ){
        smallDirection = bigDirection;
        bigDirection = _frontDirection;
    }
    self.imageStr = [NSString stringWithFormat:@"snake-body-%d-%d",(int)smallDirection,(int)bigDirection];
}


- (void)setLayerContent
{
    if ( !_snakeLayer || !_imageStr ){
        return;
    }
    _snakeLayer.image = [UIImage imageNamed:_imageStr];
}

- (void)setImageStr:(NSString *)imageStr
{
    _imageStr = imageStr;
    [self setLayerContent];
}

- (void)setCenter:(CGPoint)center
{
    _center = center;
    if( !_snakeLayer ){
        return;
    }
    _snakeLayer.center = center;
}

- (void)frontPieceCenter:(CGPoint)center goDirection:(SnakeDirection)goDirection
{
    CGPoint nextCenter = [self directionInteger:goDirection];
    CGPoint nowCenter = self.center;
    
    self.center = CGPointMake(_center.x+snakeSize*nextCenter.x, _center.y+snakeSize*nextCenter.y);
    
    [self calculateWithFrontPieceCenter:center beforCenter:nowCenter nowCenter:self.center];
}

- (CGPoint)directionInteger:(SnakeDirection)direction
{
    switch (direction) {
        case SnakeUp:{
            return CGPointMake(0, -1);
        }
        case SnakeLeft:{
            return CGPointMake(-1, 0);
        }
        case SnakeDown:{
            return CGPointMake(0, 1);
        }
        case SnakeRight:{
            return CGPointMake(1, 0);
        }
        default:{
            return CGPointMake(0, 0);
        }
    }
}

- (void)calculateWithFrontPieceCenter:(CGPoint)frontCent beforCenter:(CGPoint)beforeCenter nowCenter:(CGPoint)nowCenter
{
    SnakeDirection frontDirection = [self directionWithfrontCent:frontCent backCenter:nowCenter];
    SnakeDirection backDirection = [self directionWithfrontCent:beforeCenter backCenter:nowCenter];
    [self setFrontDirection:frontDirection backDirection:backDirection snakePiece:self.snakePiece];
}

- (SnakeDirection)directionWithfrontCent:(CGPoint)frontCent backCenter:(CGPoint)backCenter
{
    if ( (int)frontCent.x == (int)backCenter.x){
        if ( frontCent.y > backCenter.y ){
            return SnakeDown;
        }else{
            return SnakeUp;
        }
    }else{
        if( frontCent.x > backCenter.x ){
            return SnakeRight;
        }else{
            return SnakeLeft;
        }
    }
}

- (void)addToSuperView
{
    [self.superView addSubview:_snakeLayer];
}

@end
