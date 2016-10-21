//
//  HotCityTableViewCell.h
//  CitySelection
//
//  Created by ioi on 16/9/18.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotCityTableViewCell : UITableViewCell
@property (nonatomic,strong)NSArray *hotCityArr;
@property (nonatomic,strong)void (^checkBlock)(NSInteger index);
@end
