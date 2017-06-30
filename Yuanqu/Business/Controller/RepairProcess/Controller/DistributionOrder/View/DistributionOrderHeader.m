//
//  DistributionOrderHeader.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DistributionOrderHeader.h"

@interface DistributionOrderHeader()

@property (nonatomic, weak) UILabel *label;

@end

@implementation DistributionOrderHeader

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
      
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {

    //灰线
    UIView *grayView = [[UIView alloc]init];
    grayView.backgroundColor = [UIColor grayColor];
    [self addSubview:grayView];
    
    //信息
    UILabel *label = [[UILabel alloc]init];
    label.text = @"工单信息";
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    self.label = label;
    
    //布局
    [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).mas_offset(8);
    }];
}

- (void)setTitle:(NSString *)title {

    _title = title;
    self.label.text = title;
}

@end
