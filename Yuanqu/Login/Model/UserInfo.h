//
//  ZTRadida
//
//  Created by zhangtong on 16/6/12.
//  Copyright © 2016年 zhangtong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
//#import "XBAccessTokenResult.h"
@interface  UserInfo: NSObject
/**
 *  实例化
 */
+ (UserInfo *)shared;

/**
 *  登录
 */
+ (void)loginWithPhone:(NSString *)phone password:(NSString *)password;

/**
 *  保存
 */
+ (void)saveAccount:(Account *)account;
/**
 *  取出数据
 *
 *  @return account
 */
+ (Account *)account;

+(void)removeAccount;

//注销登录，删掉账户
+(void)logoutAccount;

@end