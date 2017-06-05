//
//  HomeBaseModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HomeBaseModel.h"

@implementation HomeBaseModel

+ (NSArray *)getHomeBaseModelArray {

    NSArray *array = @[@{
                           @"type": @"办公保障",
                           @"content": @[
                                   @{
                                       @"title": @"绿植租摆"
                                       },
                                   @{
                                       @"title": @"送饮用水"
                                       },
                                   @{
                                       @"title": @"入室保洁"
                                       },
                                   @{
                                       @"title": @"电话网络"
                                       },
                                   @{
                                       @"title": @"优惠促销"
                                       },
                                   @{
                                       @"title": @"周边信息"
                                       }
                                   ]},
                       @{
                           @"type": @"服务指南",
                           @"content": @[
                                   @{
                                       @"title": @"园区信息"
                                       },
                                   @{
                                       @"title": @"入驻流程"
                                       },
                                   @{
                                       @"title": @"装修流程"
                                       },
                                   @{
                                       @"title": @"收费标准"
                                       },
                                   @{
                                       @"title": @"出租房源"
                                       }
                                   ]},
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HomeBaseModel *model = [HomeBaseModel mj_objectWithKeyValues:dict];
        [arrayM addObject:model];
    }];
    
    return arrayM.copy;
}


/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"content": @"HomeModel"
              };
}


@end
