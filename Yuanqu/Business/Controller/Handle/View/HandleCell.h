//
//  HandleCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuaranteeListModel;
@interface HandleCell : UITableViewCell

//model
@property (nonatomic, strong) GuaranteeListModel *model;

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)();

@end
