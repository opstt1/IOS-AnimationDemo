//
//  LHMCustomAnimationViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/11/9.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMCustomAnimationViewController.h"
#import "SnakeMovingViewController.h"
@interface LHMCustomAnimationViewController ()

@end

@implementation LHMCustomAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)didTap:(id)sender
{
    SnakeMovingViewController *vc = [[UIStoryboard storyboardWithName:@"LHMAnimation" bundle:nil] instantiateViewControllerWithIdentifier:@"SnakeMovingViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
