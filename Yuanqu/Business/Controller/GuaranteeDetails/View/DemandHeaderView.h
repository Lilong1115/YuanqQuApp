//
//  DemandHeaderView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemandHeaderView : UIView

//是否隐藏按钮
@property (nonatomic, assign) BOOL isHidden;
//背景颜色
@property (nonatomic, strong) UIColor *groundColor;
//标题
@property (nonatomic, copy) NSString *title;
//按钮文字
@property (nonatomic, copy) NSString *buttonStr;
//点击按钮回调
@property (nonatomic, copy) void(^clickFunctionBlock)(NSInteger idx);
//标记
@property (nonatomic, assign) NSInteger idx;

@end
