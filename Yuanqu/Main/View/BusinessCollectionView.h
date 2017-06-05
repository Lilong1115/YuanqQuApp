//
//  BusinessCollectionView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCollectionView : UICollectionView

//选中回调
@property (nonatomic, copy) void(^selectedBlock)(NSIndexPath *indexPath);

//填充内容
@property (nonatomic, copy) NSArray *contentArray;

@end