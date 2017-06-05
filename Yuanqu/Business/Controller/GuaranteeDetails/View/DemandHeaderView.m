//
//  DemandHeaderView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//查询头视图
#import "DemandHeaderView.h"

@interface DemandHeaderView()

//内容
@property (nonatomic, weak) UILabel *contextLabel;
//内容按钮
@property (nonatomic, weak) UIButton *contentButton;
//白线
@property (nonatomic, weak) UIView *whiteView;

@end

@implementation DemandHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = RandomColor;
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //内容
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"进度查询";
    contentLabel.textColor = [UIColor whiteColor];
//    contentLabel.backgroundColor = RandomColor;
    [self addSubview:contentLabel];
    self.contextLabel = contentLabel;
    
    //内容按钮
    UIButton *contentButton = [[UIButton alloc]init];
    [contentButton setTitle:@"我要投诉" forState:UIControlStateNormal];
    [contentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [contentButton setBackgroundColor:RandomColor];
    [self addSubview:contentButton];
    self.contentButton = contentButton;
    [contentButton addTarget:self action:@selector(clickFunctionButton) forControlEvents:UIControlEventTouchUpInside];
    
    //白竖线
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    self.whiteView = whiteView;
    
    //布局
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 8, 0, 0));
    }];
    [contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(100);
    }];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.trailing.mas_equalTo(contentButton.mas_leading);
        make.width.mas_equalTo(8);
    }];
    
}


//点击功能按钮
- (void)clickFunctionButton {

    if (self.clickFunctionBlock) {
        self.clickFunctionBlock(self.idx);
    }
}

//是否隐藏按钮
- (void)setIsHidden:(BOOL)isHidden {

    _isHidden = isHidden;
    self.contentButton.hidden = isHidden;
    self.whiteView.hidden = isHidden;
}

//设置标题
- (void)setTitle:(NSString *)title {

    _title = title;
    self.contextLabel.text = title;
}

//设置按钮
- (void)setButtonStr:(NSString *)buttonStr {

    _buttonStr = buttonStr;
    [self.contentButton setTitle:buttonStr forState:UIControlStateNormal];
}

//设置背景颜色
- (void)setGroundColor:(UIColor *)groundColor {

    _groundColor = groundColor;
    self.backgroundColor = groundColor;
    self.contentButton.backgroundColor = groundColor;
}

@end
