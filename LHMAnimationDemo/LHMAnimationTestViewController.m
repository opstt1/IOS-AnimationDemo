//
//  LHMAnimationTestViewController.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/26.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMAnimationTestViewController.h"
#import "LHMCALayerTestCell.h"
#import "LHMViewControllerFactory.h"

static NSString *const LHMCALayerTestCellIdentifier = @"LHMCALayerTestCell";

@interface LHMAnimationTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, readwrite, strong) NSArray *dataSource;

@end

@implementation LHMAnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initData];
    [self p_initView];
}


- (void)p_initData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"LHMAnimationTestInfo" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    self.dataSource = [data objectForKey:@"data"];
    NSLog(@"data %@",self.dataSource);
}

- (void)p_initView
{
    [self.tableView registerNib:[UINib nibWithNibName:LHMCALayerTestCellIdentifier bundle:nil] forCellReuseIdentifier:LHMCALayerTestCellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView layoutIfNeeded];
    [self.view layoutIfNeeded];
}

#pragma mark - UITableDelegate & UITableDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LHMCALayerTestCell *cell = [tableView dequeueReusableCellWithIdentifier:LHMCALayerTestCellIdentifier forIndexPath:indexPath];
    [cell configWithTitle:[_dataSource[indexPath.row] objectForKey:@"title"] desc:[_dataSource[indexPath.row] objectForKey:@"desc"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row >= _dataSource.count ){
        return;
    }
    
    BaseViewController *vc = [LHMViewControllerFactory animationViewControllerWithIdentifier:[_dataSource[indexPath.row] objectForKey:@"identifier"] ];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
