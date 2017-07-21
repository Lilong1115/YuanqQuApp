//
//  RepairOrderModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "RepairOrderModel.h"
#import "NoDistributionRegister.h"
#import "NoAcceptOrderRegister.h"
#import "DistrubitionSubmitRegister.h"
#import "AcceptingOrderRegister.h"
#import "AcceptSubmitRegister.h"
#import "AcceptingSubmitRegister.h"
#import "AccepFinishOrderRegister.h"
#import "AcceptFinishRegister.h"
#import "NoComplaintDistributionRegister.h"
#import "NoComplaintAcceptRegister.h"
#import "ComplaintDistrubitionSubmitRegister.h"
#import "ComplaintAcceptingOrderRegister.h"
#import "ComplaintAcceptFinishOrderRegister.h"
#import "ComplaintAcceptSubmitRegister.h"
#import "ComplaintAcceptingSubmitRegister.h"
#import "ComplaintAcceptFinishRegister.h"

@implementation RepairOrderModel

+ (void)getYesRepairOrderListModelArray {
    
    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    NoDistributionRegister *workOrderRegister = [[NoDistributionRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSLog(@"%@", data);
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepairOrderModel *model = [RepairOrderModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppWorkOrderShowListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
}

//已制定(未分配)投诉单列表
+ (void)getYesComplaintOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    NoComplaintDistributionRegister *workOrderRegister = [[NoComplaintDistributionRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSLog(@"%@", data);
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepairOrderModel *model = [RepairOrderModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppComplainManagementShowListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
}

+ (void)getYesDistributionOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    NoAcceptOrderRegister *workOrderRegister = [[NoAcceptOrderRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSLog(@"%@",data);
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepairOrderModel *model = [RepairOrderModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppWorkAcceptListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
}

//已分配(未受理)投诉单列表
+ (void)getYesComplaintDistributionOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    NoComplaintAcceptRegister *workOrderRegister = [[NoComplaintAcceptRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSLog(@"%@",data);
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepairOrderModel *model = [RepairOrderModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppComplainManagementAcceptListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}


//受理中工单列表
+ (void)getAcceptingOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    AcceptingOrderRegister *workOrderRegister = [[AcceptingOrderRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;

        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepairOrderModel *model = [RepairOrderModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppWorkBeingtListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}

+ (void)getComplaintAcceptingOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    ComplaintAcceptingOrderRegister *workOrderRegister = [[ComplaintAcceptingOrderRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepairOrderModel *model = [RepairOrderModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppComplainManagementBeingtListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}

//受理完成列表
+ (void)getAcceptFinishOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    AccepFinishOrderRegister *workOrderRegister = [[AccepFinishOrderRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepairOrderModel *model = [RepairOrderModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppFinishListSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}

//受理完成投诉列表
+ (void)getComplaintAcceptFinishOrderListModelArray {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userId": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    ComplaintAcceptFinishOrderRegister *workOrderRegister = [[ComplaintAcceptFinishOrderRegister alloc]initWithDict:dict];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepairOrderModel *model = [RepairOrderModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppFinishComplainLogsSuccessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}


//分配工单
+ (void)distributionOrderSubmitWithDict:(NSDictionary *)dict {
    
    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    DistrubitionSubmitRegister *workOrderRegister = [[DistrubitionSubmitRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;

        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"分配成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AllotWorkOrderSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}

//分配投诉单
+ (void)complaintDistributionOrderSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    ComplaintDistrubitionSubmitRegister *workOrderRegister = [[ComplaintDistrubitionSubmitRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"分配成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AllotComplainManagementSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}

//受理工单
+ (void)acceptOrderSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    AcceptSubmitRegister *workOrderRegister = [[AcceptSubmitRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"受理成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddWorkacceptSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}

//受理投诉单
+ (void)complaintAcceptOrderSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    ComplaintAcceptSubmitRegister *workOrderRegister = [[ComplaintAcceptSubmitRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"受理成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddComplainManagementAcceptSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
    
}


//受理中提交工单
+ (void)acceptingOrderSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    AcceptingSubmitRegister *workOrderRegister = [[AcceptingSubmitRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"提交成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddMaintenaceSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}

//受理中提交投诉单
+ (void)complaintAcceptingOrderSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    ComplaintAcceptingSubmitRegister *workOrderRegister = [[ComplaintAcceptingSubmitRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"提交成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddComplainLogsSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}


//受理中完成工单
+ (void)acceptFinishOrderSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    AcceptFinishRegister *workOrderRegister = [[AcceptFinishRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSLog(@"%@", response);
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"受理成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppfinishWorkSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}

//受理中完成投诉单
+ (void)complaintAcceptFinishOrderSubmitWithDict:(NSDictionary *)dict {

    NSString *json = [NSString ObjectTojsonString:dict];
    
    
    //转为basic
    NSDictionary *basic = @{@"basic": json};
    
    //请求
    ComplaintAcceptFinishRegister *workOrderRegister = [[ComplaintAcceptFinishRegister alloc]initWithDict:basic];
    [workOrderRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)workOrderRegister.responseObject;
        
        NSLog(@"%@", response);
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"受理成功"];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppFinishComplainLogsSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
    
}

@end
