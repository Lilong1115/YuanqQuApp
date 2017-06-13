//
//  MessageCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/7.
//  Copyright © 2017年 李龙. All rights reserved.
//

//消息cell
#import "MessageCell.h"

@interface MessageCell()

//title
@property (nonatomic, weak) UILabel *titleLabel;
//蓝色线条
@property (nonatomic, weak) UIView *blueView;
//名称
@property (nonatomic, weak) UILabel *nameLabel;
//时间
@property (nonatomic, weak) UILabel *timeLabel;
//内容
@property (nonatomic, weak) UILabel *contentLabel;
//灰色线条
@property (nonatomic, weak) UIView *grayView;
//查看更多
@property (nonatomic, weak) UIButton *moreButton;


@end

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //title
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"全体通知";
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    //蓝色线条
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:blueView];
    self.blueView = blueView;
    
    //名称
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"北京方向盘";
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //时间
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"2017-02-05 19:04:12";
    timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:timeLabel];
    self.titleLabel = titleLabel;
    
    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"通知\n通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知通知";
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    //灰色线条
    UIView *grayView = [[UIView alloc]init];
    grayView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:grayView];
    self.grayView = grayView;
    
    //查看更多
    UIButton *moreButton = [[UIButton alloc]init];
    [moreButton setTitle:@"查看更多" forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    moreButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:moreButton];
    self.moreButton = moreButton;
    
    //布局
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self.contentView).mas_offset(8);
    }];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(8);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(blueView.mas_bottom).mas_equalTo(20);
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nameLabel);
        make.leading.mas_equalTo(nameLabel.mas_trailing).mas_offset(8);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).mas_offset(20);
        make.leading.mas_equalTo(self.contentView).mas_equalTo(8);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
    }];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel.mas_bottom).mas_offset(20);
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(grayView.mas_bottom).mas_offset(8);
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
    }];
}

//计算高度
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
    totalHeight += [self.titleLabel sizeThatFits:size].height;
    totalHeight += [self.blueView sizeThatFits:size].height;
    totalHeight += [self.nameLabel sizeThatFits:size].height;
    totalHeight += [self.timeLabel sizeThatFits:size].height;
    totalHeight += [self.contentLabel sizeThatFits:size].height;
    totalHeight += [self.grayView sizeThatFits:size].height;
    totalHeight += [self.moreButton sizeThatFits:size].height;
    totalHeight += 8 + 8 + 20 + 20 + 20 + 8 + 8; // margins
    return CGSizeMake(size.width, totalHeight);
}

//设置边距
- (void)setFrame:(CGRect)frame {

    frame.origin.x += 8;
    frame.origin.y += 4;
    frame.size.height -= 8;
    frame.size.width -= 16;
    [super setFrame:frame];
}


@end
