//
//  GuaranteeListModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/16.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuaranteeListModel : NSObject

//报修姓名
@property (nonatomic, copy) NSString *rd_BXXM;
//报修电话
@property (nonatomic, copy) NSString *rd_BXDH;
//报修标题
@property (nonatomic, copy) NSString *rd_BXBT;
//报修内容
@property (nonatomic, copy) NSString *rd_BXNR;
//报修坐标
@property (nonatomic, copy) NSString *rd_SFZB;
//报修图片
@property (nonatomic, copy) NSString *rd_BXTP;
//项目编号
@property (nonatomic, copy) NSString *itemid;
//系统编号
@property (nonatomic, copy) NSString *sysid;
//用户所属编号 01
@property (nonatomic, copy) NSString *ssbm;
//添加时间
@property (nonatomic, copy) NSString *sysdate;
//发单人员：OBJNAME
@property (nonatomic, copy) NSString *objname;
//发单时间
@property (nonatomic, copy) NSString *senddate;
//状态: RD_CLBJ    0  我要确认， 1 我要评价， 大于1  按钮隐藏
@property (nonatomic, copy) NSString *rd_CLBJ;
//报修人员
@property (nonatomic, copy) NSString *username;

/**********投诉*************/
//SYSID  系统Id
@property (nonatomic, copy) NSString *SYSID;
//ITEMID  项目ID
@property (nonatomic, copy) NSString *ITEMID;
//CD_TSXM 投诉姓名
@property (nonatomic, copy) NSString *CD_TSXM;
//CD_LXSJ 联系手机
@property (nonatomic, copy) NSString *CD_LXSJ;
//CD_LXDH 联系电话
@property (nonatomic, copy) NSString *CD_LXDH;
//CD_LXDZ 联系地址
@property (nonatomic, copy) NSString *CD_LXDZ;
//CD_TSBT 投诉标题
@property (nonatomic, copy) NSString *CD_TSBT;
//CD_NRMS 内容描述
@property (nonatomic, copy) NSString *CD_NRMS;
//CJSJ 写入时间
@property (nonatomic, copy) NSString *CJSJ;
//NUMBERS 单号
@property (nonatomic, copy) NSString *NUMBERS;

//获取我要投诉列表
+ (void)getAppComplaintsListModelArray;
//获取投诉列表
+ (void)getComplaintsListModelArray;

//获取查看报修,并发送通知
+ (void)getGuaranteeListModelArray;
//未制定工单列表
+ (void)getNoRepairOrderListModelArray;
//未制定投诉单列表
+ (void)getNoComplaintOrderListModelArray;

//制单提交
+ (void)repairOrderSubmitWithDict:(NSDictionary *)dict;
//制定投诉单提交
+ (void)complaintOrderSubmitWithDict:(NSDictionary *)dict;

//我要确认
+ (void)repairSubmitWithDict:(NSDictionary *)dict;

@end


/*
 SYSID  系统Id
 ITEMID  项目ID
 CD_TSXM 投诉姓名
 CD_LXSJ 联系手机
 CD_LXDH 联系电话
 CD_LXDZ 联系地址
 CD_TSBT 投诉标题
 CD_TSLX 投诉类型
 CD_NRMS 内容描述
 CD_BYA  备用
 CD_BYB 备用
 CD_BYC 备用
 CD_BYD 备用
 CD_BYE 备用
 CD_BYF 备用
 CD_BYG 备用
 CD_BYH 备用
 CD_BYI 备用
 CD_BYJ 备用
 CD_BYK 备用
 CD_BYL 备用
 CD_BYM 备用
 CD_BYN 备用
 CD_BYO 备用
 CD_SPTX 视频图像
 CD_CJRID 创建人ID
 CD_CJSJ 创建时间
 CD_TSBJ 推送标记
 CD_TSSJ 推送时间
 CD_CLBJ 处理标记
 CD_CLSJ 处理时间
 SYSDATE 写入时间
 USERNAME 用户名称
 USERID 用户ID
 SSBM 所属编码
 DISPOSE 处理标记
 DELSIGN 删除标记
 SENDSIGN 发送标记
 RESTORESIGN 还原标记
 EAASIGN 审批标记
 DELDATE 删除时间
 SENDDATE 发送时间
 RESTOREDATE 还原时间
 EAADATE 审批时间
 OBJID 接受对象ID
 OBJNAME 接受对象名称
 READSIGN 收取标记
 READDATE 收取时间
 */

/*
 参数：
 用户id :uuid
 返回值：
 系统编号：SYSID
 项目编号：ITEMID
 报修姓名：RD_BXXM
 报修电话：RD_BXDH
 报修内容：RD_BXBT
 报修标题：RD_BXNR
 事发坐标：RD_SFZB
 报修图片：RD_BXTP
 所属编码:  SSBM
 状态: RD_CLBJ    0  我要确认， 1 我要评价  ， 大于1  按钮隐藏
 添加时间:SYSDATE
 
 */
