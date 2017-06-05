//
//  ScrollToView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//下面滚动视图
#import "ScrollToView.h"

static NSString * const kScrollToViewCellID = @"kScrollToViewCellID";

@interface ScrollToView()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ScrollToView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        //代理
        self.dataSource = self;
        self.delegate = self;
        //注册
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kScrollToViewCellID];
        
        //弹簧
        self.bounces = NO;
        //分页
        self.pagingEnabled = YES;
    }
    
    return self;
}

#pragma mark --dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.contentArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kScrollToViewCellID forIndexPath:indexPath];
    
    //获取view视图,加载到cell上
    UIView *view = self.contentArray[indexPath.item];
    
//    view.frame = cell.contentView.bounds;
    
    [cell.contentView addSubview:view];
    
    cell.backgroundColor = RandomColor;
    
    return cell;
}

#pragma mark --delegate
//回调滚动indexPath
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.scrollToViewBlock != nil) {
        self.scrollToViewBlock([NSIndexPath indexPathForItem:(NSInteger)scrollView.contentOffset.x / ScreenW inSection:0]);
    }
}

@end

