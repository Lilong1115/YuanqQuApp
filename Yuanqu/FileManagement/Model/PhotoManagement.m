//
//  PhotoManagement.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PhotoManagement.h"

@implementation PhotoManagement

//+ (void)getOriginalImages
//{
//    // 获得所有的自定义相簿
//    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
//    // 遍历所有的自定义相簿
//    for (PHAssetCollection *assetCollection in assetCollections) {
//        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
//    }
//    
//    // 获得相机胶卷
//    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
//    // 遍历相机胶卷,获取大图
//    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
//}



+ (NSArray *)getThumbnailImagesWithPhotoFile:(PHAssetCollection *)assetCollection
{
    return [self enumerateAssetsInAssetCollection:assetCollection original:NO];
    
    //    // 获得相机胶卷
    //    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    //    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
}



/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
+ (NSArray *)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (PHAsset *asset in assets) {
        
        [arrayM addObject:asset];
    }
    
    return arrayM.copy;
}

//获取图片
+ (NSString *)getPHAssetArrayWithAsset:(PHAsset *)asset original:(BOOL)original {

    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 是否要原图
    CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        //主线程发送通知,更新界面
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:asset.localIdentifier object:result];
            
        }];
        
    }];
    
    return asset.localIdentifier;
 
}

@end
