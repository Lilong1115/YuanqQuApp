//
//  ReceiveCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReceivePersonModel;

@interface ReceiveCell : UITableViewCell

//model
@property (nonatomic, strong) ReceivePersonModel *model;
//获取选中状态
@property (nonatomic, assign) BOOL isSelected;

@end
