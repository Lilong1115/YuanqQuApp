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
#import "NoComplaintOrderRegister.h"
#import "ComplaintSubmitRegister.h"
#import "AppComplaintsListRegister.h"
#import "ComplaintEstimateRegister.h"

@implementation GuaranteeListModel


//获取我要投诉列表
+ (void)getAppComplaintsListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"uuid": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    AppComplaintsListRegister *guaranteeListRegister = [[AppComplaintsListRegister alloc]initWithDict:dict];
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
                [[NSNotificationCenter defaultCenter] postNotificationName:AppComplainListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
    
}

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
        
        NSLog(@"%@", response);
        
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
        } else {
        
            [ProgressHUD showError:@"获取失败"];
//            //主线程发送通知,更新界面
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [[NSNotificationCenter defaultCenter] postNotificationName:ComplaintListSuccessNotification object:nil];
//            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
//        //主线程发送通知,更新界面
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:ComplaintListSuccessNotification object:nil];
//        }];
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
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
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


//未制定投诉单列表
+ (void)getNoComplaintOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    NoComplaintOrderRegister *workOrderRegister = [[NoComplaintOrderRegister alloc]initWithDict:dict];
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
                [[NSNotificationCenter defaultCenter] postNotificationName:AppComplainManagementListSuccessNotification object:arrayM.copy];
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


//制定投诉单提交
+ (void)complaintOrderSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    ComplaintSubmitRegister *workOrderRegister = [[ComplaintSubmitRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"制单成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddComplainManagementSuccessNotification object:nil];
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


//投诉我要确认
+ (void)complainSubmitWithDict:(NSDictionary *)dict {
    
    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    ComplaintEstimateRegister *workOrderRegister = [[ComplaintEstimateRegister alloc]initWithDict:basic];
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
