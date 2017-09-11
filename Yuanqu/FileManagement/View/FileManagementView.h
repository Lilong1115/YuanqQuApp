//
//  FileManagementView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FileManagementModel;

@interface FileManagementView : UITableView

@property (nonatomic, strong) NSArray *dataArray;

//被选中
@property (nonatomic, copy) void(^selecteBlock)(NSIndexPath *indexPath);

@property (nonatomic, strong) FileManagementModel *selectedModel;

//选中文件
@property (nonatomic, copy) void(^clickSelectBlock)();


@end

@interface FileViewCell : UITableViewCell

//文件模型
@property (nonatomic, strong) FileManagementModel *model;

//选择按钮
@property (nonatomic, copy) void(^selectedBlock)(NSIndexPath *indexPath);

@property (nonatomic, strong) NSIndexPath *indexPath;

//解除选择
- (void)noSelected;

@end
