//
//  RepairOrderModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepairOrderModel : NSObject

//工单系统编号：SYSID
@property (nonatomic, copy) NSString *sysid;
//工单编号：ITEMID
@property (nonatomic, copy) NSString *itemid;
//报修人姓名：WD_KHMC
@property (nonatomic, copy) NSString *wd_KHMC;
//报修标题：WD_BXBT
@property (nonatomic, copy) NSString *wd_BXBT;
//报修地址：WD_WYDZ
@property (nonatomic, copy) NSString *wd_WYDZ;
//报修内容：WD_BXNR
@property (nonatomic, copy) NSString *wd_BXNR;
//报修电话：WD_BXDH
@property (nonatomic, copy) NSString *wd_BXDH;
//紧急程度：WD_JJCD
@property (nonatomic, copy) NSString *wd_JJCD;
//报修单系统编号：WD_BYE
@property (nonatomic, copy) NSString *wd_BYE;
//工单生成时间：SYSDATE
@property (nonatomic, copy) NSString *sysdate;
//维修人员：WD_JDRY
@property (nonatomic, copy) NSString *wd_JDRY;
//维修人电话：WD_LXDH
@property (nonatomic, copy) NSString *wd_LXDH;
//工单分派时间：SENDDATE
@property (nonatomic, copy) NSString *senddate;
//分配工单人员：OBJNAME
@property (nonatomic, copy) NSString *objname;
//工单接受人ID		OBJID
@property (nonatomic, copy) NSString *objid;
//费用               WD_FY
@property (nonatomic, copy) NSString *wd_FY;
//制单人员
@property (nonatomic, copy) NSString *username;

//已制定(未分配)工单列表
+ (void)getYesRepairOrderListModelArray;
//已分配(未受理)工单列表
+ (void)getYesDistributionOrderListModelArray;
//受理中工单列表
+ (void)getAcceptingOrderListModelArray;
//受理完成列表
+ (void)getAcceptFinishOrderListModelArray;

//分配工单
+ (void)distributionOrderSubmitWithDict:(NSDictionary *)dict;
//受理工单
+ (void)acceptOrderSubmitWithDict:(NSDictionary *)dict;
//受理中提交工单
+ (void)acceptingOrderSubmitWithDict:(NSDictionary *)dict;
//受理中完成工单
+ (void)acceptFinishOrderSubmitWithDict:(NSDictionary *)dict;
/*
工单系统编号：SYSID
工单编号：ITEMID
报修人姓名：WD_KHMC
报修标题：WD_BXBT
报修地址：WD_WYDZ
报修内容：WD_BXNR
报修电话：WD_BXDH
紧急程度：WD_JJCD
维修人员：WD_JDRY
维修人电话：WD_LXDH
报修单系统编号：WD_BYE
工单分派时间：SENDDATE
*/

@end
