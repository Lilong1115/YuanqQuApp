//
//  PhotoSelectCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PhotoSelectCell : UICollectionViewCell


@property (nonatomic, strong) PHAsset *asset;

@property (nonatomic, copy) void(^selectedBlock)(NSIndexPath *indexPath);

@property (nonatomic, strong) NSIndexPath *indexPath;

//解除选择
- (void)noSelected;

@end
