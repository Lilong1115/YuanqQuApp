//
//  HomeHeaderView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//首页头视图
#import "HomeHeaderView.h"

@interface HomeHeaderView()
    
//内容
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RandomColor;
        [self setupUI];
    }
    return self;
}

//设置布局
- (void)setupUI {

    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"123";
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //布局
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).mas_offset(10);
    }];
    
}

@end
