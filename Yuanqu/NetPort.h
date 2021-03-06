//
//  NetPort.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/17.
//  Copyright © 2017年 李龙. All rights reserved.
//

#ifndef NetPort_h
#define NetPort_h

/*******************URL******************/
//baseUrl
#define BaseUrl [NSString stringWithFormat:@"%@/", BaseQRCode_URL]
//@"http://192.168.100.186:8080/Apps/"
//#define BaseUrl @"http://192.168.100.232:8080/Apps/"
//#define BaseUrl @"http://222.35.27.156:8080/SMP/"

#define BaseQRCode_URL @"http://192.168.100.232:8080/Apps"
//#define BaseQRCode_URL @"http://222.35.27.156:8080/SMP"
//#define BaseQRCode_URL @"http://192.168.100.186:8080/Apps"
//cdnUrl
#define CDNUrl @""
//扫一扫baseUrl
#define ScanBaseUrl @"http://222.35.27.156:8080/SMP/"

//后台数据状态码
typedef NS_ENUM(NSUInteger, returnState) {
    //成功
    Success_Code = 1000,
    //失败
    Failed_Code = 1001,
    //异常
    Error_Code = 1002,
    //账号或密码错误
    Account_Or_Error_Code = 1004,
};

//URL
/*--------------首页----------------*/
/*
 首页业务
 参数
 ssbm    所属编号 NSString
 返回值
 data    数据
 msg     状态
 ret     状态码
 status
 */
#define Home_URL @"appMainios.do"


/*
 首页轮播图
 返回值
 data    数据
 msg     状态
 ret     状态码
 status
 */
#define HomeCycleView_URL @"AdvertisementController.do/AdvertisementList"
/*--------------首页----------------*/


/*--------------业务----------------*/
/*
APP业务菜单模块
URL:appShowMenuList.do
参数：
用户ID  userid
返回值：
图标 	:icon
模块名称 	:name
请求地址	:url
模块编号  :type
 装修申报  ：type：02
 工单管理  ：      07
 报修管理  ：      06
 我要投诉  :  12
 投诉管理     13
 会议预约  ：	14

*/

//业务类型
typedef NS_ENUM(NSUInteger, BusinessType) {
    //装修申报
    DecorateType = 2,
    //设备管理
    EquipmentType = 5,
    //报修管理
    RepairType = 6,
    //工单管理
    RepairOrderType = 7,
    //我要投诉
    ToComplaintType = 12,
    //投诉管理
    ComplaintType = 13,
    //会议预约
    ConferenceReservationType = 14,
    //申报审核
    AuditDecorateType = 15,
};

#define AppShowMenuList_URL @"appShowMenuList.do"


/*
投诉列表接口
ComplaintList.do
参数   USERID
 返回值
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
#define ComplaintList_URL @"ComplaintList.do"

/*--------------业务----------------*/


/*--------------投诉----------------*/
/*
添加投诉主程序
URL ：addComplain.do
参数：
报修姓名：RD_BXXM
报修电话：RD_BXDH
报修内容：RD_BXNR
报修标题：RD_BXBT
事发地址：RD_SFZB
用户姓名：USERNAME
用户ID：UUID
用户所属编号：SSBM
图片：imgStr
所属公司名称：DEPTNAME
*/
#define AddComplain_URL @"addComplain.do"


/*
投诉单列表
URL : appComplainList.do
参数：
用户id :uuid
返回值：
系统编号：SYSID
项目编号：ITEMID
报修姓名：RD_BXXM
报修电话：RD_BXDH
报修内容：RD_BXNR
报修标题：RD_BXBT
事发地址：RD_SFZB
报修图片：RD_BXTP
所属编码:  SSBM
添加时间:SYSDATE
*/
#define AppComplainList_URL @"appComplainList.do"



/*
未制定投诉列表
URL：appComplainManagementList.do
参数：
所属编号：SSBM
返回值:
系统编号：SYSID
项目编号：ITEMID
报修姓名：RD_BXXM
报修电话：RD_BXDH
报修内容：RD_BXNR
报修标题：RD_BXBT
事发地址：RD_SFZB
报修图片：RD_BXTP
发单人员：OBJNAME
发单时间：SENDDATE
*/
#define AppComplainManagementList_URL @"appComplainManagementList.do"



/*
制定投诉单主程序
URL:  addComplainManagement.do
参数：
报修姓名：WD_KHMC
报修单系统编号：WD_BYE
事发地址：WD_WYDZ
报修内容：WD_BXNR
报修标题：WD_BXBT
紧急程度：WD_JJCD
登录用户名：USERNAME
登录用户ID：UUID
登录用户所属编号：SSBM
所属公司名称：DEPTNAME
*/
#define AddComplainManagement_URL @"addComplainManagement.do"



/*
未分配投诉单列表
URL：appComplainManagementShowList.do
参数：
所属编号：SSBM
返回值：
工单系统编号：SYSID
工单编号：ITEMID
报修人姓名：WD_KHMC
报修标题：WD_BXBT
报修地址：WD_WYDZ
报修内容：WD_BXNR
报修电话：WD_BXDH
紧急程度：WD_JJCD
报修单系统编号：WD_BYE
工单生成时间：SYSDATE
*/
#define AppComplainManagementShowList_URL @"appComplainManagementShowList.do"


/*
分配工单主程序
URL：allotComplainManagement.do
参数：
工单系统编号：SYSID
工单接受人ID：WD_SLRID
工单接收人姓名：WD_SLRNAME
工单维修人电话：WD_LXDH
所属公司名称：DEPTNAME
报修单系统编号：WD_BYE
报修单标题： WD_BXBT
当前用户名： USERNAME
*/
#define AllotComplainManagement_URL @"allotComplainManagement.do"


/*
未受理投诉列表（已分配投诉）
URL：appComplainManagementAcceptList.do
参数：
所属编号：SSBM
当前用户ID：   USERID
返回值：
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
分配工单人员：OBJNAME
*/
#define AppComplainManagementAcceptList_URL @"appComplainManagementAcceptList.do"



/*
待受理工单主程序
URL:addComplainManagementAccept.do
参数：
工单系统编号 :  SYSID
当前用户ID：   USERID
当前用户名： USERNAME
所属公司名称：DEPTNAME
报修单系统编号：WD_BYE
报修单标题：	WD_BXBT
*/
#define AddComplainManagementAccept_URL @"addComplainManagementAccept.do"



/*
受理中投诉列表
URL:appComplainManagementBeingtList.do
参数：
当前用户id:  	 USERID
所属编码：		 SSBM
返回值：
工单系统编号：	SYSID
工单编号			ITEMID
报修人姓名		WD_KHMC
报修地址			WD_WYDZ
报修内容			WD_BXNR
紧急程度			WD_JJCD
报修电话			WD_BXDH
报修标题			WD_BXBT
分配时间			SENDDATE
报修单系统编号： WD_BYE
工单接受人ID		OBJID
工单接受人姓名   OBJNAME
所属公司名称：DEPTNAME
报修单标题：	WD_BXBT
*/
#define AppComplainManagementBeingtList_URL @"appComplainManagementBeingtList.do"


/*
受理中处理投诉（提交）
URL：addComplainLogs.do
参数：
报修单系统编号：  MR_GDBH
当前用户名：		USERNAME
当前用户ID ：		USERID
维修描述：			MR_WXBZ
所属编码：			SSBM
所属公司名称：DEPTNAME
报修单标题：	WD_BXBT
*/
#define AddComplainLogs_URL @"addComplainLogs.do"



/*
受理中处理投诉（完成）
URL：addFinishComplainLogs.do
参数：
报修单系统编号：  MR_GDBH
当前用户名：		USERNAME
当前用户ID ：		USERID
维修描述：			MR_WXBZ
所属编码：			SSBM
所属公司名称：DEPTNAME
报修单系统编号：WD_BYE
报修单标题：	WD_BXBT
*/
#define AddFinishComplainLogs_URL @"addFinishComplainLogs.do"



/*
受理投诉已完成列表
URL：appFinishComplainLogs.do
参数：
所属编码：SSBM
返回值：
工单系统编号	： SYSID
工单编号 		： ITEMID
报修人员：         WD_KHMC
事发地址           WD_WYDZ
报修内容           WD_BXNR
紧急程度           WD_JJCD
是否收费           WD_SFSF
费用               WD_FY
报修电话           WD_BXDH
报修标题           WD_BXBT
报修单系统编号     WD_BYE
工单生成时间       SYSDATE
*/
#define AppFinishComplainManagement_URL @"appFinishComplainManagement.do"



/*
投诉日志列表 IOS
URL:appComplainLogsIOS.do
参数：
报修单系统编号：SYSID
返回值：
日志时间：SHIJIAN
日志内容：NEIRONG
*/
#define AppComplainLogsIOS_URL @"appComplainLogsIOS.do"


/*
 投诉单详细信息
 我要确认    0
 我要评价    1
 我要投诉 	  2
 URL：ComplainOrder.do
 参数：
 RD_CLBJ
 ITEMID
 CC_LXBH
 USERNAME
 CC_WXZT
 CC_WXFS
 CC_SYCL
 CC_WCBZ
 SYSDATE
 USERNAME
 USERID
 SSBM
 DISPOSE
 DELSIGN
 SENDSIGN
 RESTORESIGN
 EAASIGN
 DELDATE
 SENDDATE
 RESTOREDATE
 EAADATE
 OBJID
 OBJNAME
 READSIGN
 READDATE
 */
#define ComplainOrder_URL @"ComplainOrder.do"



/*--------------投诉----------------*/




/*--------------报修----------------*/
/*
 添加报修单
 参数：
 报修姓名：RD_BXXM
 报修电话：RD_BXDH
 报修内容：RD_BXBT
 报修标题：RD_BXNR
 报修图片：RD_BXTP
 事发坐标：RD_SFZB
 用户姓名：USERNAME
 用户ID：USERID
 用户所属编号：SSBM
 图片：imgStr
 返回值
 data    数据
 msg     状态
 ret     状态码
 status
 */
#define AddRepair_URL @"addRepair.do"


/*
 报修单列表
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
 添加时间:SYSDATE
 */
#define AppRepairList_URL @"appRepairList.do"


/*
 我要确认
 参数
 ITEMID 项目编号
 USERID   用户ID
 USERNAME 用户名称
 RD_CLBJ 状态
 返回值
{"ret":"1001","data":1001,"msg":"failure"}
{"ret":"1000","data":1000,"msg":"success"}
{"ret":"1002","data":1002,"msg":"error"}
 我要评价
 ITEMID  系统编号
 CE_PF   工作态度 
 CE_MYD  维修进度
 CE_PJNR 评价内容
 RD_CLBJ   1
 USERID   用户ID
 USERNAME 用户名称
 我要投诉											
 ITEMID 项目编号，
 CD_TSXM 投诉姓名，
 CD_LXSJ  联系手机号，
 CD_LXDZ 地址，
 CD_TSBT  标题，
 CD_NRMS 内容，
 CD_TSLX  类型，
 USERNAME 用户名称，
 USERID   用户ID，
 RD_CLBJ  状态（2)
*/
#define Repairorder_URL @"Repairorder.do"

/*
日志列表 IOS
URL:appRepairLogsIOS.do
参数：
报修单系统编号：SYSID
返回值：
日志时间：SHIJIAN
日志内容：NEIRONG
*/
#define AppRepairLogsIOS_URL @"appRepairLogsIOS.do"

/*--------------报修----------------*/





/*--------------报修处理----------------*/
/*
 报修处理 - 制定工单 - 未制定报修数据列表
 参数：
 所属编号：ssbm
 返回值:
 系统编号：SYSID
 项目编号：ITEMID
 报修姓名：RD_BXXM
 报修电话：RD_BXDH
 报修内容：RD_BXNR
 报修标题：RD_BXBT
 事发地址：RD_SFZB
 报修图片：RD_BXTP
 */
#define AppWorkOrderList_URL @"appWorkOrderList.do"

/*
 报修处理 - 制定工单 - 提交
 参数：
 报修姓名：WD_KHMC
 报修单系统编号：WD_BYE
 事发地址：WD_WYDZ
 报修内容：WD_BXNR
 报修标题：WD_BXBT
 紧急程度：WD_JJCD
 登录用户名：USERNAME
 登录用户ID：UUID
 登录用户所属编号：SSBM
 */
#define AddWorkOrder_URL @"addWorkOrder.do"


/*
 报修处理 - 分配工单(已制定工单) - 未分配列表
 参数：
 所属编号：ssbm
 返回值：
 工单系统编号：SYSID
 工单编号：ITEMID
 报修人姓名：WD_KHMC
 报修标题：WD_BXBT
 报修地址：WD_WYDZ
 报修内容：WD_BXNR
 报修电话：WD_BXDH
 紧急程度：WD_JJCD
 报修单系统编号：WD_BYE
 工单生成时间：SYSDATE
 */
#define AppWorkOrderShowList_URL @"appWorkOrderShowList.do"


/*
 报修处理 - 分配工单
 参数：
 工单系统编号：SYSID
 工单接受人ID：WD_SLRID
 工单接收人姓名：WD_SLRNAME
 工单维修人电话：WD_LXDH
 */
#define AllotWorkOrder_URL @"allotWorkOrder.do"


/*
 报修处理 - 未受理工单(已分配) - 列表
 参数：
 所属编号：SSBM
 返回值：
 工单系统编号：SYSID
 工单编号：ITEMID
 报修人姓名：WD_KHMC
 报修标题：WD_BXBT
 报修地址：WD_WYDZ
 报修内容：WD_BXNR
 报修电话：WD_BXDH
 紧急程度：WD_JJCD
 报修单系统编号：WD_BYE
 工单分派时间：SENDDATE
 */
#define AppWorkAcceptList_URL @"appWorkAcceptList.do"



/*
工单管理—分配工单—待分配（分配人员列表）
参数：
所属编号：SUOSCODE
返回值：
 维修员编号：userid
 维修员名字：name
 部门编号：deptCode
 部门系统编号：deptCodeSystemId
 维修员手机号：modileno
 部门名称：deptName
 人员类型：utype (0内部人员，1注册用户)
 所属编码：suosu
*/
#define AppChooseUserList_URL @"appChooseUserList.do"


/*
待受理工单主程序
URL:addWorkaccept.do
参数：
工单系统编号 :  SYSID
当前用户ID：   USERID
*/
#define AddWorkaccept_URL @"addWorkaccept.do"


/*
受理中工单列表
URL:appWorkBeingtList.do
参数：
当前用户id:  	 USERID
所属编码：		 SSBM
返回值：
工单系统编号：	SYSID
工单编号			ITEMID
报修人姓名		WD_KHMC
报修地址			WD_WYDZ
报修内容			WD_BXNR
紧急程度			WD_JJCD
报修电话			WD_BXDH
报修标题			WD_BXBT
分配时间			SENDDATE
工单接受人ID		OBJID
工单接受人姓名   OBJNAME
*/
#define AppWorkBeingtList_URL @"appWorkBeingtList.do"


/*
受理中处理工单（提交）
URL：addMaintenace.do
参数：
报修单系统编号：  MR_GDBH
当前用户名：		USERNAME
当前用户ID ：		USERID
维修描述：			MR_WXBZ
所属编码：			SSBM
*/
#define AddMaintenace_URL @"addMaintenace.do"




/*
受理中处理工单（完成）
URL：appfinishWork.do
参数：
报修单系统编号：  MR_GDBH
当前用户名：		USERNAME
当前用户ID ：		USERID
维修描述：			MR_WXBZ
所属编码：			SSBM
*/
#define AppfinishWork_URL @"appfinishWork.do"


/*
受理工单已完成列表
URL：appFinishList.do
参数：
所属编码：SSBM
返回值：
工单系统编号	： SYSID
工单编号 		： ITEMID
报修人员：         WD_KHMC
事发地址           WD_WYDZ
报修内容           WD_BXNR
紧急程度           WD_JJCD
是否收费           WD_SFSF
费用               WD_FY
报修电话           WD_BXDH
报修标题           WD_BXBT
报修单系统编号     WD_BYE
工单生成时间       SYSDATE
*/
#define AppFinishList_URL @"appFinishList.do"

/*--------------报修处理----------------*/





/*--------------装修申报----------------*/

/*
装修上传文件列表
URL：
appGetRenovation.do
参数：
所属编码： ssbm
用户编号： userid
返回值:
Map<String, Object>:
上传文件名称：name
数据格式：
成功：{ret=1000, msg=success, data=[{name=装修承包商资料}, {name=监理公司资料}]}
*/
#define AppGetRenovation_URL @"appGetRenovation.do"


/*
装修申报待提交列表
URL：
appGetRenovationList.do
参数：
所属编码:	ssbm
用户编号:	userid
返回值：
Data 系统ID:		SYSID；
客户名称：	DEC_KHMC;
单元名称：	DEC_DYMC;
施工名称：	DEC_SGMC;
位置面积：	DEC_WZMJ;
客户联系：	DEC_KHLX;
联系电话：	DEC_LXDH;
内容描述：	DEC_NRMS;
施工单位：	DEC_SGDW;
单位电话：	DEC_DWDH;
现场负责人：DEC_XCFZR;
现场联系人电话：DEC_XCLXDH;
施工人数：	DEC_SGRS;
进场日期：	DEC_JCRQ;
预计完成时间：DEC_YJWCSJ;
延长期限：	DEC_YCQX;
附件：		DEC_FUJIAN;
附件地址：	DEC_FUJIAN_URL;
附件名称：	DEC_FUJIAN_NAME;
添加时间：	SYSDATE;
用户名称：	USERNAME;
成功：{ret=1000, msg=success, data=[{}, {}]}
 */
#define AppGetRenovationList_URL @"appGetRenovationList.do"

/*
装修申报已提交列表
URL:
appGetRenovationSubmitted.do
参数：
所属编码：ssbm
用户编号：userid
返回值：
Data    系统ID:		SYSID；
客户名称：	DEC_KHMC;
单元名称：	DEC_DYMC;
施工名称：	DEC_SGMC;
位置面积：	DEC_WZMJ;
客户联系：	DEC_KHLX;
联系电话：	DEC_LXDH;
内容描述：	DEC_NRMS;
施工单位：	DEC_SGDW;
单位电话：	DEC_DWDH;
现场负责人：DEC_XCFZR;
现场联系人电话：DEC_XCLXDH;
施工人数：	DEC_SGRS;
进场日期：	DEC_JCRQ;
预计完成时间：DEC_YJWCSJ;
延长期限：	DEC_YCQX;
附件：		DEC_FUJIAN;
附件地址：	DEC_FUJIAN_URL;
附件名称：	DEC_FUJIAN_NAME;
添加时间：	SYSDATE;
用户名称：	USERNAME;
成功：{ret=1000, msg=success, data=[{}, {}]}
 */
#define AppGetRenovationSubmitted_URL @"appGetRenovationSubmitted.do"

/*
 装修申报待清除列表
 URL:
 appDeleteList.do
 参数：
 所属编码：ssbm
 用户编号：userid
 返回值：
 Data    系统ID:		SYSID；
 客户名称：	DEC_KHMC;
 单元名称：	DEC_DYMC;
 施工名称：	DEC_SGMC;
 位置面积：	DEC_WZMJ;
 客户联系：	DEC_KHLX;
 联系电话：	DEC_LXDH;
 内容描述：	DEC_NRMS;
 施工单位：	DEC_SGDW;
 单位电话：	DEC_DWDH;
 现场负责人：DEC_XCFZR;
 现场联系人电话：DEC_XCLXDH;
 施工人数：	DEC_SGRS;
 进场日期：	DEC_JCRQ;
 预计完成时间：DEC_YJWCSJ;
 延长期限：	DEC_YCQX;
 附件：		DEC_FUJIAN;
 附件地址：	DEC_FUJIAN_URL;
 附件名称：	DEC_FUJIAN_NAME;
 添加时间：	SYSDATE;
 用户名称：	USERNAME;
 成功：{ret=1000, msg=success, data=[{}, {}]}
*/
#define AppDeleteList_URL @"appDeleteList.do"


/*
装修申报待审核列表
URL：appDshList.do
参数：
所属编码：ssbm
用户编号：userid
返回值：
Data    系统ID:		SYSID；
客户名称：	DEC_KHMC;
单元名称：	DEC_DYMC;
施工名称：	DEC_SGMC;
位置面积：	DEC_WZMJ;
客户联系：	DEC_KHLX;
联系电话：	DEC_LXDH;
内容描述：	DEC_NRMS;
施工单位：	DEC_SGDW;
单位电话：	DEC_DWDH;
现场负责人：DEC_XCFZR;
现场联系人电话：DEC_XCLXDH;
施工人数：	DEC_SGRS;
进场日期：	DEC_JCRQ;
预计完成时间：DEC_YJWCSJ;
延长期限：	DEC_YCQX;
附件：		DEC_FUJIAN;
附件地址：	DEC_FUJIAN_URL;
附件名称：	DEC_FUJIAN_NAME;
添加时间：	SYSDATE;
用户名称：	USERNAME;
成功：{ret=1000, msg=success, data=[{}, {}]}
 */
#define AppDshList_URL @"appDshList.do"





/*
装修申报已审核列表
URL：
appYshList.do
参数：
所属编码：ssbm
用户编号：userid
返回值：
Data    系统ID:		SYSID；
客户名称：	DEC_KHMC;
单元名称：	DEC_DYMC;
施工名称：	DEC_SGMC;
位置面积：	DEC_WZMJ;
客户联系：	DEC_KHLX;
联系电话：	DEC_LXDH;
内容描述：	DEC_NRMS;
施工单位：	DEC_SGDW;
单位电话：	DEC_DWDH;
现场负责人：DEC_XCFZR;
现场联系人电话：DEC_XCLXDH;
施工人数：	DEC_SGRS;
进场日期：	DEC_JCRQ;
预计完成时间：DEC_YJWCSJ;
延长期限：	DEC_YCQX;
附件：		DEC_FUJIAN;
附件地址：	DEC_FUJIAN_URL;
附件名称：	DEC_FUJIAN_NAME;
添加时间：	SYSDATE;
用户名称：	USERNAME;
成功：{ret=1000, msg=success, data=[{}, {}]}
*/
#define AppYshList_URL @"appYshList.do"


/*
装修申报添加
URL：addRenovation.do
参数：
所属编码：  ssbm
用户ID：	userid
当前用户名称：USERNAME
客户名称：	DEC_KHMC;
单元名称：	DEC_DYMC;
施工名称：	DEC_SGMC;
位置面积：	DEC_WZMJ;
客户联系：	DEC_KHLX;
联系电话：	DEC_LXDH;
内容描述：	DEC_NRMS;
施工单位：	DEC_SGDW;
单位电话：	DEC_DWDH;
现场负责人：DEC_XCFZR;
现场联系人电话：DEC_XCLXDH;
施工人数：	DEC_SGRS;
进场日期：	DEC_JCRQ;
预计完成时间：DEC_YJWCSJ;
延长期限：	DEC_YCQX;
附件：		DEC_FUJIAN;
返回值：
成功：{ret=1000, msg=success, data=[{1000}]}
 */
#define AddRenovation_URL @"addRenovation.do"



/*
装修申报提交功能
URL：addRenovationSubmit.do
参数：
系统编号：	SYSID
返回值：
成功：{ret=1000, msg=success, data=[{1000}]}
 */
#define AddRenovationSubmit_URL @"addRenovationSubmit.do"


/*
装修申报删除功能
URL：addRenovationDelete.do
参数：
系统编号：  SYSID
返回值：
成功：{ret=1000, msg=success, data=[{1000}]}
 */
#define AddRenovationDelete_URL @"addRenovationDelete.do"

/*
装修待清除列表彻底删除
URL：appDeleteClean.do
参数：
系统编号：  SYSID
返回值：
成功：{ret=1000, msg=success, data=[{1000}]}
失败：{ret=1001, msg=failure, data=[{1001]}
 */
#define AppDeleteClean_URL @"appDeleteClean.do"


/*
 装修申报待删除列表还原功能
 URL: 	addRestore.do
 参数：
 系统编号：SYSID
 返回值：
 成功：{ret=1000, msg=success, data=[{1000}]}
 失败：{ret=1001, msg=failure, data=[{1001]}
 */
#define AddRestore_URL @"addRestore.do"



/*
装修申报修改功能
URL:		addModify.do
参数：
客户名称：	DEC_KHMC;
单元名称：	DEC_DYMC;
施工名称：	DEC_SGMC;
位置面积：	DEC_WZMJ;
客户联系：	DEC_KHLX;
联系电话：	DEC_LXDH;
内容描述：	DEC_NRMS;
施工单位：	DEC_SGDW;
单位电话：	DEC_DWDH;
现场负责人：DEC_XCFZR;
现场联系人电话：DEC_XCLXDH;
施工人数：	DEC_SGRS;
进场日期：	DEC_JCRQ;
预计完成时间：DEC_YJWCSJ;
延长期限：	DEC_YCQX;
系统编号      SYSID
返回值：
成功：{ret=1000, msg=success, data=[{1000}]}
失败：{ret=1001, msg=failure, data=[{1001]}
*/
#define AddModify_URL @"addModify.do"


/*
装修申报详细列表
URL：appDetailedList.do
参数：
系统编号：  SYSID
返回值：
成功：{ret=1000, msg=success, data=[{}, {}]}
 */
#define AppDetailedList_URL @"appDetailedList.do"


/*
装修申报审核结果列表
URL:  	appCheckList.do
参数：
系统编号 ： SYSID
返回值：
 审核意见：APP_SHJG   1：通过 ，0 ：不通过
 审核人员：APP_SHRY
 审核理由：APP_SHYJ
 审核时间：APP_SHSJ
 审核部门：APP_SHBM

成功：{ret=1000, msg=success, data=[{}, {}]}
失败：{ret=1001, msg=failure, data=[{1001]}
 */
#define AppCheckList_URL @"appCheckList.do"




/*
装修申报审核功能按钮
URL：	addAudit.do
参数：
 审核意见：APP_SHJG    1：通过 ，0 ：不通过
 审核理由：APP_SHYJ
 审核用户名：USERNAME
 系统编号 ： SYSID
 审核部门：APP_SHBM
 当前用户ID ：USERID

返回值：
成功：{ret=1000, msg=success, data=[{1000}]}
失败：{ret=1001, msg=failure, data=[{1001]}
*/
#define AddAudit_URL @"addAudit.do"


/*
装修申报巡检功能
URL:	   addSearch.do
参数：
所属编号 		SSBM
系统编号 		ITEMID
巡检名称 		XJXMMC
巡检时间		XJSJ
巡检周期  		XJZQ
巡检班次 		XJBC
工作内容  		GZNR
巡查施工人数 	XCSGRS
违规事项   		WGSX
巡检人员 		XJRY
巡查负责人员	XCFZRY
当前用户姓名  	USERNAME
当前用户id    	USERID
巡检图片  		imgStr
返回值：
成功：{ret=1000, msg=success, data=[{1000}]}
失败：{ret=1001, msg=failure, data=[{1001]}
*/
#define AddSearch_URL @"addSearch.do"

//装修巡检获取数据
/*
 项目名称  DEC_SGMC
 工作内容  DEC_NRMS
 现场负责人  DEC_XCFZR
 负责人联系电话  DEC_XCLXDH
 */
#define PatrolList_URL @"PatrolList.do"

/*--------------装修申报----------------*/



/*--------------登录注册----------------*/
/*
 登录
 参数
 手机号 account 111111
 密码 pwd 123
 平台类型 platform (0 安卓 1 ios)
 返回值
 data    数据
 msg     状态
 ret     状态码
 */
#define AppLogin_URL @"appLogin.do"



/*
 注册页面URL ：registerPage.do
 注册主程序：
 URL：register.do
 参数：
 */
#define AppRegister_URL @"registerPage.do"

/*--------------登录注册----------------*/



/****************************************/

#endif /* NetPort_h */
