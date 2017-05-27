//
//  BusinessFlowLayout.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//flowLayout
#import "BusinessFlowLayout.h"

@implementation BusinessFlowLayout

- (instancetype)init {

    if (self = [super init]) {
        
        //设置间距0
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        
        //格大小
        self.itemSize = CGSizeMake(ScreenW / 4, ScreenW / 4);
    }
    
    return self;
}

@end
