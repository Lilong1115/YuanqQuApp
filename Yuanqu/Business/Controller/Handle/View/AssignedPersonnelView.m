//
//  AssignedPersonnelView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

//指派人员
#import "AssignedPersonnelView.h"

@implementation AssignedPersonnelView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //指派人员
    UILabel *label = [[UILabel alloc]init];
    label.text = @"指派人员";
    [self addSubview:label];
    //派发
    UIButton *distributedButton = [self creatButtonWithTitle:@"派发"];
    [distributedButton addTarget:self action:@selector(cilckDistributedButton) forControlEvents:(UIControlEventTouchUpInside)];
    //清除
    UIButton *removeButton = [self creatButtonWithTitle:@"清除"];
    [removeButton addTarget:self action:@selector(cilckRemoveButton) forControlEvents:(UIControlEventTouchUpInside)];
    //清空
    UIButton *emptyButton = [self creatButtonWithTitle:@"清空"];
    [emptyButton addTarget:self action:@selector(cilckEmptyButton) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:view1];
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:view2];
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:view3];
    
    //布局
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).mas_offset(8);
    }];
    [distributedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(self);
    }];
    [removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(distributedButton.mas_trailing).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(distributedButton);
    }];
    [emptyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(removeButton.mas_trailing).mas_offset(10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(removeButton);
        make.trailing.mas_equalTo(self);
    }];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(distributedButton.mas_leading);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(removeButton.mas_leading);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(emptyButton.mas_leading);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
}

//派发
- (void)cilckDistributedButton {

    if (self.clickDistributedBlock) {
        self.clickDistributedBlock();
    }
    
}

//清除
- (void)cilckRemoveButton {
    if (self.clickRemoveBlock) {
        self.clickRemoveBlock();
    }
    
}

//清空
- (void)cilckEmptyButton {

    if (self.clickEmptyBlock) {
        self.clickEmptyBlock();
    }
}

//创建按钮
- (UIButton *)creatButtonWithTitle:(NSString *)title {

    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setBackgroundColor:[UIColor colorWithHexString:@"#b0def5"]];
    [self addSubview:button];
    
    return button;
}

@end
