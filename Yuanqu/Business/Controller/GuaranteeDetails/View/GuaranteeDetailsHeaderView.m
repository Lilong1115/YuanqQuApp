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
    UILabel *orderNum = [self creatLabelWithTitle:@"单号:" titleColor:[UIColor blackColor] backgroundColor:[UIColor lightGrayColor]];
    orderNum.textAlignment = NSTextAlignmentCenter;
    UILabel *time = [self creatLabelWithTitle:@"时间:" titleColor:[UIColor blackColor] backgroundColor:[UIColor lightGrayColor]];
    time.textAlignment = NSTextAlignmentCenter;
    UILabel *name = [self creatLabelWithTitle:@"姓名:" titleColor:[UIColor blackColor] backgroundColor:[UIColor lightGrayColor]];
    name.textAlignment = NSTextAlignmentCenter;
    UILabel *phone = [self creatLabelWithTitle:@"手机:" titleColor:[UIColor blackColor] backgroundColor:[UIColor lightGrayColor]];
    phone.textAlignment = NSTextAlignmentCenter;
    UILabel *address = [self creatLabelWithTitle:@"地址:" titleColor:[UIColor blackColor] backgroundColor:[UIColor lightGrayColor]];
    address.textAlignment = NSTextAlignmentCenter;
    UILabel *title = [self creatLabelWithTitle:@"标题:" titleColor:[UIColor blackColor] backgroundColor:[UIColor lightGrayColor]];
    title.textAlignment = NSTextAlignmentCenter;
    UILabel *content = [self creatLabelWithTitle:@"内容:" titleColor:[UIColor blackColor] backgroundColor:[UIColor lightGrayColor]];
    content.textAlignment = NSTextAlignmentCenter;
    
    //内容
    UILabel *orderNumLabel = [self creatLabelWithTitle:@"" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor]];
    self.orderNumLabel = orderNumLabel;
    UILabel *timeLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor]];
    self.timeLabel = timeLabel;
    UILabel *nameLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor]];
    self.nameLabel = nameLabel;
    UILabel *phoneLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor]];
    self.phoneLabel = phoneLabel;
    UILabel *addressLabel = [self creatLabelWithTitle:@"测试" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor]];
    self.addressLabel = addressLabel;
    UILabel *titleLabel = [self creatLabelWithTitle:@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor]];
    self.titleLabel = titleLabel;
    UILabel *contentLabel = [self creatLabelWithTitle:@"测试测试测试测试测试测试测试测试测试测试测试测试测试测试" titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor]];
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
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNum);
        make.leading.mas_equalTo(orderNum.mas_trailing);
//        make.trailing.mas_equalTo(self).mas_offset(-20);
//        make.width.mas_equalTo(ScreenW - 20 * 2 - 8 - 30);
        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(orderNum);
    }];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(orderNumLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(time);
        make.leading.mas_equalTo(time.mas_trailing);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(orderNum);
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(name);
        make.leading.mas_equalTo(name.mas_trailing);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(orderNum);
    }];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phone);
        make.leading.mas_equalTo(phone.mas_trailing);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(orderNum);
    }];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(address);
        make.leading.mas_equalTo(address.mas_trailing);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(orderNum);
    }];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addressLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title);
        make.leading.mas_equalTo(title.mas_trailing);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(orderNum);
    }];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
        make.leading.mas_equalTo(orderNum);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(content);
        make.leading.mas_equalTo(content.mas_trailing);
        //        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.trailing.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(orderNum);
    }];
//    [imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.bottom.mas_equalTo(self).mas_offset(-10);
//        make.width.mas_equalTo(80);
//    }];
    
}


- (void)setModel:(GuaranteeListModel *)model {
    
    _model = model;
    if (model.itemid) {
        self.orderNumLabel.text = [self setTwoSpaceWithStr:model.itemid];
        self.timeLabel.text = [self setTwoSpaceWithStr:model.sysdate];
        self.nameLabel.text = [self setTwoSpaceWithStr:model.rd_BXXM];
        self.phoneLabel.text = [self setTwoSpaceWithStr:model.rd_BXDH];
        self.addressLabel.text = [self setTwoSpaceWithStr:model.rd_SFZB];
        self.titleLabel.text = [self setTwoSpaceWithStr:model.rd_BXBT];
        self.contentLabel.text = [self setTwoSpaceWithStr:model.rd_BXNR];
    } else {
        self.orderNumLabel.text = [self setTwoSpaceWithStr:model.ITEMID];
        self.timeLabel.text = [self setTwoSpaceWithStr:model.CJSJ];
        self.nameLabel.text = [self setTwoSpaceWithStr:model.CD_TSXM];
        self.phoneLabel.text = [self setTwoSpaceWithStr:model.CD_LXSJ];
        self.addressLabel.text = [self setTwoSpaceWithStr:model.CD_LXDZ];
        self.titleLabel.text = [self setTwoSpaceWithStr:model.CD_TSBT];
        self.contentLabel.text = [self setTwoSpaceWithStr:model.CD_NRMS];
        
    }
    
}

- (NSString *)setTwoSpaceWithStr:(NSString *)str {

    if (str) {
        return [NSString stringWithFormat:@"  %@", str];
    } else {
        return @"  ";
    }
    
}

////点击图片
//- (void)clickImageButton {
//
//}

//创建label
- (UILabel *)creatLabelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor {
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = titleColor;
    label.text = title;
    label.numberOfLines = 0;
    label.layer.borderWidth = 0.5;
    label.layer.borderColor = [UIColor grayColor].CGColor;
    label.backgroundColor = backgroundColor;
    [self addSubview:label];
    return label;
}

@end
