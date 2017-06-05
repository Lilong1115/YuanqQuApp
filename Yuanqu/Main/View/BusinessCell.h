//
//  BusinessCell.h
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeModel;

#pragma mark --宏定义
//业务列数
#define BusinessColumns 4

@interface BusinessCell : UICollectionViewCell

@property (nonatomic, strong) HomeModel *model;

@end
