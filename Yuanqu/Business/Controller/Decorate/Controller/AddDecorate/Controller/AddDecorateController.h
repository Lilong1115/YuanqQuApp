//
//  AddDecorateController.h
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DecorateModel;

@interface AddDecorateController : UITableViewController

@property (nonatomic, strong) DecorateModel *model;

@property (nonatomic, assign) int listType;

@end
