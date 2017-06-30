//
//  DistributionDetailsCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DistributionTitleModel;

@interface DistributionDetailsCell : UITableViewCell

@property (nonatomic, strong) DistributionTitleModel *titleModel;

//内容
@property (nonatomic, copy) NSString *content;

//选择接收人员
@property (nonatomic, copy) void(^receivePersonBlock)();

//接收人员Str
@property (nonatomic, copy) NSString *receivePersonStr;

@end
