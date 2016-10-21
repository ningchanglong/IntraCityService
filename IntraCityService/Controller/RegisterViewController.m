//
//  RegisterViewController.m
//  IntraCityService
//
//  Created by ioi on 16/10/8.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterAndChangeTableViewCell.h"
@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSString *account;
@property (nonatomic,strong)NSString *password;
@property (nonatomic,strong)NSString *code;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

- (void)createUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    //如果界面主体控制器只是tableVie，可以创建继承于UITableViewController的控制器
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_W, SCR_H - 64) style:UITableViewStylePlain];
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
    return 3;
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
    return 150;
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
//        cell.contentTF.placeholder = @"输入手机号";
        cell.contentTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入手机号" attributes:@{}];
        cell.contentTF.tag = indexPath.row;
    }else if (indexPath.row == 1) {
        cell.leftImage.image = [UIImage imageNamed:@"icon_verification_code"];
        cell.contentTF.placeholder = @"输入手机验证码";
        cell.contentTF.tag = indexPath.row;
    }else {
        cell.leftImage.image = [UIImage imageNamed:@"icon_password"];
        cell.contentTF.placeholder = @"输入密码";
        cell.contentTF.tag = indexPath.row;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] init];
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 24, SCR_W - 20, 40)];
    registerBtn.backgroundColor = [UIColor colorWithHexString:@"#1c96e2" alpha:1.0];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    registerBtn.layer.masksToBounds = YES;
    registerBtn.layer.cornerRadius = 5;
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:registerBtn];
    
    UIButton *drawBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(registerBtn.frame) + 13, 25, 25)];
//    drawBtn.backgroundColor = [UIColor redColor];
//    [drawBtn setImage:[UIImage imageNamed:@"icon_rectangle"] forState:UIControlStateNormal];
    [drawBtn setBackgroundImage:[UIImage imageNamed:@"icon_rectangle"] forState:UIControlStateNormal];
    drawBtn.selected = NO;
    [drawBtn addTarget:self action:@selector(drawClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:drawBtn];
    UIButton *AgreementBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(drawBtn.frame) + 3, CGRectGetMaxY(registerBtn.frame) + 10, 200, 30)];
    AgreementBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [AgreementBtn setTitleColor:[UIColor colorWithHexString:@"#7d7d7d" alpha:1.0] forState:UIControlStateNormal];
    [AgreementBtn setTitle:@"我已阅读并接受注册协议 >" forState:UIControlStateNormal];
//    AgreementBtn.backgroundColor = [UIColor yellowColor];
    [AgreementBtn addTarget:self action:@selector(checkClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:AgreementBtn];
    return footerView;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        self.account = textField.text;
    }else if (textField.tag == 1) {
        self.code = textField.text;
    }else {
        self.password = textField.text;
    }
}

- (void)registerClick
{
    [self.view endEditing:YES];
}

- (void)drawClick:(UIButton *)sender
{
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
//        sender.backgroundColor = [UIColor yellowColor];
        [sender setBackgroundImage:[UIImage imageNamed:@"icon_rectangle"] forState:UIControlStateNormal];
    } else {
//         sender.backgroundColor = [UIColor redColor];
        [sender setBackgroundImage:[UIImage imageNamed:@"icon_rectangle_selected"] forState:UIControlStateSelected];
    }
}

- (void)checkClick
{
    [self.view endEditing:YES];
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
