//
//  GuaranteeModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "GuaranteeModel.h"

@implementation GuaranteeModel

//字典转模型,获取数组
+ (NSArray *)getGuaranteeModelArray {

    NSArray *guaranteeArray = @[
                                @{
                                    @"name": @"姓名:",
                                    @"placeholder": @"请输入姓名",
                                    @"textType": @1,
                                    @"keyboardType": @0
                                    },
                                @{
                                    @"name": @"手机:",
                                    @"placeholder": @"请输入手机号",
                                    @"textType": @1,
                                    @"keyboardType": @1
                                    },
                                @{
                                    @"name": @"地址:",
                                    @"placeholder": @"请输入地址",
                                    @"textType": @1,
                                    @"keyboardType": @0
                                    },
                                @{
                                    @"name": @"标题:",
                                    @"placeholder": @"请输入标题",
                                    @"textType": @1,
                                    @"keyboardType": @0
                                    },
                                @{
                                    @"name": @"内容:",
                                    @"placeholder": @"请输入内容",
                                    @"textType": @2,
                                    @"keyboardType": @0
                                    }
                                ];
    
    
    NSMutableArray *guaranteeArrayM = [NSMutableArray array];
    [guaranteeArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        GuaranteeModel *model = [GuaranteeModel mj_objectWithKeyValues:dict];
        [guaranteeArrayM addObject:model];
        
    }];
    
    return guaranteeArrayM.copy;
}

@end
