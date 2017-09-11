//
//  DecorateModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DecorateModel : NSObject


//系统ID:		SYSID；
@property (nonatomic, copy) NSString *sysid;
//客户名称：	DEC_KHMC;
@property (nonatomic, copy) NSString *dec_KHMC;
//单元名称：	DEC_DYMC;
@property (nonatomic, copy) NSString *dec_DYMC;
//施工名称：	DEC_SGMC;
@property (nonatomic, copy) NSString *dec_SGMC;
//位置面积：	DEC_WZMJ;
@property (nonatomic, copy) NSString *dec_WZMJ;
//客户联系：	DEC_KHLX;
@property (nonatomic, copy) NSString *dec_KHLX;
//联系电话：	DEC_LXDH;
@property (nonatomic, copy) NSString *dec_LXDH;
//内容描述：	DEC_NRMS;
@property (nonatomic, copy) NSString *dec_NRMS;
//施工单位：	DEC_SGDW;
@property (nonatomic, copy) NSString *dec_SGDW;
//单位电话：	DEC_DWDH;
@property (nonatomic, copy) NSString *dec_DWDH;
//现场负责人：DEC_XCFZR;
@property (nonatomic, copy) NSString *dec_XCFZR;
//现场联系人电话：DEC_XCLXDH;
@property (nonatomic, copy) NSString *dec_XCLXDH;
//施工人数：	DEC_SGRS;
@property (nonatomic, copy) NSString *dec_SGRS;
//进场日期：	DEC_JCRQ;
@property (nonatomic, copy) NSString *dec_JCRQ;
//预计完成时间：DEC_YJWCSJ;
@property (nonatomic, copy) NSString *dec_YJWCSJ;
//延长期限：	DEC_YCQX;
@property (nonatomic, copy) NSString *dec_YCQX;
//附件：		DEC_FUJIAN;
@property (nonatomic, copy) NSString *dec_FUJIAN;
//附件地址：	DEC_FUJIAN_URL;
@property (nonatomic, copy) NSString *dec_FUJIAN_URL;
//附件名称：	DEC_FUJIAN_NAME;
@property (nonatomic, copy) NSString *dec_FUJIAN_NAME;
//添加时间：	SYSDATE;
@property (nonatomic, copy) NSString *sysdate;
//用户名称：	USERNAME;
@property (nonatomic, copy) NSString *username;
//审核状态：  eaasign;    1通过 ；2 不通过 ；3审核中
@property (nonatomic, copy) NSString *eaasign;

//装修申报待提交列表
+ (void)getRenovationList;
//装修申报已提交列表
+ (void)getRenovationSubmitted;
//装修申报待清除列表
+ (void)getDeleteList;
//装修申报待审核列表
+ (void)getDshList;
//装修申报已审核列表
+ (void)getYshList;
//装修申报添加
+ (void)addRenovationWith:(NSDictionary *)dic;
//装修申报修改
+ (void)modifyRenovationWith:(NSDictionary *)dic;

//装修申报提交
- (void)addRenovationSubmit;
//装修申报删除
- (void)addRenovationDelete;
//装修申报待清除彻底删除
- (void)addRenovationClear;
//装修申报待清除还原数据
- (void)addRenovationReduction;


//获取字段名称
+ (NSArray *)getSubmitList;

@end
