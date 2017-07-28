//
//  GuaranteeDetailsHeaderView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//报修详情头视图
#import "GuaranteeDetailsHeaderView.h"
#import "GuaranteeListModel.h"

@interface GuaranteeDetailsHeaderView()

//单号
@property (nonatomic, weak) UILabel *orderNumLabel;
//时间
@property (nonatomic, weak) UILabel *timeLabel;
//姓名
@property (nonatomic, weak) UILabel *nameLabel;
//手机
@property (nonatomic, weak) UILabel *phoneLabel;
//地址
@property (nonatomic, weak) UILabel *addressLabel;
//标题
@property (nonatomic, weak) UILabel *titleLabel;
//类型
@property (nonatomic, weak) UILabel *typeLabel;
//内容
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation GuaranteeDetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {
    
    //名称
    UILabel *orderNum = [self creatLabelWithTitle:@"单号:" titleColor:[UIColor blackColor]];
    UILabel *time = [self creatLabelWithTitle:@"时间:" titleColor:[UIColor blackColor]];
    UILabel *name = [self creatLabelWithTitle:@"姓名:" titleColor:[UIColor blackColor]];
    UILabel *phone = [self creatLabelWithTitle:@"手机:" titleColor:[UIColor blackColor]];
    UILabel *address = [self creatLabelWithTitle:@"地址:" titleColor:[UIColor blackColor]];
    UILabel *title = [self creatLabelWithTitle:@"标题:" titleColor:[UIColor blackColor]];
    UILabel *content = [self creatLabelWithTitle:@"内容:" titleColor:[UIColor blackColor]];
    
    //内容
    UILabel *orderNumLabel = [self creatLabelWithTitle:@"" titleColor:[UIColor grayColor]];
    self.orderNumLabel = orderNumLabel;
    UILabel *timeLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.timeLabel = timeLabel;
    UILabel *nameLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.nameLabel = nameLabel;
    UILabel *phoneLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.phoneLabel = phoneLabel;
    UILabel *addressLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor]];
    self.addressLabel = addressLabel;
    UILabel *titleLabel = [self creatLabelWithTitle:@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试" titleColor:[UIColor grayColor]];
    self.titleLabel = titleLabel;
    UILabel *contentLabel = [self creatLabelWithTitle:@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试" titleColor:[UIColor grayColor]];
    self.contentLabel = contentLabel;
    
//    //图片
//    UIButton *imageButton = [[UIButton alloc]init];
//    [imageButton setBackgroundColor:[UIColor colorWithHexString:@"#b0def5"]];
//    [imageButton setTitle:@"图片" forState:UIControlStateNormal];
//    [imageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self addSubview:imageButton];
//    [imageButton addTarget:self action:@selector(clickImageButton) forControlEvents:UIControlEventTouchUpInside];
    
    //布局
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.leading.mas_equalTo(self).mas_offset(20);
    }];
    [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNum);
        make.leading.mas_equalTo(orderNum.mas_trailing).mas_offset(8);
//        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(ScreenW - 20 * 2 - 8 - 30);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNumLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(time);
        make.leading.mas_equalTo(time.mas_trailing).mas_offset(8);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(orderNumLabel);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name);
        make.leading.mas_equalTo(name.mas_trailing).mas_offset(8);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(orderNumLabel);
    }];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phone);
        make.leading.mas_equalTo(phone.mas_trailing).mas_offset(8);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(orderNumLabel);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(address);
        make.leading.mas_equalTo(address.mas_trailing).mas_offset(8);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(orderNumLabel);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addressLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title);
        make.leading.mas_equalTo(title.mas_trailing).mas_offset(8);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(orderNumLabel);
    }];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(content);
        make.leading.mas_equalTo(content.mas_trailing).mas_offset(8);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.width.mas_equalTo(orderNumLabel);
    }];
//    [imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.bottom.mas_equalTo(self).mas_offset(-10);
//        make.width.mas_equalTo(80);
//    }];
    
}


- (void)setModel:(GuaranteeListModel *)model {
    
    _model = model;
    if (model.itemid) {
        self.orderNumLabel.text = model.itemid;
        self.timeLabel.text = model.sysdate;
        self.nameLabel.text = model.rd_BXXM;
        self.phoneLabel.text = model.rd_BXDH;
        self.addressLabel.text = model.rd_SFZB,
        self.titleLabel.text = model.rd_BXBT;
        self.contentLabel.text = model.rd_BXNR;
    } else {
        self.orderNumLabel.text = model.ITEMID;
        self.timeLabel.text = model.CJSJ;
        self.nameLabel.text = model.CD_TSXM;
        self.phoneLabel.text = model.CD_LXSJ;
        self.addressLabel.text = model.CD_LXDZ,
        self.titleLabel.text = model.CD_TSBT;
        self.contentLabel.text = model.CD_NRMS;
        
    }
    
}

////点击图片
//- (void)clickImageButton {
//
//}

//创建label
- (UILabel *)creatLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = titleColor;
    label.text = title;
    label.numberOfLines = 0;
    [self addSubview:label];
    return label;
}

@end
