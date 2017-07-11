//
//  ToGuaranteeController.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuaranteeListModel;

@interface ToGuaranteeController : UIViewController

//navTitle
@property (nonatomic, copy) NSString *navTitle;

//不含图片
@property (nonatomic, assign) BOOL isPhoto;

//model
@property (nonatomic, strong) GuaranteeListModel *model;

//是否是我要投诉列表
@property (nonatomic, assign) BOOL isAppComplaints;

@end
