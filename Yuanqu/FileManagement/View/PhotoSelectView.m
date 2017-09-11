//
//  PhotoSelectView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PhotoSelectView.h"
#import "PhotoManagement.h"
#import "PhotoSelectCell.h"
#import "ImageController.h"

@interface PhotoSelectView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

// 用来存放Cell的唯一标示符
@property (nonatomic, strong) NSMutableDictionary *cellDic;


@end

static NSString * const kPhotoSelectCellID = @"kPhotoSelectCellID";

@implementation PhotoSelectView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 3;
        flowLayout.minimumInteritemSpacing = 3;
        flowLayout.itemSize = CGSizeMake((ScreenW - 3 * 5) / 4, (ScreenW - 3 * 5) / 4);
        self.collectionViewLayout = flowLayout;
        self.bounces = NO;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.cellDic = [[NSMutableDictionary alloc] init];
//        [self registerClass:[PhotoSelectCell class] forCellWithReuseIdentifier:kPhotoSelectCellID];
    }
    
    return self;
}

#pragma mark --dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [PhotoManagement getThumbnailImagesWithPhotoFile:self.assetCollection].count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"Cell%ld%ld", indexPath.section, indexPath.item];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 注册Cell
        [collectionView registerClass:[PhotoSelectCell class]  forCellWithReuseIdentifier:identifier];
    }
    
    PhotoSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.asset = [PhotoManagement getThumbnailImagesWithPhotoFile:self.assetCollection][indexPath.item];
    cell.indexPath = indexPath;
    
    __weak PhotoSelectView *weakSelf = self;
    cell.selectedBlock = ^(NSIndexPath *indexPath) {
        __strong PhotoSelectView *strongSelf = weakSelf;
        
        if (strongSelf.selectedIndexPath == indexPath) {
            
            PhotoSelectCell *cell = (PhotoSelectCell *)[strongSelf cellForItemAtIndexPath:strongSelf.selectedIndexPath];
            
            [cell noSelected];
            
            strongSelf.selectedIndexPath = nil;
            
            if (self.clickSelectBlock) {
                self.clickSelectBlock(strongSelf.selectedIndexPath);
            }
            
            return;
        }
        
        
        PhotoSelectCell *cell = (PhotoSelectCell *)[strongSelf cellForItemAtIndexPath:strongSelf.selectedIndexPath];
        
        [cell noSelected];
        
        strongSelf.selectedIndexPath = indexPath;
        if (self.clickSelectBlock) {
            self.clickSelectBlock(strongSelf.selectedIndexPath);
        }
        
    };
    
    return cell;

}

#pragma mark --delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.selectedBlock) {
        self.selectedBlock(indexPath);
    }
    
}



@end
