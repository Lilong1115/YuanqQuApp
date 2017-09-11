//
//  PhotoView.h
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface PhotoView : UITableView

@property (nonatomic, strong) PHFetchResult *dataArray;

//被选中
@property (nonatomic, copy) void(^selecteBlock)(NSIndexPath *indexPath);


@end
