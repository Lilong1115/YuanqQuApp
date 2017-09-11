//
//  PhotoManagement.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface PhotoManagement : NSObject

//获取缩略图
+ (NSArray *)getThumbnailImagesWithPhotoFile:(PHAssetCollection *)assetCollection;


/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
+ (NSArray *)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original;

//获取图片
+ (NSString *)getPHAssetArrayWithAsset:(PHAsset *)asset original:(BOOL)original;

@end
