//
//  GuaranteeDetailsView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuaranteeListModel, LogModel;

@interface GuaranteeDetailsView : UITableView

//是否含有table数据
@property (nonatomic, assign) BOOL isTableData;

//数据数组
@property (nonatomic,copy) NSArray *dataArray;
//我要投诉回调
@property (nonatomic, copy) void(^complaintsBlock)();

//model
@property (nonatomic, strong) GuaranteeListModel *model;

//是否有我要投诉
@property (nonatomic, assign) BOOL isComplaints;

@end


@interface LogCell : UITableViewCell

@property (nonatomic, strong) LogModel *model;

@end
