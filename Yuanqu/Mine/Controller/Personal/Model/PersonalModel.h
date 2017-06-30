//
//  PersonalModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalModel : NSObject

//标题
@property (nonatomic, copy) NSString *head;
//内容
@property (nonatomic, copy) NSString *content;
//头像
@property (nonatomic, copy) NSString *icon;
//是否是头像
@property (nonatomic, assign) BOOL isIcon;

//获取数据
+ (NSArray *)getPersonalModelArray;

@end
