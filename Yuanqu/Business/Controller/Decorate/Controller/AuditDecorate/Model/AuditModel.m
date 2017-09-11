//
//  AuditModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/8.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AuditModel.h"
#import "DecorateRequest.h"

@implementation AuditModel

+ (void)getAuditArrayWithDict:(NSDictionary *)dic {

    NSString *json = [NSString ObjectTojsonString:dic];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AppCheckList_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSArray *data = (NSArray *)response[@"data"];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                AuditModel *model = [AuditModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
                
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AppCheckListSuccessNotification object:arrayM.copy];
            }];
        } else {
            
            [ProgressHUD showError:@"服务器问题"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
}

+ (void)addAuditSubmitWithDict:(NSDictionary *)dic {
    
    NSString *json = [NSString ObjectTojsonString:dic];
    
    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AddAudit_URL];
    
    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)request.responseObject;
        
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddAuditSuccessNotification object:nil];
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
+ (NSArray *)getAuditSubmitList {

    NSArray *array = @[
                       @"APP_SHJG",
                       @"APP_SHYJ",
                       @"APP_SHBM",
                       @"USERNAME",
                       @"USERID",
                       @"SYSID"
                       ];
    
    return array.copy;
}


@end
