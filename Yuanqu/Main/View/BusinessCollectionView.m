//
//  BusinessCollectionView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//业务collection
#import "BusinessCollectionView.h"
#import "BusinessCell.h"

static NSString * const kBusinessCellID = @"kBusinessCellID";

@interface BusinessCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation BusinessCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        //取消弹簧
        self.bounces = NO;
        //设置不能被滚动,防止手势冲突
        self.scrollEnabled = NO;
        
        //注册
        [self registerClass:[BusinessCell class] forCellWithReuseIdentifier:kBusinessCellID];
    }
    return self;
}
    

#pragma mark --datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 8;
}
   
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    BusinessCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBusinessCellID forIndexPath:indexPath];
    
//    cell.backgroundColor = RandomColor;
    
    return cell;
}


@end
