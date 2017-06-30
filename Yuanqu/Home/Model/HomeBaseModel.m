//
//  HomeBaseModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "HomeBaseModel.h"
#import "HomeRegister.h"

@implementation HomeBaseModel

+ (void)getHomeBaseModelArray {
    
    //字典
    NSDictionary *parameters = @{
                                 @"ssbm": [UserInfo account].dsoa_user_suoscode
                                 };
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    //转为basic
    NSDictionary *dict = @{@"basic": json};
    
    //请求
    HomeRegister *homeRegister = [[HomeRegister alloc]initWithDict:dict];
    [homeRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)homeRegister.responseObject;

        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            NSString *data = (NSString *)response[@"data"];
            
            //json转array
            NSArray *array = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            
            NSMutableArray *arrayM = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HomeBaseModel *model = [HomeBaseModel mj_objectWithKeyValues:dict];
                [arrayM addObject:model];
            }];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:HomeBusinessNotification object:arrayM.copy];
            }];
        }
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}




/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"content": @"HomeModel"
              };
}


@end
