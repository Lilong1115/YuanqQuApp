//
//  GuaranteeDetailsModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/14.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuaranteeDetailsModel : NSObject

//报修姓名
@property (nonatomic, copy) NSString *RD_BXXM;
//报修电话
@property (nonatomic, copy) NSString *RD_BXDH;
//报修标题
@property (nonatomic, copy) NSString *RD_BXBT;
//报修内容
@property (nonatomic, copy) NSString *RD_BXNR;
//报修坐标
@property (nonatomic, copy) NSString *RD_SFZB;
//用户姓名 admin
@property (nonatomic, copy) NSString *USERNAME;
//用户ID 9E8E79216D9A4F8BB696FA4E3499E57
@property (nonatomic, copy) NSString *UUID;
//用户所属编号 01
@property (nonatomic, copy) NSString *SSBM;
//图片
@property (nonatomic, copy) NSString *imgStr;
//所属公司名称
@property (nonatomic, copy) NSString *DEPTNAME;

//上传报修信息
- (void)uploadInformation;

+ (void)uploadComplaintsDataWithDict:(NSDictionary *)dict;


@end

/*
 参数：
 报修姓名：RD_BXXM
 报修电话：RD_BXDH
 报修内容：RD_BXBT
 报修标题：RD_BXNR
 事发坐标：RD_SFZB
 用户姓名：USERNAME
 用户ID：USERID
 用户所属编号：SSBM
 图片：imgStr

 */
