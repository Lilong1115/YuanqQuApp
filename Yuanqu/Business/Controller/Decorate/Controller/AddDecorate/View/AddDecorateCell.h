//
//  AddDecorateCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddDecorateModel;

//cell类型
typedef NS_ENUM(NSUInteger, DecorateListType) {
    
    //装修申报待提交列表
    RenovationListType = 0,
    //装修申报已提交列表
    RenovationSubmittedType = 1,
    //装修申报待清除列表
    DeleteListType = 2,
    
};

@interface AddDecorateCell : UITableViewCell
@property (nonatomic, strong) AddDecorateModel *model;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *contentStr;

@property (nonatomic, strong) UIImage *image;

//选择文件
@property (nonatomic, copy) void(^clickFile)(NSIndexPath *indexPath);

//标记
@property (nonatomic, strong) NSIndexPath *indexPath;

//装修申报列表类型
@property (nonatomic, assign) DecorateListType listType;

- (void)clear;

@end
