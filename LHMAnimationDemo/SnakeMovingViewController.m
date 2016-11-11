//
//  SnakeMovingViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/11/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "SnakeMovingViewController.h"
#import "Snake.h"

@interface SnakeMovingViewController ()

@property (nonatomic, readwrite, strong) NSMutableArray *sankes;
@property (nonatomic, readwrite, strong) NSTimer *timer;
@property (nonatomic, readwrite, assign) BOOL hasGo;
@end

@implementation SnakeMovingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self beautifulSnake];
    [self snakeStartGo];
    _hasGo = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if ( _timer ){
        [_timer invalidate];
        _timer = nil;
    }
}
- (void)beautifulSnake
{
    self.sankes = [NSMutableArray array];
    
    Snake *snakeHead = [Snake snakeInView:self.view piece:SnakeHead frontDirection:SnakeDefault backDirect:SnakeDown center:CGPointMake(200, 200)];
    Snake *snakeBody = [Snake snakeInView:self.view piece:SnakeBody frontDirection:SnakeUp backDirect:SnakeDown center:CGPointMake(200, 200+snakeSize)];
    Snake *snakeTail = [Snake snakeInView:self.view piece:SnakeTail frontDirection:SnakeUp backDirect:SnakeDefault center:CGPointMake(200, 200+snakeSize*2)];
    [self.sankes addObject:snakeHead];
    [self.sankes addObject:snakeBody];
    [self.sankes addObject:snakeTail];
    
}

- (void)snakeStartGo
{
    
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(letGo:) userInfo:nil repeats:YES];
}


#pragma mark - letGo

- (void)letGo:(NSTimer *)timer
{
    if ( _hasGo ){
        return;
    }
    _hasGo = YES;
    SnakeDirection notDirection;
    
    CGPoint headCenter = ((Snake *)_sankes[0]).center;
    CGPoint bodyCenter = ((Snake *)_sankes[1]).center;
    if ( headCenter.x == bodyCenter.x){
        if ( headCenter.y > bodyCenter.y ){
            notDirection = SnakeUp;
        }else{
            notDirection = SnakeDown;
        }
    }else{
        if( headCenter.x > bodyCenter.x ){
            notDirection = SnakeLeft;
        }else{
            notDirection = SnakeRight;
        }
    }
    SnakeDirection direction = notDirection;
    while (direction == notDirection ) {
        direction = arc4random() % 4;
    }

    
    Snake *snakeHaed = _sankes[0];
    SnakeDirection backDirection = snakeHaed.backDirection;
    [snakeHaed frontPieceCenter:CGPointMake(0, 0) goDirection:direction];
    CGPoint frontCenter = snakeHaed.center;
    
    for ( int i = 1; i < _sankes.count; ++i ){
        Snake *snake = _sankes[i];
        SnakeDirection goDirection = ( backDirection + 2 ) % 4;
        backDirection = snake.backDirection;
        [snake frontPieceCenter:frontCenter goDirection:goDirection];
        frontCenter = snake.center;
    }
    _hasGo = NO;
}

@end
