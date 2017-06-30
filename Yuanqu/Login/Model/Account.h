//
//  Account.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/12.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

/* 部门 */
@property (nonatomic, copy) NSString *dsoa_dept_name;
/* 系统id */
@property (nonatomic, copy) NSString *dsoa_system_id;
/* 账户 */
@property (nonatomic, copy) NSString *dsoa_user_code;
/* 部门编号 */
@property (nonatomic, copy) NSString *dsoa_user_department;
/* 职务 */
@property (nonatomic, copy) NSString *dsoa_user_headship;
/* 手机号 */
@property (nonatomic, copy) NSString *dsoa_user_modileno;
/* 姓名 */
@property (nonatomic, copy) NSString *dsoa_user_name;
/* 照片 */
@property (nonatomic, copy) NSString *dsoa_user_photo;
/* 所属编码 */
@property (nonatomic, copy) NSString *dsoa_user_suoscode;
/* 用户类型 */
@property (nonatomic, copy) NSString *dsoa_user_type;

+ (instancetype)accountWithDic: (NSDictionary *)dic;

@end
