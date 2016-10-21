//
//  LoginTableViewCell.m
//  IntraCityService
//
//  Created by ioi on 16/10/8.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "LoginTableViewCell.h"

@implementation LoginTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 46, 40)];
        self.leftLab.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:self.leftLab];
        
        self.rightTextFd = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftLab.frame) + 5, 0, SCR_W - 15 - self.leftLab.frame.size.width, 40)];
        [self.contentView addSubview:self.rightTextFd];
        
    }
    return self;
}

@end
