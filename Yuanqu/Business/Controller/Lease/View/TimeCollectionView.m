//
//  TimeCollectionView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/6.
//  Copyright © 2017年 李龙. All rights reserved.
//

//时间collection
#import "TimeCollectionView.h"

static NSString * const kTimeCollectionCellID = @"kTimeCollectionCellID";

@interface TimeCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation TimeCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //代理
        self.dataSource = self;
        self.delegate = self;
        
        //注册
        [self registerClass:[TimeCollectionCell class] forCellWithReuseIdentifier:kTimeCollectionCellID];
    }
    
    return self;
}

#pragma mark --dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 24;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    TimeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTimeCollectionCellID forIndexPath:indexPath];
    
    cell.timeStr = [NSString stringWithFormat:@"%ld", indexPath.item + 1];
    
    return cell;
}

@end


#pragma mark --cell
@interface TimeCollectionCell()

//时间
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation TimeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //选项框
    UIButton *selectButton = [[UIButton alloc]init];
    [selectButton setBackgroundColor:[UIColor grayColor]];
    [self.contentView addSubview:selectButton];
    [selectButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //时间
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"1";
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //布局
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.width.mas_equalTo(self.contentView.frame.size.width / 3);
        make.height.mas_equalTo(selectButton.mas_width);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selectButton.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
}

//点击选择
- (void)clickSelectButton:(UIButton *)sender {

    if (sender.backgroundColor == [UIColor grayColor]) {
        [sender setBackgroundColor:[UIColor redColor]];
    } else {
        [sender setBackgroundColor:[UIColor grayColor]];
    }
    
    
    
}

//设置时间
- (void)setTimeStr:(NSString *)timeStr {

    _timeStr = timeStr;
    self.timeLabel.text = timeStr;
}

@end
