//
//  SuggestionView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//意见箱滚动视图
#import "SuggestionView.h"

static NSString * const kSuggestionCellID = @"kSuggestionCellID";

@interface SuggestionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SuggestionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        //代理
        self.dataSource = self;
        self.delegate = self;
        //注册
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kSuggestionCellID];
    }
    
    return self;
}
    
#pragma mark --dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSuggestionCellID forIndexPath:indexPath];
    
    cell.backgroundColor = RandomColor;
    
    return cell;
}

@end
