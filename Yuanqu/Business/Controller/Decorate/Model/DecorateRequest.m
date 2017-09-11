//
//  DecorateRequest.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DecorateRequest.h"

@implementation DecorateRequest {
    NSString *_basic;
    NSString *_reqyestURL;
}

- (instancetype)initWithBasic:(NSString *)basic reqyestURL:(NSString *)reqyestURL {
    self = [super init];
    if (self) {
        _basic = basic;
        _reqyestURL = reqyestURL;
    }
    return self;
}

- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return _reqyestURL;
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
