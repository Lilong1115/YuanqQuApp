//
//  DecorateView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DecorateCell.h"

@interface DecorateView : UITableView

//下拉刷新
@property (nonatomic, copy) void(^refreshBlock)();


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


//数据
@property (nonatomic, strong) NSArray *dataArray;

//cell类型
@property (nonatomic, assign) DecorateListType listType;

@end
