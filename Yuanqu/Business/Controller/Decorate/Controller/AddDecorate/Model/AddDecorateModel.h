//
//  AddDecorateModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

//键盘
typedef NS_ENUM(NSUInteger, AddDecorateKeyboardType) {
    //默认
    DefaultType = 0,
    //数字
    NumberType = 1,
    //日期
    DateType = 2,
    //上传附件
    AccessoryType = 3,
    //选择按钮
    SelectType = 4,
    //选择器
    ChooserType = 5,
};

@interface AddDecorateModel : NSObject

//标题
@property (nonatomic, copy) NSString *title;
//输入法
@property (nonatomic, assign) AddDecorateKeyboardType keyboardType;

//获取数组
+ (NSArray *)getAddDecorateArray;

//获取审核资料
+ (NSArray *)getAuditDecorateArray;

//装修申报巡检
+ (NSArray *)getSearchArray;


@end
