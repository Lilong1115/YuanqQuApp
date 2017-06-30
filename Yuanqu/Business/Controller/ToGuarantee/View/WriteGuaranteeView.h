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
//清除
@property (nonatomic, copy) void(^clearBlock)();
//提交
@property (nonatomic, copy) void(^uploadBlock)(NSDictionary *dict);
//报修图片
@property (nonatomic, strong) UIImage *guaranteeImage;

@property (nonatomic, assign) BOOL isPhoto;

//清除数据
- (void)clearData;

@end


#pragma mark --cell
@interface WriteGuaranteeCell : UITableViewCell

//模型
@property (nonatomic, strong) GuaranteeModel *guaranteeModel;
//cell输入框内容
@property (nonatomic, copy) NSString *cellStr;

//清除数据
- (void)clearData;

@end
