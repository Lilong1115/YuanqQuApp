//
//  NSDate+Extension.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/6.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

//讲NSDate转为NSString(2017-06-06)
- (NSString *)creatDateStr {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return strDate;
}
//获取当前年
+ (NSInteger)getCurrentYear {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return [strDate integerValue];
}
//获取当前月
+ (NSInteger)getCurrentMonth {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return [strDate integerValue];
}
//获取当前日
+ (NSInteger)getCurrentDay {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return [strDate integerValue];
}

+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}

@end
