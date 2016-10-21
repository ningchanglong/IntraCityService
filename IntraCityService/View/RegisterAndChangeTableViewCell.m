//
//  RegisterAndChangeTableViewCell.m
//  IntraCityService
//
//  Created by ioi on 16/10/9.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "RegisterAndChangeTableViewCell.h"

@implementation RegisterAndChangeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 20)];
//        self.leftImage.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:self.leftImage];
        self.contentTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImage.frame) + 15, 0, SCR_W - 25 - CGRectGetWidth(self.leftImage.frame), 40)];
//        self.contentTF.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.contentTF];
        self.codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_W - 100, 5, 90, 30)];
        self.codeBtn.backgroundColor = [UIColor colorWithHexString:@"#6fc8ff" alpha:1.0];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        codeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.codeBtn.layer.masksToBounds = YES;
        self.codeBtn.layer.cornerRadius = 5;
//        [self.codeBtn addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
        self.codeBtn.hidden = YES;
        [self.contentView addSubview:self.codeBtn];
    }
    return self;
}

- (void)codeClick:(UIButton *)sender
{
    self.codeBlock(sender);
//    __block int timeout= 60; //倒计时时间
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//    dispatch_source_set_event_handler(_timer, ^{
//        if(timeout<= 1){ //倒计时结束，关闭
//            dispatch_source_cancel(_timer);
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
//                sender.userInteractionEnabled = YES;
//            });
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [UIView beginAnimations:nil context:nil];
//                [UIView setAnimationDuration:1];
//                [sender setTitle:[NSString stringWithFormat:@"重新获取(%zds)",timeout] forState:UIControlStateNormal];
//                [UIView commitAnimations];
//                sender.userInteractionEnabled = NO;
//            });
//            timeout--;
//        }
//    });
//    dispatch_resume(_timer);
}

@end
