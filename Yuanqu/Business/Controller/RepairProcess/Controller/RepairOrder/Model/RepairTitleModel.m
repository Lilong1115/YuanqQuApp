//
//  RepairTitleModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "RepairTitleModel.h"

@implementation RepairTitleModel

+ (NSArray *)getRepairTitleModelArray {

    NSArray *array = @[
                       @{
                           @"title": @"编号:"
                           },
                       @{
                           @"title": @"姓名:"
                           },
                       @{
                           @"title": @"手机:"
                           },
                       @{
                           @"title": @"地址:"
                           },
                       @{
                           @"title": @"标题:"
                           },
                       @{
                           @"title": @"内容:"
                           },
                       @{
                           @"title": @"报修人员:"
                           },
                       @{
                           @"title": @"发单时间:"
                           },
                       @{
                           @"title": @"紧急程度:"
                           }
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RepairTitleModel *model = [RepairTitleModel mj_objectWithKeyValues:obj];
        [arrayM addObject:model];
        
    }];
    
    return arrayM.copy;
}

+ (NSArray *)getNewRepairTitleModelArray {
    
    NSArray *array = @[
                       @{
                           @"title": @"编号:"
                           },
                       @{
                           @"title": @"姓名:"
                           },
                       @{
                           @"title": @"手机:"
                           },
                       @{
                           @"title": @"地址:"
                           },
                       @{
                           @"title": @"标题:"
                           },
                       @{
                           @"title": @"内容:"
                           },
                       @{
                           @"title": @"制单人员:"
                           },
                       @{
                           @"title": @"制单时间:"
                           },
                       @{
                           @"title": @"紧急程度:"
                           }
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RepairTitleModel *model = [RepairTitleModel mj_objectWithKeyValues:obj];
        [arrayM addObject:model];
        
    }];
    
    return arrayM.copy;
}

@end
