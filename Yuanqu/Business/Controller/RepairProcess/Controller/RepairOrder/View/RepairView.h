//
//  RepairView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuaranteeListModel, RepairOrderModel;

@interface RepairView : UITableView

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)(NSIndexPath *indexPath);

//下拉刷新
@property (nonatomic, copy) void(^refreshBlock)();

//数据信息
@property (nonatomic, copy) NSArray *dataArray;
//标记
@property (nonatomic, assign) NSInteger idx;

@end

#pragma mark --cell
@interface RepairCell : UITableViewCell

//未指定
@property (nonatomic, strong) GuaranteeListModel *model;
//已制定
@property (nonatomic, strong) RepairOrderModel *repairOrderModel;

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)(NSIndexPath *indexPath);
//标记
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
