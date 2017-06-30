//
//  PersonalCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PersonalCell.h"
#import "PersonalModel.h"

@interface PersonalCell()

//标题
@property (nonatomic, weak) UILabel *headLabel;
//内容
@property (nonatomic, weak) UILabel *contentLabel;
//头像
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation PersonalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}


//设置布局
- (void)setupUI {

    //标题
    UILabel *headLabel = [[UILabel alloc]init];
    headLabel.text = @"头像";
//    headLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:headLabel];
    self.headLabel = headLabel;
    
    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"职务";
    contentLabel.numberOfLines = 0;
    contentLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //头像
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.image = [UIImage imageNamed:@"photo"];
    iconView.layer.cornerRadius = (self.contentView.bounds.size.height - 8 - 8) / 2;
    iconView.layer.masksToBounds = YES;
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    
    //布局
    [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView.mas_centerX).mas_offset(-50);
    }];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(8);
        make.trailing.bottom.mas_equalTo(self.contentView).mas_offset(-8);
        make.width.mas_equalTo(iconView.mas_height);
    }];

}


- (void)setModel:(PersonalModel *)model {
    
    _model = model;
    self.headLabel.text = model.head;
    self.contentLabel.text = model.content;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"photo"]];
    
    self.contentLabel.hidden = model.isIcon;
    self.iconView.hidden = !model.isIcon;
}

@end
