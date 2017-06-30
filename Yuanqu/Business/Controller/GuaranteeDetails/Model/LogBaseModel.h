//
//  LogBaseModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/24.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogBaseModel : NSObject

//类型
@property (nonatomic, copy) NSString *type;
//内容
@property (nonatomic, copy) NSArray *content;

+ (void)getLogModelArrayWithDict:(NSDictionary *)dict;

@end
