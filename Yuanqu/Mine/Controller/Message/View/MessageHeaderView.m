//
//  MessageHeaderView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/7.
//  Copyright © 2017年 李龙. All rights reserved.
//

//时间头视图
#import "MessageHeaderView.h"

@interface MessageHeaderView()

//时间
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation MessageHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self setupUI];
    }
    return self;
}

//设置布局
- (void)setupUI {

    //时间
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.text = @"2017-05-08 19:02:02";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor lightGrayColor];
    timeLabel.layer.cornerRadius = 5;
    timeLabel.layer.masksToBounds = YES;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //布局
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
}

@end
