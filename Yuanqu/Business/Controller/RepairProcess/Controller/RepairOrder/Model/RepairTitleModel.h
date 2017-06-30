//
//  RepairTitleModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepairTitleModel : NSObject

//标题
@property (nonatomic, copy) NSString *title;

+ (NSArray *)getRepairTitleModelArray;

@end
