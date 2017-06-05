//
//  ScrollToSwitchView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//滚动选择视图
#import "ScrollToSwitchView.h"

static NSString * const kScrollToSwitchCellID = @"kScrollToSwitchCellID";

@interface ScrollToSwitchView()<UICollectionViewDelegate, UICollectionViewDataSource>

//视图
@property (nonatomic, weak) UICollectionView *collectionView;
//flowlayout
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
//选中cell
@property (nonatomic, strong) ScrollToSwitchCell *selectedCell;


@end

@implementation ScrollToSwitchView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //item大小
    flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    //设置间距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    //设置水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.flowLayout = flowLayout;
    
    //内容区
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, self.bounds.size.height) collectionViewLayout:flowLayout];
    //代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    //取消滚动条和弹簧
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    
    collectionView.backgroundColor = [UIColor whiteColor];
    
    //注册
    [collectionView registerClass:[ScrollToSwitchCell class] forCellWithReuseIdentifier:kScrollToSwitchCellID];
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
}
    
#pragma mark --dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.contentArray.count;
}
  
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ScrollToSwitchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kScrollToSwitchCellID forIndexPath:indexPath];
    
    //记录第一个选中
    if (indexPath.item == 0) {
        self.selectedCell = cell;
        self.selectedCell.isSelected = YES;
    }
    
    cell.content = self.contentArray[indexPath.item];
    
    return cell;
}

#pragma mark --delegate
//设置选中状态
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    ScrollToSwitchCell *cell = (ScrollToSwitchCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.selectedCell.isSelected = NO;
    cell.isSelected = YES;
    self.selectedCell = cell;
    
    //滚动回调
    if (self.scrollToViewBlock != nil) {
        self.scrollToViewBlock(indexPath);
    }
}

//设置内容
- (void)setContentArray:(NSArray *)contentArray {

    _contentArray = contentArray;
    //item大小
    self.flowLayout.itemSize = CGSizeMake(self.frame.size.width / contentArray.count, self.frame.size.height);
    
    [self.collectionView reloadData];
}

//滚动到indexPath位置
- (void)scrollToViewWithIndexPath:(NSIndexPath *)indexPath {

    //获取当前cell
    ScrollToSwitchCell *cell = (ScrollToSwitchCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    self.selectedCell.isSelected = NO;
    cell.isSelected = YES;
    self.selectedCell = cell;
}
    
@end



#pragma mark --cell
@interface ScrollToSwitchCell()
    
//内容
@property (nonatomic, weak) UILabel *contentLabel;
//选择红线
@property (nonatomic, weak) UIView *selectedView;

@end

@implementation ScrollToSwitchCell
    
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}
    
//设置布局
- (void)setupUI {
    
    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"123";
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //选中红线
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:selectedView];
    self.selectedView = selectedView;
    selectedView.hidden = YES;
    
    //布局
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
    [selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).mas_offset(UIEdgeInsetsMake(self.contentView.bounds.size.height - 2, 0, 0, 0));
    }];
}
 
//设置具体内容
- (void)setContent:(NSString *)content {

    _content = content;
    self.contentLabel.text = content;
}
  
//选中状态
- (void)setIsSelected:(BOOL)isSelected {

    _isSelected = isSelected;
    
    self.selectedView.hidden = !isSelected;
    
    if (isSelected == YES) {
        self.contentLabel.font = [UIFont systemFontOfSize:17];
    } else {
        self.contentLabel.font = [UIFont systemFontOfSize:14];
    }
    
}


@end

