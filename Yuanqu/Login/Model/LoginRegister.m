//
//  LoginRegister.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/10.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "LoginRegister.h"

@implementation LoginRegister {
    NSString *_username;
    NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
    self = [super init];
    if (self) {
        _username = username;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl {
    // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/iphone/register";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"username": _username,
             @"password": _password
             };
}


@end
