//
//  HandleCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HandleCell : UITableViewCell

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)();

@end
