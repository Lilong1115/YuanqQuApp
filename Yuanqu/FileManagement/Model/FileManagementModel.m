//
//  FileManagementModel.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "FileManagementModel.h"



@implementation FileManagementModel

//获取沙河文件
+ (NSArray *)getFiles {

    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSArray *file = [fileManage subpathsOfDirectoryAtPath: FilesPath error:nil];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    [file enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *dict = @{
                               @"fileName": obj,
                               @"filePath": [FilesPath stringByAppendingPathComponent:obj]
                               };
        
        FileManagementModel *model = [FileManagementModel mj_objectWithKeyValues:dict];
        
        [arrayM addObject:model];
        
    }];
    
    return arrayM.copy;
    
}

@end
