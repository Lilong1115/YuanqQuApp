//
//  GuaranteeModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TextType) {
    textTypeFiled = 1,
    textTypeView = 2,
};

@interface GuaranteeModel : NSObject

//名称
@property (nonatomic, copy) NSString *name;
//占位符
@property (nonatomic, copy) NSString *placeholder;
//输入框类型
@property (nonatomic, assign) TextType textType;
//键盘类型
@property (nonatomic, assign) NSInteger keyboardType;

//字典转模型,获取数组
+ (NSArray *)getGuaranteeModelArray;

@end
