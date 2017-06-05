//
//  UITextView+Placeholder.h
//  Yuanqu
//
//  Created by 李龙 on 2017/6/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)

/**
 创建默认状态的占位符TextView
 
 @param placeholder 占位符内容
 @return 初始化结果
 */
+ (UITextView *)creatTextViewWithPlaceholder:(NSString *)placeholder;

@end
