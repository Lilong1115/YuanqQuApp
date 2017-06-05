//
//  Calculate.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

//计算业务行数
#import "Calculate.h"

@implementation Calculate

//计算业务行数
+ (NSInteger)calculateRowsWithCount:(NSInteger)count columns:(NSInteger)columns {
    
    return (count - 1) / columns + 1;
}

@end
