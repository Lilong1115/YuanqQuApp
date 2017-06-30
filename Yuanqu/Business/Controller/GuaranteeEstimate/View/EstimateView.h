//
//  EstimateView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstimateView : UIView

//确认按钮点击回调
@property (nonatomic, copy) void(^comfirmBlock)();

//设置具体内容
@property (nonatomic, copy) NSString *navTitle;

//维修进度评价
@property (nonatomic, copy) NSString *maintenanceStr;
//工作态度评价
@property (nonatomic, copy) NSString *workAttitudeStr;

//评价内容
@property (nonatomic, copy) NSString *content;

@end
