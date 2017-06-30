//
//  DistributionDetailsCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DistributionDetailsCell.h"
#import "DistributionTitleModel.h"

@interface DistributionDetailsCell()

//标题
@property (nonatomic, weak) UILabel *titLabel;
//内容
@property (nonatomic, weak) UILabel *contentLabel;

@end

@implementation DistributionDetailsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //标题
    UILabel *titLabel = [[UILabel alloc]init];
    titLabel.text = @"工单编号";
    titLabel.font = [UIFont systemFontOfSize:14];
    titLabel.textAlignment = NSTextAlignmentCenter;
//    titLabel.layer.borderWidth = 1;
//    titLabel.layer.borderColor = [UIColor grayColor].CGColor;
    titLabel.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:titLabel];
    self.titLabel = titLabel;
    
    UIView *boxView = [[UIView alloc]init];
    boxView.layer.borderWidth = 0.5;
    boxView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:boxView];
    
    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"测试";
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.numberOfLines = 0;
//    contentLabel.layer.borderWidth = 1;
//    contentLabel.layer.borderColor = [UIColor grayColor].CGColor;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.top.leading.mas_equalTo(self.contentView).mas_offset(8);
        make.width.mas_equalTo(100);
    }];
    
    [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.top.mas_equalTo(titLabel);
        make.leading.mas_equalTo(titLabel.mas_trailing);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.top.mas_equalTo(titLabel);
        make.leading.mas_equalTo(titLabel.mas_trailing).mas_offset(8);
        make.trailing.mas_equalTo(self.contentView).mas_offset(-8 * 2);
    }];

}


- (void)setTitleModel:(DistributionTitleModel *)titleModel {

    _titleModel = titleModel;
    self.titLabel.text = titleModel.title;
    
    //添加手势
    if ([titleModel.title isEqualToString:@"接收人员"]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
        //可交互
        self.contentLabel.userInteractionEnabled = YES;
        [self.contentLabel addGestureRecognizer:tap];
    }
}

//手势
- (void)clickTap:(UITapGestureRecognizer *)tap {

    if (self.receivePersonBlock) {
        self.receivePersonBlock();
    }
    
}


- (void)setReceivePersonStr:(NSString *)receivePersonStr {

    _receivePersonStr = receivePersonStr;
    self.contentLabel.text = receivePersonStr;

}

- (void)setContent:(NSString *)content {
    
    _content = content;
    self.contentLabel.text = content;
}

@end
