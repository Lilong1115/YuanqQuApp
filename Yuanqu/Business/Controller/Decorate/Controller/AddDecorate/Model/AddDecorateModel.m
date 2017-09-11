//
//  AddDecorateModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AddDecorateModel.h"
#import "DecorateRequest.h"

@implementation AddDecorateModel

//获取数组
+ (NSArray *)getAddDecorateArray {

//    //字典
//    NSDictionary *parameters = @{
//                                 @"ssbm": [UserInfo account].dsoa_user_suoscode,
//                                 @"userid": [UserInfo account].dsoa_user_code
//                                 };
//    NSString *json = [NSString ObjectTojsonString:parameters];
//    
//    DecorateRequest *request = [[DecorateRequest alloc]initWithBasic:json reqyestURL:AppGetRenovation_URL];
//    [request startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
//        
//        NSDictionary *response = (NSDictionary *)request.responseObject;
//        
//
//        NSInteger ret = [response[@"ret"] integerValue];
//        if (ret == Success_Code) {
//            NSArray *data = (NSArray *)response[@"data"];

            NSMutableArray *arrayM = [NSMutableArray array];
            
            NSArray *array = @[
                               @{
                                   @"title": @"客户名称:",
                                   @"keyboardType": @0
                                   },
                               @{
                                   @"title": @"单元名称:",
                                   @"keyboardType": @0
                                   },
                               @{
                                   @"title": @"施工名称:",
                                   @"keyboardType": @0
                                   },
                               @{
                                   @"title": @"位置/面积:",
                                   @"keyboardType": @0
                                   },
                               @{
                                   @"title": @"客户联系人:",
                                   @"keyboardType": @0
                                   },
                               @{
                                   @"title": @"联系电话:",
                                   @"keyboardType": @1
                                   },
                               @{
                                   @"title": @"内容概述:",
                                   @"keyboardType": @0
                                   },
                               @{
                                   @"title": @"施工单位:",
                                   @"keyboardType": @0
                                   },
                               @{
                                   @"title": @"单位电话:",
                                   @"keyboardType": @1
                                   },
                               @{
                                   @"title": @"现场负责人:",
                                   @"keyboardType": @0
                                   },
                               @{
                                   @"title": @"联系电话:",
                                   @"keyboardType": @1
                                   },
                               @{
                                   @"title": @"施工人数:",
                                   @"keyboardType": @1
                                   },
                               @{
                                   @"title": @"进场日期:",
                                   @"keyboardType": @2
                                   },
                               @{
                                   @"title": @"完成日期:",
                                   @"keyboardType": @2
                                   }
                               ];
            
            [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                AddDecorateModel *model = [AddDecorateModel mj_objectWithKeyValues:obj];
                [arrayM addObject:model];
            }];

    return arrayM.copy;
//            [data enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                NSDictionary *dic = @{
//                                      @"title": [NSString stringWithFormat:@"%@:", dict[@"name"]],
//                                      @"keyboardType": @3
//                                      };
//                
//                AddDecorateModel *model = [AddDecorateModel mj_objectWithKeyValues:dic];
//                [arrayM addObject:model];
//                
//            }];

//            //主线程发送通知,更新界面
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [[NSNotificationCenter defaultCenter] postNotificationName:AppGetRenovatioSuccessNotification object:arrayM.copy];
//            }];
//        } else {
//        
//            [ProgressHUD showError:@"服务器问题"];
//        }
//        
//    } failure:^(YTKBaseRequest *request) {
//        // 你可以直接在这里使用 self
//        [ProgressHUD showError:@"网络请求失败"];
//    }];
    
}

//获取审核资料
+ (NSArray *)getAuditDecorateArray {

    NSArray *array = @[
                       @{
                           @"title": @"审核意见:",
                           @"keyboardType": @4
                           },
                       @{
                           @"title": @"审核依据:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"审核部门:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"审核人员:",
                           @"keyboardType": @0
                           }
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AddDecorateModel *model = [AddDecorateModel mj_objectWithKeyValues:obj];
        [arrayM addObject:model];
    }];
    
    
    return arrayM.copy;
}


//装修申报巡检
+ (NSArray *)getSearchArray {
    
    NSArray *array = @[
                       @{
                           @"title": @"项目名称:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"巡检时间:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"巡检周期:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"巡检班次:",
                           @"keyboardType": @5
                           },
                       @{
                           @"title": @"工作内容:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"现场施工人数:",
                           @"keyboardType": @1
                           },
                       @{
                           @"title": @"违规事项:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"巡检人员:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"现场负责人员:",
                           @"keyboardType": @0
                           },
                       @{
                           @"title": @"负责人联系电话:",
                           @"keyboardType": @1
                           },
                       @{
                           @"title": @"现场照片:",
                           @"keyboardType": @3
                           }
                       ];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        AddDecorateModel *model = [AddDecorateModel mj_objectWithKeyValues:obj];
        [arrayM addObject:model];
    }];
    
    
    return arrayM.copy;
}



@end
