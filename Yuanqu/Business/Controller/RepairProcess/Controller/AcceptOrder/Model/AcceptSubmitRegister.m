//
//  AcceptSubmitRegister.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AcceptSubmitRegister.h"

@implementation AcceptSubmitRegister {
    NSString *_basic;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _basic = dict[@"basic"];
    }
    return self;
}

- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return AddWorkaccept_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"basic": _basic
             };
}


@end