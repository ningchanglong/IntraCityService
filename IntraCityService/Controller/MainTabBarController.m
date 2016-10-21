//
//  MainTabBarController.m
//  IntraCityService
//
//  Created by ioi on 16/9/30.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "MainTabBarController.h"
#import "HallViewController.h"
#import "RescueViewController.h"
#import "MeViewController.h"
#import "RootNavigationController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
    
}


//只调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    //    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    //    // 创建一个描述文本属性的字典
    //    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    //    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    //    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

- (void)createUI
{
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tabBar.tintColor = COLOR_MAIN_BAR;
    self.tabBar.translucent=NO;
    self.tabBar.opaque = YES;
//        self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"icon_bg_fillet"];
    self.tabBar.barTintColor = MainTabBar_Color;
    
    HallViewController *hallVC = [[HallViewController alloc] init];
    RootNavigationController *rootHall = [[RootNavigationController alloc] initWithRootViewController:hallVC];
    rootHall.tabBarItem.tag = 0;
    rootHall.tabBarItem.title = @"大厅";
    rootHall.tabBarItem.image = [[UIImage imageNamed:@"icon_hall"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rootHall.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_hall"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    RescueViewController *rescueVC = [[RescueViewController alloc] init];
    RootNavigationController *rootRescue = [[RootNavigationController alloc] initWithRootViewController:rescueVC];
    rootRescue.tabBarItem.tag = 1;
    rootRescue.tabBarItem.title = @"紧急救援";
    rootRescue.tabBarItem.image = [[UIImage imageNamed:@"icon_emergency_rescue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rootRescue.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_emergency_rescue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MeViewController *meVC = [[MeViewController alloc] init];
    RootNavigationController *rootMe = [[RootNavigationController alloc] initWithRootViewController:meVC];
    rootMe.tabBarItem.tag = 2;
    rootMe.tabBarItem.title = @"我";
    rootMe.tabBarItem.image = [[UIImage imageNamed:@"icon_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    rootMe.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[rootHall, rootRescue, rootMe];
    
    
}



@end
