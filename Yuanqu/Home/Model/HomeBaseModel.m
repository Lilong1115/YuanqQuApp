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
                                       @"title": @"绿植租摆",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"送饮用水",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"入室保洁",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"电话网络",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"优惠促销",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"周边信息",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       }
                                   ]},
                       @{
                           @"type": @"服务指南",
                           @"content": @[
                                   @{
                                       @"title": @"园区信息",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"入驻流程",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"装修流程",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"收费标准",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
                                       },
                                   @{
                                       @"title": @"出租房源",
                                       @"icon": @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
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
