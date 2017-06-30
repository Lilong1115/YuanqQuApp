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

    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //头像
    UIImageView *iconView = [[UIImageView alloc]init];
//    iconView.backgroundColor = [UIColor greenColor];
    [iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [UserInfo account].dsoa_user_photo]] placeholderImage:[UIImage imageNamed:@"photo"]];
    [self addSubview:iconView];
    self.iconView = iconView;
    iconView.layer.cornerRadius = 40;
    iconView.layer.masksToBounds = YES;
    iconView.layer.borderWidth = 5;
    iconView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //用户名
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = [UserInfo account].dsoa_user_name;
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
