//
//  AccountTool.h
//  IntraCityService
//
//  Created by ioi on 16/10/9.
//  Copyright © 2016年 ningchanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountTool : NSObject
/**
 *  存储账号信息
 *  @param account 需要存储的账号信息：第一个值为用户名；第二个值为密码
 */
+ (void)saveAccount:(NSArray *)account;

/**
 *  返回存储的账号信息
 * @return NSArray
 */
+ (NSArray *)getAccount;

/**
 *  返回存储的登陆用户名
 *  @return NSString
 */
+ (NSString *)getUserName;

/**
 *  返回存储的登陆用户密码
 *  @return NSString
 */
+ (NSString *)getPassword;
@end
