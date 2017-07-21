//
//  XHShareView.m
//
//
//  Created by XHTeng on 15/6/29.
//  Copyright (c) 2015年 XHTeng. All rights reserved.
//

#import "XHShareView.h"
#import "UIControl+Blocks.h"

@interface XHShareView()

@property (nonatomic, weak) UIButton *btn1;
@property (nonatomic, weak) UIButton *btn2;
@property (nonatomic, weak) UIButton *btn3;
@property (nonatomic, weak) UIButton *btn4;
@property (nonatomic, weak) UIButton *btn5;
@property (nonatomic, weak) UIButton *btn6;

@end


@implementation XHShareView

-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        float btnHeight = 80;
        UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnHeight, btnHeight)];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"icon_wx_friend"] forState:UIControlStateNormal];
        [btn1 setBackgroundImage:[UIImage imageNamed:@"icon_wx_friend_disabled"] forState:UIControlStateDisabled];
        
        [btn1 addEventHandler:^(id sender) {
            [_delegate XHDidClickShareBtn:SharePyQuan];
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn1];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*0.5-btnHeight*0.5, 0, btnHeight, btnHeight)];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"icon_wx"] forState:UIControlStateNormal];
        [btn2 setBackgroundImage:[UIImage imageNamed:@"icon_wx_disabled"] forState:UIControlStateDisabled];
        [btn2 addEventHandler:^(id sender) {
            [_delegate XHDidClickShareBtn:ShareWeix];
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
        
        UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-btnHeight, 0, btnHeight, btnHeight)];
        [btn3 setBackgroundImage:[UIImage imageNamed:@"icon_copy"] forState:UIControlStateNormal];
        [btn3 addEventHandler:^(id sender) {
            [_delegate XHDidClickShareBtn:ShareMsg];
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn3];
        UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-btnHeight, btnHeight, btnHeight)];
        [btn4 setBackgroundImage:[UIImage imageNamed:@"icon_weibo"] forState:UIControlStateNormal];
        [btn4 setBackgroundImage:[UIImage imageNamed:@"icon_weibo_disabled"] forState:UIControlStateDisabled];
        [btn4 addEventHandler:^(id sender) {
            [_delegate XHDidClickShareBtn:ShareSina];
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn4];
        UIButton *btn5 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width*0.5-btnHeight*0.5, self.frame.size.height-btnHeight, btnHeight, btnHeight)];
        [btn5 setBackgroundImage:[UIImage imageNamed:@"icon_qq"] forState:UIControlStateNormal];
        [btn5 setBackgroundImage:[UIImage imageNamed:@"icon_qq_disabled"] forState:UIControlStateDisabled];
        [btn5 addEventHandler:^(id sender) {
            [_delegate XHDidClickShareBtn:ShareQQ];
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn5];
        UIButton *btn6 = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width-btnHeight, self.frame.size.height-btnHeight, btnHeight, btnHeight)];
        [btn6 setBackgroundImage:[UIImage imageNamed:@"icon_qzone"] forState:UIControlStateNormal];
        [btn6 setBackgroundImage:[UIImage imageNamed:@"icon_qzone_disabled"] forState:UIControlStateDisabled];
        [btn6 addEventHandler:^(id sender) {
            [_delegate XHDidClickShareBtn:ShareQzone];
        } forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn6];
        
        self.btn1 = btn1;
        self.btn2 = btn2;
        self.btn3 = btn3,
        self.btn4 = btn4,
        self.btn5 = btn5;
        self.btn6 = btn6;
    }
    return self;
}


- (void)setDisabledWeixin {

    self.btn1.enabled = NO;
    self.btn2.enabled = NO;
}

- (void)setDisabledSina {
    
    self.btn4.enabled = NO;
}

- (void)setDisabledQQ {
    
    self.btn5.enabled = NO;
    self.btn6.enabled = NO;
}


@end
