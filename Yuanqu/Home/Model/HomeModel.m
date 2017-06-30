//
//  HomeModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HomeModel.h"
#import "BusinessRegister.h"

@implementation HomeModel

//获取工单
+ (NSArray *)getOrderModelArray {
    NSArray *array = @[
                       @{
                           @"name": @"制定工单",
                           @"icon": @"zdgd",
                           @"isLocal": @1
                           },
                       @{
                           @"name": @"工单分配",
                           @"icon": @"gdfp",
                           @"isLocal": @1
                           },
                       @{
                           @"name": @"受理工单",
                           @"icon": @"slgd",
                           @"isLocal": @1
                           }
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HomeModel *model = [HomeModel mj_objectWithKeyValues:dict];
        [arrayM addObject:model];
        
    }];
    
    return arrayM.copy;

    
}

+ (NSArray *)getHomeModelArray {

    NSArray *array = @[
                       @{
                           @"name": @"报修"
                           },
                       @{
                           @"name": @"报修处理"
                           },
                       @{
                           @"name": @"投诉"
                           },
                       @{
                           @"name": @"投诉处理"
                           },
                       @{
                           @"name": @"租赁"
                           },
                       @{
                           @"name": @"缴费"
                           },
                       @{
                           @"name": @"任务"
                           },
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HomeModel *model = [HomeModel mj_objectWithKeyValues:dict];
        [arrayM addObject:model];
        
    }];
    
    return arrayM.copy;
}


//业务
+ (void)getMenuListModelArray {

    NSDictionary *dict = @{
                           @"userid": [UserInfo account].dsoa_user_code
                           };
    
    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    BusinessRegister *workOrderRegister = [[BusinessRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            NSArray *data = (NSArray *)response[@"data"];
            
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HomeModel *model = [HomeModel mj_objectWithKeyValues:dict];
                
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppShowMenuListNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}


@end
