//
//  RepairDetailsCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RepairTitleModel;

@interface RepairDetailsCell : UITableViewCell

//标题模型
@property (nonatomic, strong) RepairTitleModel *titleModel;

//内容
@property (nonatomic, copy) NSString *content;

//是否隐藏
@property (nonatomic, assign) BOOL isHidden;

//获取紧急程度
@property (nonatomic, copy) NSString *degreeStr;

@end
