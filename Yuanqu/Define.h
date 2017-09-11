//
//  Define.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//

#ifndef Define_h
#define Define_h


//文件目录
#define FilesPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"files"]

//随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//屏幕宽高
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

//业务列数
#define BusinessColumns 4

//高德地图key
#define AMapKey @"83334748e8bb105128708bbb51dca7bc"

//URLScheme
#define WeixinURLScheme @"weixin"
#define QQURLScheme @"mqq"
#define SinaURLScheme @"sinaweibo"


/******************通知*******************/
//首页业务通知
#define HomeBusinessNotification @"HomeBusinessNotification"
//业务图标
#define AppShowMenuListNotification @"AppShowMenuListNotification"
//首页轮播图通知
#define HomeCycleNotification @"HomeCycleNotification"




//报修上传成功通知
#define AddRepairSuccessNotification @"AddRepairSuccessNotification"
//投诉上传成功通知
#define AppComplaintsSuccessNotification @"AppComplaintsSuccessNotification"
//报修列表获取成功通知
#define AppRepairListSuccessNotification @"AppRepairListSuccessNotification"
//日志列表获取成功
#define AppLogListSuccessNotification @"AppLogListSuccessNotification"
//投诉列表获取成功
#define ComplaintListSuccessNotification @"ComplaintListSuccessNotification"
//我要投诉列表获取成功
#define AppComplainListSuccessNotification @"AppComplainListSuccessNotification"
//确认成功
#define RepairOrderSuccessNotification @"RepairOrderSuccessNotification"
//评价成功
#define EstimateSuccessNotification @"EstimateSuccessNotification"
//投诉成功
#define ComplaintsSuccessNotification @"ComplaintsSuccessNotification"






//未制定工单报修处理列表获取成功通知
#define AppWorkOrderListSuccessNotification @"AppWorkOrderListSuccessNotification"
//未制定投诉单报修处理列表获取成功通知
#define AppComplainManagementListSuccessNotification @"AAppComplainManagementListSuccessNotification"
//制单成功
#define AddWorkOrderSuccessNotification @"AddWorkOrderSuccessNotification"
//制定投诉单成功
#define AddComplainManagementSuccessNotification @"AddComplainManagementSuccessNotification"
//未分配(已制定)获取成功通知
#define AppWorkOrderShowListSuccessNotification @"AppWorkOrderShowListSuccessNotification"
//未分配(已制定)投诉单获取成功通知
#define AppComplainManagementShowListSuccessNotification @"AppComplainManagementShowListSuccessNotification"
//未受理(已分配)获取成功通知
#define AppWorkAcceptListSuccessNotification @"AppWorkAcceptListSuccessNotification"
//未受理(已分配)投诉单获取成功通知
#define AppComplainManagementAcceptListSuccessNotification @"AppComplainManagementAcceptListSuccessNotification"
//受理中获取成功通知
#define AppWorkBeingtListSuccessNotification @"AppWorkBeingtListSuccessNotification"
//受理中投诉单获取成功通知
#define AppComplainManagementBeingtListSuccessNotification @"AppComplainManagementBeingtListSuccessNotification"
//分配人员获取成功通知
#define AppChooseUserListSuccessNotification @"AppChooseUserListSuccessNotification"
//分配人员选择后通知
#define AppChooseUserSuccessNotification @"AppChooseUserSuccessNotification"
//分配成功
#define AllotWorkOrderSuccessNotification @"AllotWorkOrderSuccessNotification"
//分配投诉单成功
#define AllotComplainManagementSuccessNotification @"AllotComplainManagementSuccessNotification"
//受理成功
#define AddWorkacceptSuccessNotification @"AddWorkacceptSuccessNotification"
//受理投诉单成功
#define AddComplainManagementAcceptSuccessNotification @"AddComplainManagementAcceptSuccessNotification"

//受理中提交成功
#define AddMaintenaceSuccessNotification @"AddMaintenaceSuccessNotification"
//受理中投诉单提交成功
#define AddComplainLogsSuccessNotification @"AddComplainLogsSuccessNotification"
//受理中完成成功
#define AppfinishWorkSuccessNotification @"AppfinishWorkSuccessNotification"
//受理中投诉单完成成功
#define AppFinishComplainLogsSuccessNotification @"AppFinishComplainLogsSuccessNotification"

//受理完成列表
#define AppFinishListSuccessNotification @"AppFinishListSuccessNotification"
//受理完成投诉列表
#define AppFinishComplainLogsSuccessNotification @"AppFinishComplainLogsSuccessNotification"



/* 装修申报 */
//装修上传文件列表
#define AppGetRenovatioSuccessNotification @"AppGetRenovatioSuccessNotification"
//装修申报待提交列表
#define AppGetRenovationListSuccessNotification @"AppGetRenovationListSuccessNotification"
//装修申报已提交列表
#define AppGetRenovationSubmittedSuccessNotification @"AppGetRenovationSubmittedSuccessNotification"
//装修申报待清除列表
#define AppDeleteListSuccessNotification @"AppDeleteListSuccessNotification"
//装修申报待审核列表
#define AppDshListSuccessNotification @"AppDshListSuccessNotification"
//装修申报已审核列表
#define AppYshListSuccessNotification @"AppYshListSuccessNotification"
//装修申报添加
#define AddRenovationSuccessNotification @"AddRenovationSuccessNotification"
//装修申报提交
#define AddRenovationSubmitSuccessNotification @"AddRenovationSubmitSuccessNotification"
//装修申报删除
#define AddRenovationDeleteSuccessNotification @"AddRenovationDeleteSuccessNotification"
//装修申报待清除彻底删除
#define AppDeleteCleanSuccessNotification @"AppDeleteCleanSuccessNotification"
//装修申报带清除还原
#define AddRestoreSuccessNotification @"AddRestoreSuccessNotification"
//修改
#define AddModifySuccessNotification @"AddModifySuccessNotification"

//审核结果列表
#define AppCheckListSuccessNotification @"AppCheckListSuccessNotification"
//审核
#define AddAuditSuccessNotification @"AddAuditSuccessNotification"


//装修申报巡检功能
#define AddSearchSuccessNotification @"AddSearchSuccessNotification"
//装修巡检获取信息
#define PatrolListSuccessNotification @"PatrolListSuccessNotification"

//文件选择
#define FileSelectedSuccessNotification @"FileSelectedSuccessNotification"




//登录成功通知
#define AppLoginSuccessNotification @"AppLoginSuccessNotification"
/****************************************/




#endif /* Define_h */
