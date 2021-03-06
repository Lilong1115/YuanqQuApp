//
//  CycleModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "CycleModel.h"
#import "CycleRegister.h"

@implementation CycleModel

+ (void)getCycleModelArray {

    
    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userid": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    CycleRegister *cycleRegister = [[CycleRegister alloc]initWithDict:dict];
    [cycleRegister startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *response = (NSDictionary *)cycleRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            NSArray *array = response[@"data"];
            
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CycleModel *model = [CycleModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:HomeCycleNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
