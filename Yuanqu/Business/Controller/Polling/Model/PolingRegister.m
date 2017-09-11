//
//  PolingRegister.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/17.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PolingRegister.h"

@implementation PolingRegister {
    NSString *_basic;
    NSString *_imgStr;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _basic = dict[@"basic"];
        _imgStr = dict[@"imgStr"];
    }
    return self;
}

- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return AddSearch_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (id)requestArgument {
    return @{
             @"basic": _basic,
             @"imgStr": _imgStr
             };
}

@end
