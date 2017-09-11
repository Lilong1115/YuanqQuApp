//
//  PhotoSelectView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PhotoSelectView : UICollectionView

//图片相册实例
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@property (nonatomic, copy) void(^selectedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void(^clickSelectBlock)(NSIndexPath *indexPath);

@end
