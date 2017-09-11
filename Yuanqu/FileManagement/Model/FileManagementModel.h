//
//  FileManagementModel.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileManagementModel : NSObject

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *filePath;

//获取沙河文件
+ (NSArray *)getFiles;

@end
