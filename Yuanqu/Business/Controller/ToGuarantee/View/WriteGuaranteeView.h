//
//  WriteGuaranteeView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GuaranteeModel;

@interface WriteGuaranteeView : UITableView

//报修图片回调
@property (nonatomic, copy) void(^selectedImageBlock)();
//报修图片
@property (nonatomic, strong) UIImage *guaranteeImage;

@end


#pragma mark --cell
@interface WriteGuaranteeCell : UITableViewCell

//模型
@property (nonatomic, strong) GuaranteeModel *guaranteeModel;

@end
