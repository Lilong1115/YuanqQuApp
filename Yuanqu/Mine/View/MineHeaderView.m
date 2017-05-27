//
//  MineHeaderView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//
//我的头视图
#import "MineHeaderView.h"

@interface MineHeaderView()

//头像
@property (nonatomic, weak) UIImageView *iconView;
//用户名
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}
    
- (void)setupUI {

    self.backgroundColor = [UIColor redColor];
    
    //头像
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.backgroundColor = [UIColor greenColor];
    [self addSubview:iconView];
    self.iconView = iconView;
    iconView.layer.cornerRadius = 40;
    iconView.layer.masksToBounds = YES;
    iconView.layer.borderWidth = 5;
    iconView.layer.borderColor = [UIColor blueColor].CGColor;
    
    //用户名
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"123";
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //布局
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(iconView.mas_width);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(iconView.mas_bottom).mas_offset(10);
    }];
}

@end
