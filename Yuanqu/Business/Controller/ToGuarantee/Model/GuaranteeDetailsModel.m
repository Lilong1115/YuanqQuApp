//
//  GuaranteeDetailsModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/14.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "GuaranteeDetailsModel.h"
#import "GuaranteeDetailsRegister.h"
#import "GuaranteeEstimateRegister.h"

@implementation GuaranteeDetailsModel

- (void)uploadInformation {
    
    NSString *imgStr = self.mj_keyValues[@"imgStr"];
    
    [self.mj_keyValues removeObjectForKey:@"imgStr"];
    
    NSString *json = [NSString ObjectTojsonString:self.mj_keyValues];
    
    //转为basic
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"basic"] = json;
    if (imgStr.length > 0) {
        dictM[@"imgStr"] = imgStr;
    } else {
        dictM[@"imgStr"] = @"";
    }

    GuaranteeDetailsRegister *guaranteeDetailsRegister = [[GuaranteeDetailsRegister alloc]initWithDict:dictM.copy];
    
    [guaranteeDetailsRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)guaranteeDetailsRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"报修提交成功"];
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddRepairSuccessNotification object:nil];
            }];
        }
        
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}


+ (void)uploadComplaintsDataWithDict:(NSDictionary *)dict {

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
                [[NSNotificationCenter defaultCenter] postNotificationName:ComplaintsSuccessNotification object:nil];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求错误"];
    }];
}

@end
