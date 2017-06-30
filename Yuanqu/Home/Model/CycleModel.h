//
//  CycleModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CycleModel : NSObject

//图片Id
@property (nonatomic, copy) NSString *sysid;
//图片路径
@property (nonatomic, copy) NSString *ap_SCWJ;

//获取内容
+ (void)getCycleModelArray;

@end
