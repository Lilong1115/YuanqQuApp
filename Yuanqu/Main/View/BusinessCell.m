//
//  BusinessCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//业务cell
#import "BusinessCell.h"
#import "HomeModel.h"

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
    iconView.image = [UIImage imageNamed:@"lzbf"];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    //text
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.text = @"123";
    textLabel.font = [UIFont systemFontOfSize:14];
    textLabel.textColor = [UIColor colorWithHexString:@"#969397"];
    [self.contentView addSubview:textLabel];
    self.textLabel = textLabel;
    
    //布局
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(ScreenW / BusinessColumns * 0.5);
        make.height.mas_equalTo(iconView.mas_width);
        make.centerY.mas_equalTo(self.contentView).mas_offset(-10);
    }];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(iconView.mas_bottom).mas_offset(2);
    }];
    
}

- (void)setModel:(HomeModel *)model {

    _model = model;
    self.textLabel.text = model.name;
    if (model.isLocal == YES) {
        self.iconView.image = [UIImage imageNamed:model.icon];
    } else {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseUrl, model.icon]] placeholderImage:[UIImage imageNamed:@"photo"]];
    }
    
}

    
@end
