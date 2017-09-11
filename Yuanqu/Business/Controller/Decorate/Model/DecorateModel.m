//
//  DecorateModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DecorateModel.h"
#import "DecorateRequest.h"

@implementation DecorateModel

+ (void)getRenovationList {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userid": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AppGetRenovationList_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        NSLog(@"%@", response);
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                DecorateModel *model = [DecorateModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
                
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppGetRenovationListSuccessNotification object:arrayM.copy];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
    
}


//装修申报已提交列表
+ (void)getRenovationSubmitted {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userid": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AppGetRenovationSubmitted_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        NSLog(@"%@", response);
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                DecorateModel *model = [DecorateModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
                
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppGetRenovationSubmittedSuccessNotification object:arrayM.copy];
            }];
        } else {
            
            [ProgressHUD showError:@"获取失败"];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppGetRenovationSubmittedSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:AppGetRenovationSubmittedSuccessNotification object:nil];
        }];
    }];
    

}
//装修申报待清除列表
+ (void)getDeleteList {

    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userid": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AppDeleteList_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        NSLog(@"%@", response);
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                DecorateModel *model = [DecorateModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
                
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppDeleteListSuccessNotification object:arrayM.copy];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}

//装修申报待审核列表
+ (void)getDshList {
    
    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userid": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AppDshList_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        NSLog(@"%@", response);
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                DecorateModel *model = [DecorateModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
                
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppDshListSuccessNotification object:arrayM.copy];
            }];
        } else {
            
            [ProgressHUD showError:@"获取失败"];
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppDshListSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
        //主线程发送通知,更新界面
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:AppDshListSuccessNotification object:nil];
        }];
    }];
    
}


//装修申报已审核列表
+ (void)getYshList {
    
    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
                                 @"userid": [UserInfo account].dsoa_user_code
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AppYshList_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        NSLog(@"%@", response);
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                DecorateModel *model = [DecorateModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
                
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppYshListSuccessNotification object:arrayM.copy];
            }];
        } else {
            
            [ProgressHUD showError:@"获取失败"];
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppYshListSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
        //主线程发送通知,更新界面
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:AppYshListSuccessNotification object:nil];
        }];
    }];
    
}


//装修申报添加
+ (void)addRenovationWith:(NSDictionary *)dic {

    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:dic];
    dictM[@"userid"] = [UserInfo account].dsoa_user_code;
    dictM[@"ssbm"] = [UserInfo account].dsoa_user_suoscode;
    
    dictM[@"USERNAME"] = [UserInfo account].dsoa_user_name;
    
    NSString *json = [NSString ObjectTojsonString:dictM.copy];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AddRenovation_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddRenovationSuccessNotification object:nil];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}


//装修申报修改
+ (void)modifyRenovationWith:(NSDictionary *)dic {
    
    NSString *json = [NSString ObjectTojsonString:dic];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AddModify_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddModifySuccessNotification object:nil];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}


//装修申报提交
- (void)addRenovationSubmit {

    NSDictionary *dic = @{
                          @"SYSID": self.sysid
                          };
    
    NSString *json = [NSString ObjectTojsonString:dic];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AddRenovationSubmit_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddRenovationSubmitSuccessNotification object:nil];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}
//装修申报删除
- (void)addRenovationDelete {
    
    NSDictionary *dic = @{
                          @"SYSID": self.sysid
                          };

    NSString *json = [NSString ObjectTojsonString:dic];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AddRenovationDelete_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddRenovationDeleteSuccessNotification object:nil];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}

//装修申报待清除彻底删除
- (void)addRenovationClear {

    NSDictionary *dic = @{
                          @"SYSID": self.sysid
                          };
    
    NSString *json = [NSString ObjectTojsonString:dic];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AppDeleteClean_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppDeleteCleanSuccessNotification object:nil];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}

//装修申报待清除还原数据
- (void)addRenovationReduction {
    
    NSDictionary *dic = @{
                          @"SYSID": self.sysid
                          };
    
    NSString *json = [NSString ObjectTojsonString:dic];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AddRestore_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddRestoreSuccessNotification object:nil];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}



//获取字段名称
+ (NSArray *)getSubmitList {

    NSArray *array = @[
//                       客户名称：
                       @"DEC_KHMC",
//                        单元名称：
                       @"DEC_DYMC",
//                        施工名称：
                       @"DEC_SGMC",
//                        位置面积：
                       @"DEC_WZMJ",
//                        客户联系：
                       @"DEC_KHLX",
//                        联系电话：
                       @"DEC_LXDH",
//                        内容描述：
                       @"DEC_NRMS",
//                        施工单位：
                       @"DEC_SGDW",
//                        单位电话：
                       @"DEC_DWDH",
//                        现场负责人：
                       @"DEC_XCFZR",
//                        现场联系人电话：
                       @"DEC_XCLXDH",
//                        施工人数：
                       @"DEC_SGRS",
//                        进场日期：
                       @"DEC_JCRQ",
//                        预计完成时间：
                       @"DEC_YJWCSJ"
                       ];
    
    return array;
    
}


@end
