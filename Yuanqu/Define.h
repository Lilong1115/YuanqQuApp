//
//  Define.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//

#ifndef Define_h
#define Define_h

//随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//屏幕宽高
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

//业务列数
#define BusinessColumns 4

//高德地图key
#define AMapKey @"83334748e8bb105128708bbb51dca7bc"

/******************通知*******************/
//首页业务通知
#define HomeBusinessNotification @"HomeBusinessNotification"
//业务图标
#define AppShowMenuListNotification @"AppShowMenuListNotification"
//首页轮播图通知
#define HomeCycleNotification @"HomeCycleNotification"
//报修上传成功通知
#define AddRepairSuccessNotification @"AddRepairSuccessNotification"
//报修列表获取成功通知
#define AppRepairListSuccessNotification @"AppRepairListSuccessNotification"
//日志列表获取成功
#define AppLogListSuccessNotification @"AppLogListSuccessNotification"
//投诉列表获取成功
#define ComplaintListSuccessNotification @"ComplaintListSuccessNotification"
//确认成功
#define RepairOrderSuccessNotification @"RepairOrderSuccessNotification"
//评价成功
#define EstimateSuccessNotification @"EstimateSuccessNotification"
//投诉成功
#define ComplaintsSuccessNotification @"ComplaintsSuccessNotification"
//未制定工单报修处理列表获取成功通知
#define AppWorkOrderListSuccessNotification @"AppWorkOrderListSuccessNotification"
//制单成功
#define AddWorkOrderSuccessNotification @"AddWorkOrderSuccessNotification"
//未分配(已制定)获取成功通知
#define AppWorkOrderShowListSuccessNotification @"AppWorkOrderShowListSuccessNotification"
//未受理(已分配)获取成功通知
#define AppWorkAcceptListSuccessNotification @"AppWorkAcceptListSuccessNotification"
//受理中获取成功通知
#define AppWorkBeingtListSuccessNotification @"AppWorkBeingtListSuccessNotification"
//分配人员获取成功通知
#define AppChooseUserListSuccessNotification @"AppChooseUserListSuccessNotification"
//分配人员选择后通知
#define AppChooseUserSuccessNotification @"AppChooseUserSuccessNotification"
//分配成功
#define AllotWorkOrderSuccessNotification @"AllotWorkOrderSuccessNotification"
//受理成功
#define AddWorkacceptSuccessNotification @"AddWorkacceptSuccessNotification"
//受理中提交成功
#define AddMaintenaceSuccessNotification @"AddMaintenaceSuccessNotification"
//受理中完成成功
#define AppfinishWorkSuccessNotification @"AppfinishWorkSuccessNotification"
//受理完成列表
#define AppFinishListSuccessNotification @"AppFinishListSuccessNotification"
//登录成功通知
#define AppLoginSuccessNotification @"AppLoginSuccessNotification"
/****************************************/




#endif /* Define_h */
