//
//  PersonalModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PersonalModel.h"

@implementation PersonalModel

+ (NSArray *)getPersonalModelArray {

    NSArray *array = @[
                       @{
                           @"head": @"头像",
                           @"content": @"",
                           @"icon": [UserInfo account].dsoa_user_photo,
                           @"isIcon": @1
                           },
                       @{
                           @"head": @"用户名",
                           @"content": [UserInfo account].dsoa_user_name,
                           @"icon": @"",
                           @"isIcon": @0
                           },
                       @{
                           @"head": @"手机号",
                           @"content": [UserInfo account].dsoa_user_modileno,
                           @"icon": @"",
                           @"isIcon": @0
                           },
                       @{
                           @"head": @"部门",
                           @"content": [UserInfo account].dsoa_dept_name,
                           @"icon": @"",
                           @"isIcon": @0
                           },
                       @{
                           @"head": @"职务",
                           @"content": [UserInfo account].dsoa_user_headship,
                           @"icon": @"",
                           @"isIcon": @0
                           }
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PersonalModel *model = [PersonalModel mj_objectWithKeyValues:obj];
        [arrayM addObject:model];
    }];
    
    return arrayM.copy;
}


@end
