//
//  AssignedPersonnelView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignedPersonnelView : UIView

//派发回调
@property (nonatomic, copy) void(^clickDistributedBlock)();
//清除回调
@property (nonatomic, copy) void(^clickRemoveBlock)();
//清空回调
@property (nonatomic, copy) void(^clickEmptyBlock)();

@end
