//
//  GuaranteeEstimateController.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuaranteeListModel;

@interface GuaranteeEstimateController : UIViewController

//navTitle
@property (nonatomic, copy) NSString *navTitle;

//model
@property (nonatomic, strong) GuaranteeListModel *model;

@end
