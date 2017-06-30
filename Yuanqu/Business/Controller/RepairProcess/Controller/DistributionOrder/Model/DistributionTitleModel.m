//
//  DistributionTitleModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DistributionTitleModel.h"

@implementation DistributionTitleModel

+ (NSArray *)getDistributionTitleModelArray {
    
    NSArray *array = @[
                       @[
                        @{
                           @"title": @"工单编号"
                           },
                       @{
                           @"title": @"报修标题"
                           },
                       @{
                           @"title": @"报修姓名"
                           },
                       @{
                           @"title": @"报修内容"
                           },
                       @{
                           @"title": @"报修电话"
                           },
                       @{
                           @"title": @"报修地址"
                           },
                       @{
                           @"title": @"紧急程度"
                           },
                       @{
                           @"title": @"制单人员"
                           },
                       @{
                           @"title": @"制单时间"
                           }
                         ],
                       @[
                           @{
                            @"title": @"接收人员"
                               }
                           ]
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableArray *arrayMM = [NSMutableArray array];
        
        [obj enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            DistributionTitleModel *model = [DistributionTitleModel mj_objectWithKeyValues:dict];
            [arrayMM addObject:model];
        }];
        [arrayM addObject:arrayMM];
        
    }];
    
    
    return arrayM.copy;
}


+ (NSArray *)getAcceptTitleModelArray {
    
    NSArray *array = @[
                       @[
                           @{
                               @"title": @"单号"
                               },
                           @{
                               @"title": @"标题"
                               },
                           @{
                               @"title": @"姓名"
                               },
                           @{
                               @"title": @"内容"
                               },
                           @{
                               @"title": @"手机"
                               },
                           @{
                               @"title": @"地址"
                               },
                           @{
                               @"title": @"紧急程度"
                               },
                           @{
                               @"title": @"制单人员"
                               },
                           @{
                               @"title": @"制单时间"
                               }
                           ]
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *arrayMM = [NSMutableArray array];
        
        [obj enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
            DistributionTitleModel *model = [DistributionTitleModel mj_objectWithKeyValues:dict];
            [arrayMM addObject:model];
        }];
        [arrayM addObject:arrayMM];
        
    }];
    
    
    return arrayM.copy;
}

@end
