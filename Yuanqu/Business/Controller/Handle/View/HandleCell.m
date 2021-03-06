//
//  HandleCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

//处理cell
#import "HandleCell.h"
#import "GuaranteeListModel.h"

@interface HandleCell()

//单号
@property (nonatomic, weak) UILabel *orderNumLabel;
//姓名
@property (nonatomic, weak) UILabel *nameLabel;
//手机
@property (nonatomic, weak) UILabel *phoneLabel;
//标题
@property (nonatomic, weak) UILabel *titleLabel;
//地址
@property (nonatomic, weak) UILabel *addressLabel;
//时间
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation HandleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
    
}

//设置布局
- (void)setupUI {
    
    //蓝色视图条
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor colorWithHexString:@"#b0def5"];
    [self.contentView addSubview:blueView];
    
    UILabel *orderNum = [self creatLabelWithTitle:@"单  号:" titleColor:[UIColor blackColor]];
    UILabel *name = [self creatLabelWithTitle:@"姓  名:" titleColor:[UIColor blackColor]];
    UILabel *phone = [self creatLabelWithTitle:@"手  机:" titleColor:[UIColor blackColor]];
    UILabel *title = [self creatLabelWithTitle:@"标  题:" titleColor:[UIColor blackColor]];
    UILabel *address = [self creatLabelWithTitle:@"地  址:" titleColor:[UIColor blackColor]];
    UILabel *time = [self creatLabelWithTitle:@"时  间:" titleColor:[UIColor blackColor]];
    
    UILabel *orderNumLabel = [self creatLabelWithTitle:@"" titleColor:[UIColor grayColor]];
    self.orderNumLabel = orderNumLabel;
    UILabel *nameLabel = [self creatLabelWithTitle:@"" titleColor:[UIColor grayColor]];
    self.nameLabel = nameLabel;
    UILabel *phoneLabel = [self creatLabelWithTitle:@"" titleColor:[UIColor grayColor]];
    self.phoneLabel = phoneLabel;
    UILabel *titleLabel = [self creatLabelWithTitle:@"" titleColor:[UIColor grayColor]];
    self.titleLabel = titleLabel;
    UILabel *addressLabel = [self creatLabelWithTitle:@"" titleColor:[UIColor grayColor]];
    self.addressLabel = addressLabel;
    UILabel *timeLabel = [self creatLabelWithTitle:@"" titleColor:[UIColor grayColor]];
    timeLabel.numberOfLines = 0;
    self.timeLabel = timeLabel;
    
    //详情
    UIButton *detailsButton = [[UIButton alloc]init];
    [detailsButton setTitle:@"详情" forState:UIControlStateNormal];
    [detailsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [detailsButton setBackgroundColor:[UIColor colorWithHexString:@"#4491fa"]];
    [self.contentView addSubview:detailsButton];
    [detailsButton addTarget:self action:@selector(clickDetailsButton) forControlEvents:UIControlEventTouchUpInside];
    
    //灰色下划线
    UIView *grayView = [[UIView alloc]init];
    grayView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:grayView];
    
    //布局
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentView).mas_offset(8);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.height.mas_equalTo(5);
    }];
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(blueView);
        make.top.mas_equalTo(blueView.mas_bottom).mas_offset(8);
    }];
    [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(orderNum);
        make.leading.mas_equalTo(orderNum.mas_trailing).mas_offset(8);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(orderNum);
        make.top.mas_equalTo(orderNum.mas_bottom).mas_offset(8);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(name);
        make.leading.mas_equalTo(name.mas_trailing).mas_offset(8);
    }];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(name);
        make.top.mas_equalTo(name.mas_bottom).mas_offset(8);
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phone);
        make.leading.mas_equalTo(phone.mas_trailing).mas_offset(8);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(phone);
        make.top.mas_equalTo(phone.mas_bottom).mas_offset(8);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(title);
        make.leading.mas_equalTo(title.mas_trailing).mas_offset(8);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(title);
        make.top.mas_equalTo(title.mas_bottom).mas_offset(8);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(address);
        make.leading.mas_equalTo(address.mas_trailing).mas_offset(8);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_centerX).mas_offset(20);
        make.top.mas_equalTo(orderNum);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(time);
        make.leading.mas_equalTo(time.mas_trailing).mas_offset(8);
        make.trailing.mas_equalTo(self.contentView).mas_equalTo(-8);
    }];
    [detailsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
        make.top.mas_equalTo(address.mas_bottom).mas_offset(8);
        make.width.mas_equalTo(100);
    }];
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.mas_equalTo(detailsButton);
        make.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.height.mas_equalTo(1);
    }];
}

//详情按钮
- (void)clickDetailsButton {
    
    if (self.clickDetailsBlock != nil) {
        self.clickDetailsBlock();
    }
}

//创建label
- (UILabel *)creatLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = titleColor;
    label.text = title;
    [self.contentView addSubview:label];
    return label;
}


-(void)setModel:(GuaranteeListModel *)model {

    _model = model;
    self.orderNumLabel.text = model.itemid;
    self.nameLabel.text = model.rd_BXXM;
    self.phoneLabel.text = model.rd_BXDH;
    self.titleLabel.text = model.rd_BXBT;
    self.addressLabel.text = model.rd_SFZB;
    self.timeLabel.text = model.sysdate;
    
}

//计算高度
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 0;
//    totalHeight += [self.titleLabel sizeThatFits:size].height;
//    totalHeight += [self.blueView sizeThatFits:size].height;
//    totalHeight += [self.nameLabel sizeThatFits:size].height;
//    totalHeight += [self.timeLabel sizeThatFits:size].height;
//    totalHeight += [self.contentLabel sizeThatFits:size].height;
//    totalHeight += [self.grayView sizeThatFits:size].height;
//    totalHeight += [self.moreButton sizeThatFits:size].height;
//    totalHeight += 8 + 8 + 20 + 20 + 20 + 8 + 8; // margins
    return CGSizeMake(size.width, totalHeight);
}

@end
