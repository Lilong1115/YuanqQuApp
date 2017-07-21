//
//  LogBaseModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/24.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "LogBaseModel.h"
#import "LogRegister.h"
#import "ComplaintLogRegister.h"

@implementation LogBaseModel

+ (void)getLogModelArrayWithDict:(NSDictionary *)dict {
    
    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    LogRegister *workOrderRegister = [[LogRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            NSString *data = (NSString *)response[@"data"];
            
            //json转array
            NSArray *arrayData = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [arrayData enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                LogBaseModel *model = [LogBaseModel mj_objectWithKeyValues:dict];
                
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppLogListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}

+ (void)getComplaintLogModelArrayWithDict:(NSDictionary *)dict {
    
    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    ComplaintLogRegister *workOrderRegister = [[ComplaintLogRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            NSString *data = (NSString *)response[@"data"];
            
            //json转array
            NSArray *arrayData = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [arrayData enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                LogBaseModel *model = [LogBaseModel mj_objectWithKeyValues:dict];
                
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppLogListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}


/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"content": @"LogModel"
              };
}

@end
