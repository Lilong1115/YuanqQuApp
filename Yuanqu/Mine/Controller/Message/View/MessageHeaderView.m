//
//  MessageHeaderView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/7.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "MessageHeaderView.h"

@implementation MessageHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self setupUI];
    }
    return self;
}


- (void)setupUI {

    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"2017-05-08 19:02:02";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor lightGrayColor];
    timeLabel.layer.cornerRadius = 5;
    timeLabel.layer.masksToBounds = YES;
    [self addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
}

@end
