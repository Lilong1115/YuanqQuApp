//
//  BABar.m
//  ZTRadida
//
//  Created by zhangtong on 16/6/12.
//  Copyright © 2016年 zhangtong. All rights reserved.
//


#import "UserInfo.h"
#import "LoginRegister.h"
#define BABarAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation UserInfo


+ (UserInfo *)shared {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}


+ (void)loginWithPhone:(NSString *)phone password:(NSString *)password {

    //account pwd platform
    NSDictionary *parameters = @{
                                 @"account": phone,
                                 @"pwd": password,
                                 @"platform": @"1"
                                 };
 
    NSString *json = [NSString ObjectTojsonString:parameters];
    
    NSDictionary *dict = @{@"basic": json};
    
    LoginRegister *loginRegister = [[LoginRegister alloc]initWithDict:dict];
    
    [loginRegister startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)loginRegister.responseObject;
        
        NSInteger ret = [response[@"ret"] integerValue];
        
        if (ret == Success_Code) {
            NSDictionary *data = (NSDictionary *)response[@"data"];
            
            [UserInfo saveAccount:[Account accountWithDic:data]];
            
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:AppLoginSuccessNotification object:nil];
                
            }];
            
        } else if (ret == Account_Or_Error_Code) {
        
            [ProgressHUD showError:@"账号或密码不正确"];
        } else if (ret == Failed_Code) {
        
            [ProgressHUD showError:@"登录失败"];
        } else if (ret == Error_Code) {
        
            [ProgressHUD showError:@"登录异常"];
        }
        
    } failure:^(YTKBaseRequest *request) {
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}



//保存账号
+ (void)saveAccount:(Account *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:BABarAccountFile];
    
}
//读取账号
+ (Account *)account
{
    // 取出账号
    Account *account = [NSKeyedUnarchiver unarchiveObjectWithFile:BABarAccountFile];
    
    return account;

}
//删除用户信息
+(void)removeAccount{
    // 文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 从沙河删除
    [fileManager removeItemAtPath:BABarAccountFile error:nil];
}

//销毁账户
+(void)logoutAccount
{
    NSFileManager *fileManeger=[NSFileManager defaultManager];
    if ([fileManeger isDeletableFileAtPath:BABarAccountFile]) {
        [fileManeger removeItemAtPath:BABarAccountFile error:nil];
        
    }    
}



@end
