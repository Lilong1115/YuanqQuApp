//
//  ReceivePersonModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReceivePersonModel : NSObject
//维修员编号：dsoa_user_code
@property (nonatomic, copy) NSString *userid;
//维修员名字：dsoa_user_name
@property (nonatomic, copy) NSString *name;
//部门编号：dsoa_user_department
@property (nonatomic, copy) NSString *deptCode;
//部门系统编号：dsoa_system_id
@property (nonatomic, copy) NSString *deptCodeSystemId;
//维修员手机号：DSOA_USER_MODILENO
@property (nonatomic, copy) NSString *modileno;
//部门名称：dsoa_dept_name
@property (nonatomic, copy) NSString *deptName;
//人员类型：dsoa_user_type(0内部人员，1注册用户)
@property (nonatomic, copy) NSString *utype;
//所属编码：dsoa_user_suoscode
@property (nonatomic, copy) NSString *suosu;

+ (void)getReceivePersonModelArray;

@end
