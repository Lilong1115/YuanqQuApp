//
//  MineHeaderView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//
//我的头视图
#import "MineHeaderView.h"

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
    
    
    //布局
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(iconView.mas_width);
    }];
}

@end
