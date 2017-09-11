//
//  PhotoFileCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PhotoFileCell : UITableViewCell

//图片实例
@property (nonatomic, strong) PHAssetCollection *assetCollection;

@end
