//
//  DecorateCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DecorateModel;

//cell类型
typedef NS_ENUM(NSUInteger, DecorateListType) {

    //装修申报待提交列表
    RenovationListType = 0,
    //装修申报已提交列表
    RenovationSubmittedType = 1,
    //装修申报待清除列表
    DeleteListType = 2,
    //装修申报待审核列表
    ToAuditType = 3,
    //装修申报已审核列表
    AuditedType = 4,
    
};

@interface DecorateCell : UITableViewCell

//数据
@property (nonatomic, strong) DecorateModel *model;

//标记
@property (nonatomic, strong) NSIndexPath *indexPath;

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)(NSIndexPath *indexPath);
//点击提交回调
@property (nonatomic, copy) void(^clickSubmitBlock)(NSIndexPath *indexPath);
//点击删除回调
@property (nonatomic, copy) void(^clickDeleteBlock)(NSIndexPath *indexPath);
//点击审核回调
@property (nonatomic, copy) void(^clickAuditBlock)(NSIndexPath *indexPath);
//点击清除回调
@property (nonatomic, copy) void(^clickClearBlock)(NSIndexPath *indexPath);
//点击还原回调
@property (nonatomic, copy) void(^clickReductionBlock)(NSIndexPath *indexPath);


//cell类型
@property (nonatomic, assign) DecorateListType listType;

@end
