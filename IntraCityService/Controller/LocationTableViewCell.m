//
//  LocationTableViewCell.m
//  CitySelection
//
//  Created by ioi on 16/9/20.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "LocationTableViewCell.h"

@implementation LocationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)locationClick:(UIButton *)sender {
    NSLog(@"%s",__func__);
    self.locationBlock();
}
- (IBAction)currentLocationClick:(UIButton *)sender {
    self.CurrentLocationBlock();
}

@end
