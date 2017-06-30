//
//  DistributionTitleModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistributionTitleModel : NSObject

//标题
@property (nonatomic, copy) NSString *title;

+ (NSArray *)getDistributionTitleModelArray;

+ (NSArray *)getAcceptTitleModelArray;

@end
