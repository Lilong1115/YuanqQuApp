//
//  HomeModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

//名称
@property (nonatomic, copy) NSString *title;

+ (NSArray *)getHomeModelArray;

@end
