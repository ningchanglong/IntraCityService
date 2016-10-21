//
//  MeViewController.m
//  IntraCityService
//
//  Created by ioi on 16/10/8.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "MeViewController.h"
#import "MeIconTableViewCell.h"
#import "MeOtherTableViewCell.h"
@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"APP名称";
    [self createUI];
}

- (void)createUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //如果界面主体控制器只是tableVie，可以创建继承于UITableViewController的控制器
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 49 - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#d5d5d5" alpha:1.0];
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"MeIconTableViewCell" bundle:nil] forCellReuseIdentifier:@"ICON"];
    [_tableView registerNib:[UINib nibWithNibName:@"MeOtherTableViewCell" bundle:nil] forCellReuseIdentifier:@"OTHER"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 4;
    }else if (section == 2) {
        return 3;
    }else if (section == 3) {
        return 2;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 74;
    }else {
        return 40;
    }
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }else {
        return 14;//section头部高度
    }
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view ;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MeIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ICON" forIndexPath:indexPath];
        return cell;
    }else {
        MeOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OTHER" forIndexPath:indexPath];
        if (indexPath.section == 1) {
            NSArray *imageArr = @[@"icon_my_city_power",@"icon_my_freight_help",@"icon_my_city_mission",@"icon_my_freight_mission"];
            NSArray *titleArr = @[@"我的同城助力",@"我的货运助力",@"我的同城任务",@"我的货运任务"];
            cell.leftImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
            cell.rightLab.text = titleArr[indexPath.row];
        } else if (indexPath.section == 2) {
            NSArray *imageArr = @[@"icon_wallet",@"icon_invitation",@"icon_thermodynamic_diagram"];
            NSArray *titleArr = @[@"钱包",@"邀请",@"订单热力图"];
            cell.leftImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
            cell.rightLab.text = titleArr[indexPath.row];
        }else if (indexPath.section == 3) {
            NSArray *imageArr = @[@"icon_become_a_cart_delivery_officer",@"icon_become_a_courier"];
            NSArray *titleArr = @[@"成为大车送货员",@"成为快递人"];
            cell.leftImage.image = [UIImage imageNamed:imageArr[indexPath.row]];
            cell.rightLab.text = titleArr[indexPath.row];
        }else if (indexPath.section == 4){
            cell.leftImage.image = [UIImage imageNamed:@"icon_feedback"];
            cell.rightLab.text = @"意见反馈";
        }else {
            cell.leftImage.image = [UIImage imageNamed:@"icon_set_up"];
            cell.rightLab.text = @"设置";
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@",[UserModel shareUser].userId);
}

@end
