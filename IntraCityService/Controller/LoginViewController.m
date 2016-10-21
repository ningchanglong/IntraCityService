//
//  LoginViewController.m
//  IntraCityService
//
//  Created by ioi on 16/10/8.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ChangePasswordViewController.h"
#import "LoginTableViewCell.h"
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSString *account;
@property (nonatomic,strong)NSString *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"注册" target:self action:@selector(registerClick)];
    [self createUI];
}

- (void)createUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //如果界面主体控制器只是tableVie，可以创建继承于UITableViewController的控制器
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"WorldOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"ONE"];
    [_tableView registerNib:[UINib nibWithNibName:@"WorldTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"TWO"];
    [_tableView registerClass:[LoginTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 27;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightTextFd.delegate = self;
    if (indexPath.row == 0) {
        cell.leftLab.text = @"账号";
        cell.rightTextFd.tag = 0;
    } else {
        cell.rightTextFd.secureTextEntry = YES;
        cell.rightTextFd.tag = 1;
        cell.leftLab.text = @"密码";
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
//    footerView.backgroundColor = [UIColor redColor];
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 40, SCR_W - 20, 40)];
    loginBtn.backgroundColor = [UIColor colorWithHexString:@"#1c96e2" alpha:1.0];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginBtn];
    UIButton *forgetBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_W - 10 - 70, CGRectGetMaxY(loginBtn.frame) + 5, 70, 40)];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor colorWithHexString:@"#4a4a4a" alpha:1.0] forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:forgetBtn];
    return footerView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    NSLog(@"%@--%ld",textField.text,textField.tag);
    if (textField.tag == 0) {
        self.account = textField.text;
    } else {
        self.password = textField.text;
    }
}

- (void)loginClick
{
    NSLog(@"%s",__func__);
    [self.view endEditing:YES];
    NSLog(@"%@--%@",self.account,self.password);
}

- (void)registerClick
{
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)forgetClick
{
    NSLog(@"%s",__func__);
    ChangePasswordViewController *changePwdVC = [[ChangePasswordViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:changePwdVC animated:YES];
    
}

@end
