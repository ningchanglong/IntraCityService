//
//  LocationTableViewCell.h
//  CitySelection
//
//  Created by ioi on 16/9/20.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *locationLab;
@property (nonatomic,strong)void(^locationBlock)();
@property (strong, nonatomic) IBOutlet UIButton *LocationBtn;
@property (nonatomic,strong)void(^CurrentLocationBlock)();
@end
