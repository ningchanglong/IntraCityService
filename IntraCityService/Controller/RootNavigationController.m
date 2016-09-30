//
//  RootNavigationController.m
//  IntraCityService
//
//  Created by ioi on 16/9/30.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //导航栏相关设置
    self.navigationBar.barTintColor = RootNav_Color;//背景颜色
    self.navigationBar.shadowImage = [[UIImage alloc] init];//背景图片
    self.navigationBar.translucent = YES;//是否透明
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationBar.tintColor = [UIColor whiteColor];
}



@end
