//
//  GuaranteeListModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/16.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "GuaranteeListModel.h"
#import "GuaranteeListRegister.h"
#import "WorkOrderRegister.h"
#import "RepairSubmitRegister.h"
#import "GuaranteeEstimateRegister.h"
#import "ComplaintsListRegister.h"

@implementation GuaranteeListModel

//获取投诉列表
+ (void)getComplaintsListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"USERID": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    ComplaintsListRegister *guaranteeListRegister = [[ComplaintsListRegister alloc]initWithDict:dict];
    [guaranteeListRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)guaranteeListRegister.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GuaranteeListModel *model = [GuaranteeListModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:ComplaintListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
    
}

+ (void)getGuaranteeListModelArray {
    
    //字典
    NSDictionary *parameters = @{
                                 @"uuid": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    GuaranteeListRegister *guaranteeListRegister = [[GuaranteeListRegister alloc]initWithDict:dict];
    [guaranteeListRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)guaranteeListRegister.responseObject;

        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GuaranteeListModel *model = [GuaranteeListModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppRepairListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}


+ (void)getNoRepairOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    WorkOrderRegister *workOrderRegister = [[WorkOrderRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GuaranteeListModel *model = [GuaranteeListModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppWorkOrderListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
}


//制单提交
+ (void)repairOrderSubmitWithDict:(NSDictionary *)dict {

    
    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    RepairSubmitRegister *workOrderRegister = [[RepairSubmitRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;

        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {

            [ProgressHUD showSuccess:@"制单成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddWorkOrderSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
    
}


//我要确认
+ (void)repairSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    GuaranteeEstimateRegister *workOrderRegister = [[GuaranteeEstimateRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:RepairOrderSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
}

@end
