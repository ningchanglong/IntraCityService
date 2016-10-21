//
//  HallViewController.m
//  IntraCityService
//
//  Created by ioi on 16/10/8.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "HallViewController.h"
#import "CitySelectionViewController.h"
#import "LoginViewController.h"

@interface HallViewController ()<AMapLocationManagerDelegate>

@end

@implementation HallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"APP名称";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"登录" target:self action:@selector(rightClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"定位" target:self action:@selector(locationClick)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loaction:) name:@"Location" object:nil];
    [self createUI];
    
}

- (void)createUI
{
    CGFloat Float = (SCR_H - 64 - 49) / 2;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCR_W, SCR_H - 64 - 49)];
    [self.view addSubview:bgView];
    UIImageView *bgImage = [[UIImageView alloc] initWithFrame:bgView.bounds];
    bgImage.image = [UIImage imageNamed:@"img_bg"];
    [bgView addSubview:bgImage];
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((SCR_W - SCR_W * 0.4)/2, 25, SCR_W * 0.4, Float - 50)];
    logoImage.image = [UIImage imageNamed:@"icon_logo"];
    [bgView addSubview:logoImage];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake((SCR_W - Float)/2, SCR_H - Float - 64 - 49, Float, Float)];
    [bgView addSubview:contentView];
    UIImageView *contentImage = [[UIImageView alloc] initWithFrame:contentView.bounds];
    contentImage.image = [UIImage imageNamed:@"icon_cross_line"];
    [contentView addSubview:contentImage];
    NSArray *norArr = @[@"icon_city_power_empty",@"icon_freight_boost_empty",@"icon_city_mission_empty",@"icon_freight_task_empty"];
    NSArray *higArr = @[@"icon_city_power_full",@"icon_freight_boost_full",@"icon_city_mission_full",@"icon_freight_task_full"];
    
    CGFloat gap = 10;
    CGFloat btnWidth = (Float - 4 * gap)/2;
    CGFloat btnHeight = btnWidth;
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(gap +(gap *2 + btnWidth) * (i % 2), gap + (gap * 2 + btnHeight) * (i / 2), btnWidth, btnHeight)];
        [btn setImage:[UIImage imageNamed:norArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:higArr[i]] forState:UIControlStateHighlighted];
        [contentView addSubview:btn];
    }
    
}

- (void)loaction:(NSNotification *)noti
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:noti.object target:self action:@selector(locationClick)];
}

- (void)rightClick
{
    NSLog(@"%s",__func__);
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)locationClick
{
//    NSLog(@"%s",__func__);
    CitySelectionViewController *citySVC = [[CitySelectionViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:citySVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",[AccountTool getAccount]);
//    NSLog(@"%@",[UserModel shareUser].userId);
//    UserModel *userModel = [UserModel shareUser];
//    userModel.userId = @"45456";
    [AccountTool saveAccount:@[@"123",@"564"]];
}

@end
