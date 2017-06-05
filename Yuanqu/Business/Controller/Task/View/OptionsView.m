//
//  OptionsView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

//选项卡
#import "OptionsView.h"

@interface OptionsView()

//选中按钮
@property (nonatomic, strong) UIButton *selectedButton;

@end

@implementation OptionsView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}


//设置布局
- (void)setupUI {

    //收费
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"收费:";
    [self addSubview:contentLabel];
    
    //是
    UIButton *yesButton = [self creatButtonWithTitle:@"是"];
    //否
    UIButton *noButton = [self creatButtonWithTitle:@"否"];
    
    //布局
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self);
    }];
    [yesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(contentLabel.mas_trailing).mas_offset(10);
        make.centerY.mas_equalTo(contentLabel);
        
    }];
    [noButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(yesButton.mas_trailing).mas_offset(10);
        make.centerY.mas_equalTo(contentLabel);
        
    }];
    
    
}

//创建选项按钮
- (UIButton *)creatButtonWithTitle:(NSString *)title {

    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"location_bank"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"location_hospital"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickYesOrNoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

//是否收费
- (void)clickYesOrNoButton:(UIButton *)sender {

    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    
}


@end
