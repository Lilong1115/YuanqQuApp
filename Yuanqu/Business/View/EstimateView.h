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

@end