//
//  HomeModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

//区分标题
typedef NS_ENUM(NSUInteger, HomeType) {
    //大标题
    HeaderType = -1,
    //小标题 H5
    CellType = 0,
    //系统
    SystemType = 5,
};

//名称
@property (nonatomic, copy) NSString *name;
//图标
@property (nonatomic, copy) NSString *icon;
//type
@property (nonatomic, copy) NSString *type;
//url
@property (nonatomic, copy) NSString *url;

//区分是否为本地图片
@property (nonatomic, assign) BOOL isLocal;

//获取工单
+ (NSArray *)getOrderModelArray;

//投诉管理
+ (NSArray *)getComplaintModelArray;

+ (NSArray *)getHomeModelArray;

//业务
+ (void)getMenuListModelArray;

/*
{\"icon\":\"/icon/lzbf.png\",\"name\":\"绿植租摆\",\"type\":\"0\",\"url\":\"PalntRental?dataType=A6BD1F480C61446EBAD7C1A10604F7FD\"}
*/
@end
