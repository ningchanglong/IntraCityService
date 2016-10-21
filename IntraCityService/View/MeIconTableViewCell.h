//
//  MeIconTableViewCell.h
//  IntraCityService
//
//  Created by ioi on 16/10/9.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeIconTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *userNameLab;
@property (strong, nonatomic) IBOutlet UILabel *accountLab;

@end
