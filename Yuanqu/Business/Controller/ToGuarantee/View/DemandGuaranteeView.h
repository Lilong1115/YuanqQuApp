//
//  DemandGuaranteeView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemandGuaranteeView : UITableView

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)();

@end

#pragma mark --cell
@interface DemandGuaranteeCell : UITableViewCell

//点击详情回调
@property (nonatomic, copy) void(^clickDetailsBlock)();

@end
