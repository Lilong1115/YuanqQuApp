//
//  AuditDecorateController.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/7.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DecorateModel;

@interface AuditDecorateController : UITableViewController

@property (nonatomic, strong) DecorateModel *model;

@property (nonatomic, assign) int listType;

@end
