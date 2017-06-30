//
//  AcceptOrderDetailsControllerController.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RepairOrderModel;

@interface AcceptOrderDetailsControllerController : UITableViewController

//model
@property (nonatomic, strong) RepairOrderModel *yesRepairOrderModel;

//navTitle
@property (nonatomic, copy) NSString *navTitle;

//是否完成
@property (nonatomic, assign) BOOL isFinish;

@end
