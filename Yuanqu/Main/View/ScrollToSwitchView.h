//
//  ScrollToSwitchView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollToSwitchView : UIView

//设置内容
@property (nonatomic, copy) NSArray<NSString *> *contentArray;

//滚动回调
@property (nonatomic, copy) void(^scrollToViewBlock)(NSIndexPath *indexPath);

//滚动到indexPath位置
- (void)scrollToViewWithIndexPath:(NSIndexPath *)indexPath;

@end

#pragma mark --cell
@interface ScrollToSwitchCell : UICollectionViewCell

//内容
@property (nonatomic, copy) NSString *content;

//选中状态
@property (nonatomic, assign) BOOL isSelected;

@end
