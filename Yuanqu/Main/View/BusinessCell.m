//
//  BusinessCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//业务cell
#import "BusinessCell.h"

@interface BusinessCell()
    
//图片
@property (nonatomic, weak) UIImageView *iconView;
//text
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation BusinessCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
    
//设置布局
- (void)setupUI {

    //图片
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.image = [UIImage imageNamed:@"star_selecte"];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    //text
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.text = @"123";
    [self.contentView addSubview:textLabel];
    self.textLabel = textLabel;
    
    //布局
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(ScreenW / 4 * 0.5);
        make.height.mas_equalTo(iconView.mas_width);
        make.centerY.mas_equalTo(self.contentView).mas_offset(-20);
    }];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(iconView.mas_bottom).mas_offset(10);
    }];
    
}
    
@end
