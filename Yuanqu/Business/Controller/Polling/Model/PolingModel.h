//
//  PolingModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/17.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PolingModel : NSObject

+ (NSArray *)getSubmitList;

+ (void)submitDataWithDict:(NSDictionary *)dict imgStr:(NSString *)imgStr itemId:(NSString *)itemId;

@end
