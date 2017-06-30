//
//  WriteGuaranteeFooterView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteGuaranteeFooterView : UIView

//报修图片回调
@property (nonatomic, copy) void(^selectedImageBlock)();

//清除
@property (nonatomic, copy) void(^clearBlock)();

//提交
@property (nonatomic, copy) void(^uploadBlock)();

//报修图片
@property (nonatomic, strong) UIImage *guaranteeImage;

//是否提交图片
@property (nonatomic, assign) BOOL isPhoto;

//清除图片
- (void)clearImg;

@end
