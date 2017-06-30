//
//  DistributionOrderDetailsController.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RepairOrderModel;

@interface DistributionOrderDetailsController : UITableViewController

//model
@property (nonatomic, strong) RepairOrderModel *yesRepairOrderModel;

//navTitle
@property (nonatomic, copy) NSString *navTitle;

@end
