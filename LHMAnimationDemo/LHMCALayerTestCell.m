//
//  LHMCALayerTestCell.m
//  LHMAnimationDemo
//
//  Created by LiHaomiao on 2016/10/24.
//  Copyright © 2016年 Li Haomiao. All rights reserved.
//

#import "LHMCALayerTestCell.h"

@interface LHMCALayerTestCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation LHMCALayerTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
}

- (void)configWithTitle:(NSString *)title desc:(NSString *)desc
{
    self.titleLabel.text = title ? :@"";
    self.descLabel.text = desc ? :@"";
}

@end
