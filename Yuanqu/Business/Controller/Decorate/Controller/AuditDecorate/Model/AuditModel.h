//
//  AuditModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/8.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuditModel : NSObject

//审核意见：APP_SHJG   1：通过 ，0 ：不通过
@property (nonatomic, copy) NSString *app_SHJG;
//审核人员：APP_SHRY
@property (nonatomic, copy) NSString *app_SHRY;
//审核理由：APP_SHYJ
@property (nonatomic, copy) NSString *app_SHYJ;
//审核时间：APP_SHSJ
@property (nonatomic, copy) NSString *app_SHSJ;
//审核部门: APP_SHBM
@property (nonatomic, copy) NSString *app_SHBM;

//系统编号 ： SYSID
@property (nonatomic, copy) NSString *sysid;

//"app_SHBM" = "";
//"app_SHJG" = 1;
//"app_SHRY" = "\U535a\U4f17\U5ba2\U6237\U7ecf\U7406";
//"app_SHSJ" = "Tue Aug 08 00:00:00 CST 2017";
//"app_SHYJ" = "\U6211\U4e5f\U4e0d\U77e5\U9053\U600e\U4e48\U5c31\U901a\U8fc7\U4e86";
//itemid = FDC34228E1F54B24A36BEB3E6AD0A66A;
//"sys_SN" = "<null>";
//sysdate = "";
//sysid = 85D5EC0F9A7B487BB8D653790C0100BA;

+ (void)getAuditArrayWithDict:(NSDictionary *)dic;
+ (void)addAuditSubmitWithDict:(NSDictionary *)dic;

//获取字段名称
+ (NSArray *)getAuditSubmitList;

@end
