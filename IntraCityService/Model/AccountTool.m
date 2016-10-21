//
//  AccountTool.m
//  IntraCityService
//
//  Created by ioi on 16/10/9.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import "AccountTool.h"

@implementation AccountTool
+ (void)saveAccount:(NSArray *)account{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //保存数据 用户信息；用户名；用户密码
    [userDefaults setObject:account  forKey:@"account" ];
    [userDefaults setObject:[account objectAtIndex:0]  forKey:@"userName" ];
    [userDefaults setObject:[account objectAtIndex:1]  forKey:@"passWord" ];
};


+ (NSArray *)getAccount{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults objectForKey:@"account"];
    return array;
};

+ (NSString *)getUserName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userDefaults objectForKey:@"userName"];
    return userName;
};

+ (NSString *)getPassword{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *passWord = [userDefaults objectForKey:@"passWord"];
    return passWord;
}
@end
