//
//  EstimateView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "EstimateView.h"
#import "CJTStarView.h"

#pragma mark --宏定义
//间距
#define Margin 20
//星星高度
#define StarViewHeight 35
//星星分数
#define StarCount 5
//输入框高度
#define ContentTextHeight 150


@interface EstimateView()

//维修进度
@property (nonatomic, weak) UILabel *maintenanceLabel;
//维修进度星星
@property (nonatomic, weak) CJTStarView *maintenanceStarView;
//工作态度
@property (nonatomic, weak) UILabel *workAttitudeLabel;
//工作态度星星
@property (nonatomic, weak) CJTStarView *workAttitudeStarView;

//评价内容
@property (nonatomic, weak) UITextView *contentText;

@end

@implementation EstimateView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //label
    UILabel *estimateLabel = [self creatLabelWithText:@"您对维修工作人员服务进行评价:"];
    UILabel *maintenanceLabel = [self creatLabelWithText:@"维修进度:"];
    self.maintenanceLabel = maintenanceLabel;
    UILabel *workAttitudeLabel = [self creatLabelWithText:@"工作态度:"];
    self.workAttitudeLabel = workAttitudeLabel;
    UILabel *contentLabel = [self creatLabelWithText:@"评价内容:"];
    
    //星星
    CJTStarView *maintenanceStarView = [self creatStarView];
    self.maintenanceStarView = maintenanceStarView;
    CJTStarView *workAttitudeStarView = [self creatStarView];
    self.workAttitudeStarView = workAttitudeStarView;
    
    //评价内容输入框
    UITextView *contentText = [UITextView creatTextViewWithPlaceholder:@""];
    //圆角 边框
    contentText.layer.borderColor = [UIColor grayColor].CGColor;
    contentText.layer.borderWidth = 1;
    contentText.layer.cornerRadius = 5;
    contentText.layer.masksToBounds = YES;
    [self addSubview:contentText];
    self.contentText = contentText;
    
    //确认按钮
    UIButton *confirmButton = [[UIButton alloc]init];
    [confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setBackgroundColor:[UIColor orangeColor]];
    [self addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    
    //布局
    [estimateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self).mas_offset(Margin);
    }];
    [maintenanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(estimateLabel);
        make.top.mas_equalTo(estimateLabel.mas_bottom).mas_offset(Margin);
    }];
    [workAttitudeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(maintenanceLabel);
        make.top.mas_equalTo(maintenanceLabel.mas_bottom).mas_offset(Margin);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(workAttitudeLabel);
        make.top.mas_equalTo(workAttitudeLabel.mas_bottom).mas_offset(Margin);
    }];
    [maintenanceStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(maintenanceLabel);
        make.leading.mas_equalTo(maintenanceLabel.mas_trailing).mas_offset(Margin / 2);
        make.height.mas_equalTo(StarViewHeight);
        make.width.mas_equalTo(StarViewHeight * StarCount);
    }];
    [workAttitudeStarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(workAttitudeLabel);
        make.leading.mas_equalTo(workAttitudeLabel.mas_trailing).mas_offset(Margin / 2);
        make.height.mas_equalTo(StarViewHeight);
        make.width.mas_equalTo(StarViewHeight * StarCount);
    }];
    [contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentLabel).mas_offset(-8);
        make.leading.mas_equalTo(contentLabel.mas_trailing).mas_offset(Margin / 2);
        make.trailing.mas_equalTo(self).mas_offset(-Margin);
        make.height.mas_equalTo(ContentTextHeight);
    }];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(contentText.mas_bottom).mas_offset(Margin);
        make.leading.mas_equalTo(self).mas_offset(Margin);
        make.height.mas_equalTo(50);
    }];
    
}

//确认点击
- (void)clickConfirmButton {

    if (self.comfirmBlock != nil) {
        self.comfirmBlock();
    }
    
}

//创建星星
- (CJTStarView *)creatStarView {

    CJTStarView *starView = [[CJTStarView alloc]initWithFrame:CGRectMake(0, 0, StarViewHeight * StarCount, StarViewHeight) starCount:StarCount];
    //显示半星
    starView.openHalf = YES;
    [self addSubview:starView];
    return starView;
}

//创建label
- (UILabel *)creatLabelWithText:(NSString *)text {

    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textColor = [UIColor grayColor];
    [self addSubview:label];
    return label;
}


@end
