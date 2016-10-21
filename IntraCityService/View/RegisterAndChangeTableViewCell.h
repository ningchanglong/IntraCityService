//
//  RegisterAndChangeTableViewCell.h
//  IntraCityService
//
//  Created by ioi on 16/10/9.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterAndChangeTableViewCell : UITableViewCell
@property (nonatomic,strong)void(^codeBlock)(UIButton *);
@property (nonatomic,strong)UIImageView *leftImage;
@property (nonatomic,strong)UITextField *contentTF;
@property (nonatomic,strong)UIButton *codeBtn;
@end
