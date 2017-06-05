//
//  HomeModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel

+ (NSArray *)getHomeModelArray {

    NSArray *array = @[
                       @{
                           @"title": @"报修"
                           },
                       @{
                           @"title": @"报修处理"
                           },
                       @{
                           @"title": @"投诉"
                           },
                       @{
                           @"title": @"投诉处理"
                           },
                       @{
                           @"title": @"租赁"
                           },
                       @{
                           @"title": @"缴费"
                           },
                       @{
                           @"title": @"任务"
                           },
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HomeModel *model = [HomeModel mj_objectWithKeyValues:dict];
        [arrayM addObject:model];
        
    }];
    
    return arrayM.copy;
}

@end
