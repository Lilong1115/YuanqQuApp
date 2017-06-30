//
//  RepairOrderDetailsController.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuaranteeListModel, RepairOrderModel;

@interface RepairOrderDetailsController : UITableViewController

//工单数据模型
@property (nonatomic, strong) GuaranteeListModel *repairOrderModel;

//已制定
@property (nonatomic, strong) RepairOrderModel *yesRepairOrderModel;


@end
