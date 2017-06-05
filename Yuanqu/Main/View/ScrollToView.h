//
//  ScrollToView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollToView : UICollectionView

//滚动回调
@property (nonatomic, copy) void(^scrollToViewBlock)(NSIndexPath *indexPath);

//内容视图
@property (nonatomic, copy) NSArray<UIView *> *contentArray;

@end
