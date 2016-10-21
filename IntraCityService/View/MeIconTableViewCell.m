//
//  MeIconTableViewCell.m
//  IntraCityService
//
//  Created by ioi on 16/10/9.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "MeIconTableViewCell.h"

@implementation MeIconTableViewCell

- (void)drawRect:(CGRect)rect
{
    self.iconImage.layer.masksToBounds = YES;
    self.iconImage.layer.cornerRadius = 5;
}
@end
