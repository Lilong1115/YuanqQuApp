//
//  CycleRegister.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "CycleRegister.h"

@implementation CycleRegister

- (NSString *)requestUrl {
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return HomeCycleView_URL;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

@end
