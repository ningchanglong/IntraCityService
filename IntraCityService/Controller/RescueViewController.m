//
//  RescueViewController.m
//  IntraCityService
//
//  Created by ioi on 16/10/8.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "RescueViewController.h"

@interface RescueViewController ()

@end

@implementation RescueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"紧急救援";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",[AccountTool getAccount]);
    NSLog(@"%@",[UserModel shareUser].userId);
    UserModel *userModel = [UserModel shareUser];
    userModel.userId = @"878979";
}
@end
