//
//  HomeCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//首页cell
#import "HomeCell.h"
#import "BusinessCollectionView.h"
#import "BusinessFlowLayout.h"

@interface HomeCell()

//业务视图
@property (nonatomic, weak) BusinessCollectionView *businessView;

@end

@implementation HomeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}
 
//设置布局
- (void)setupUI {

    //flowLayout
    BusinessFlowLayout *flowLayout = [[BusinessFlowLayout alloc]init];
    //业务视图
    BusinessCollectionView *businessView = [[BusinessCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.contentView addSubview:businessView];
    self.businessView = businessView;
    
    //布局
    [businessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
}

@end
