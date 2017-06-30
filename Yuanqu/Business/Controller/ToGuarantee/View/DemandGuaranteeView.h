//
//  DemandGuaranteeView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuaranteeListModel;

@interface DemandGuaranteeView : UITableView

//下拉刷新
@property (nonatomic, copy) void(^refreshBlock)();

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)(NSIndexPath *indexPath);

//数据信息
@property (nonatomic, copy) NSArray *dataArray;

@end

#pragma mark --cell
@interface DemandGuaranteeCell : UITableViewCell

//cellModel
@property (nonatomic, strong) GuaranteeListModel *model;

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)();

@end
