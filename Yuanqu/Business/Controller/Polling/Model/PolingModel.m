//
//  PolingModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/17.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PolingModel.h"
#import "PolingRegister.h"

@implementation PolingModel


+ (void)submitDataWithDict:(NSDictionary *)dict imgStr:(NSString *)imgStr itemId:(NSString *)itemId {
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:dict];
    dictM[@"SSBM"] = [UserInfo account].dsoa_user_suoscode;
    dictM[@"USERNAME"] = [UserInfo account].dsoa_user_name;
    dictM[@"USERID"] = [UserInfo account].dsoa_user_code;
    //FDC34228E1F54B24A36BEB3E6AD0A66A
    dictM[@"ITEMID"] = itemId;
    
    
    NSString *json = [NSString ObjectTojsonString:dictM.copy];
    
    //转为basic
    NSMutableDictionary *dictMM = [NSMutableDictionary dictionary];
    dictMM[@"basic"] = json;
    dictMM[@"imgStr"] = imgStr;
    
    
    PolingRegister *polingRegister = [[PolingRegister alloc]initWithDict:dictMM.copy];
    
    [polingRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)polingRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            
            [ProgressHUD showSuccess:@"提交成功"];
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:AddSearchSuccessNotification object:nil];
            }];
        } else {
            [ProgressHUD showSuccess:@"提交失败"];
        }
        
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
    
}

+ (NSArray *)getSubmitList {

    
    return @[
             //                所属编号 		SSBM
             //                系统编号 		ITEMID
             //                巡检名称 		XJXMMC
             @"XJXMMC",
             //                巡检时间		XJSJ
             @"XJSJ",
             //                巡检周期  		XJZQ
             @"XJZQ",
             //                巡检班次 		XJBC
             @"XJBC",
             //                工作内容  		GZNR
             @"GZNR",
             //                巡查施工人数 	XCSGRS
             @"XCSGRS",
             //                违规事项   		WGSX
             @"WGSX",
             //                巡检人员 		XJRY
             @"XJRY",
             //                巡查负责人员	XCFZRY
             @"XCFZRY",
             @"DEC_XCLXDH"
             //                当前用户姓名  	USERNAME
             //                当前用户id    	USERID
             //                巡检图片  		imgStr
             ];
    
}


@end
