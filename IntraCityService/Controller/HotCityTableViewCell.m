//
//  HotCityTableViewCell.m
//  CitySelection
//
//  Created by ioi on 16/9/18.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "HotCityTableViewCell.h"
#define SCR_W [UIScreen mainScreen].bounds.size.width
#define SCR_H [UIScreen mainScreen].bounds.size.height
@implementation HotCityTableViewCell

- (void)setHotCityArr:(NSArray *)hotCityArr
{
    _hotCityArr = hotCityArr;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i < self.hotCityArr.count; i ++) {
        CGFloat gap = 10;
        CGFloat W = (SCR_W - 20 - 5 * gap) / 4;
        CGFloat H = 30;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((W + gap) * (i % 4) + gap, (gap + H) * (i / 4) + gap, W, H)];
        btn.tag = i;
        //        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:self.hotCityArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.layer.masksToBounds = YES;btn.layer.borderWidth = 1;
        btn.layer.borderColor = [[UIColor blackColor] CGColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)sender
{
    NSLog(@"%ld",sender.tag);
    self.checkBlock(sender.tag);
}

@end
