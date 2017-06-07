//
//  NSDate+Extension.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/6.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

//讲NSDate转为NSString(2017-06-06)
- (NSString *)creatDateStr;
//获取当前年
+ (NSInteger)getCurrentYear;
//获取当前月
+ (NSInteger)getCurrentMonth;
//获取当前日
+ (NSInteger)getCurrentDay;
//比较两个时间
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;
@end
