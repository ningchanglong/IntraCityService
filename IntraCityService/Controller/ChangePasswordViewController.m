//
//  ChangePasswordViewController.m
//  IntraCityService
//
//  Created by ioi on 16/10/9.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "RegisterAndChangeTableViewCell.h"
@interface ChangePasswordViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改密码";
    [self createUI];
}

- (void)createUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //如果界面主体控制器只是tableVie，可以创建继承于UITableViewController的控制器
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"#d5d5d5" alpha:1.0];
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"WorldOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"ONE"];
    [_tableView registerNib:[UINib nibWithNibName:@"WorldTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"TWO"];
    [_tableView registerClass:[RegisterAndChangeTableViewCell class] forCellReuseIdentifier:@"CELL"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegisterAndChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.contentTF.delegate = self;
    if (indexPath.row == 0) {
        cell.leftImage.image = [UIImage imageNamed:@"icon_telephone_number"];
        cell.codeBtn.hidden = NO;
        [cell.codeBtn addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.contentTF.frame = CGRectMake(CGRectGetMaxX(cell.leftImage.frame) + 15, 0, SCR_W - 15 - 100 - CGRectGetWidth(cell.leftImage.frame), 40);
        cell.contentTF.placeholder = @"输入手机号";
        cell.contentTF.tag = indexPath.row;
    }else if (indexPath.row == 1) {
        cell.leftImage.image = [UIImage imageNamed:@"icon_verification_code"];
        cell.contentTF.placeholder = @"输入手机验证码";
        cell.contentTF.tag = indexPath.row;
    }else if (indexPath.row == 2) {
        cell.leftImage.image = [UIImage imageNamed:@"icon_password"];
        cell.contentTF.placeholder = @"输入密码";
        cell.contentTF.tag = indexPath.row;
    }else {
        cell.leftImage.image = [UIImage imageNamed:@"icon_confirm_password"];
        cell.contentTF.placeholder = @"确认密码";
        cell.contentTF.tag = indexPath.row;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 24, SCR_W - 20, 40)];
    commitBtn.backgroundColor = [UIColor colorWithHexString:@"#1c96e2" alpha:1.0];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.cornerRadius = 5;
    [commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:commitBtn];
    return footerView;
}

- (void)commitClick
{
    
}

- (void)codeClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    __block int timeout= 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<= 1){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sender setTitle:[NSString stringWithFormat:@"重新获取(%zds)",timeout] forState:UIControlStateNormal];
                NSLog(@"%zd",timeout);
                [UIView commitAnimations];
                sender.userInteractionEnabled = NO;
            });
            timeout --;
        }
    });
    dispatch_resume(_timer);
}


@end
