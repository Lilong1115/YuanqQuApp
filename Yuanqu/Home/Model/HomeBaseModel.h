//
//  HomeBaseModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
{"icon":"/icon/null","name":"办公保障","type":"-1","url":"PalntRental.do?dataType=27BFC9F0564E48B5B845C27B51DB48D4"}
*/
@interface HomeBaseModel : NSObject

//类型
@property (nonatomic, copy) NSString *type;
//内容
@property (nonatomic, copy) NSArray *content;

//获取内容,并发送通知
+ (void)getHomeBaseModelArray;

@end
