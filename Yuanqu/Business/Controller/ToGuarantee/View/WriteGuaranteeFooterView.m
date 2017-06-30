//
//  WriteGuaranteeFooterView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//填写报修底部
#import "WriteGuaranteeFooterView.h"

@interface WriteGuaranteeFooterView()

//图片按钮
@property (nonatomic, weak) UIButton *imageButton;

//label
@property (nonatomic, weak) UILabel *contentLabel;

//提交按钮
@property (nonatomic, weak) UIButton *submitButton;
//清除按钮
@property (nonatomic, weak) UIButton *clearButton;


@end

@implementation WriteGuaranteeFooterView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}

//设置布局
- (void)setupUI {
    
    //报修
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.text = @"报修图片: (非必选项)";
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    

    //图片选择
    UIButton *imageButton = [[UIButton alloc]init];
//    [imageButton setBackgroundColor:[UIColor redColor]];
    [imageButton setBackgroundImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
    [imageButton addTarget:self action:@selector(clickImageButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:imageButton];
    self.imageButton = imageButton;
    
    //提交按钮
    UIButton *submitButton = [self creatButtonWithTitle:@"提交" backgroundColor:[UIColor colorWithHexString:@"#4491fa"] sel:@selector(clickSubmitButton)];
    self.submitButton = submitButton;
    //清除按钮
    UIButton *clearButton = [self creatButtonWithTitle:@"清除" backgroundColor:[UIColor orangeColor] sel:@selector(clickClearButton)];
    self.clearButton = clearButton;
    
    //布局
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(8);
        make.leading.mas_equalTo(self).mas_equalTo(8);
    }];
    [imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).mas_offset(-8);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(imageButton.mas_width);
    }];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.leading.mas_equalTo(self).mas_offset(8);
        make.bottom.mas_equalTo(self).mas_offset(-8);
        make.width.mas_equalTo((ScreenW - 8 * 3) / 2);
    }];
    [clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(submitButton);
        make.trailing.mas_equalTo(self).mas_offset(-8);
        make.width.mas_equalTo((ScreenW - 8 * 3) / 2);
    }];
    
}

//添加报修图片
- (void)clickImageButton {
    
    if (self.selectedImageBlock) {
        self.selectedImageBlock();
    }
}

//提交按钮
- (void)clickSubmitButton {

    if (self.uploadBlock) {
        self.uploadBlock();
    }
    
}
//清除按钮
- (void)clickClearButton {

    if (self.clearBlock) {
        self.clearBlock();
    }
    
}

//创建按钮
- (UIButton *)creatButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor sel:(SEL)sel {

    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

//设置图片
- (void)setGuaranteeImage:(UIImage *)guaranteeImage {

    _guaranteeImage = guaranteeImage;
    
    [self.imageButton setBackgroundImage:guaranteeImage forState:UIControlStateNormal];

    [self.imageButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(160);
        make.width.mas_equalTo(160);
    }];
   
}


- (void)setIsPhoto:(BOOL)isPhoto {

    _isPhoto = isPhoto;
    self.contentLabel.hidden = !isPhoto;
    self.imageButton.hidden = !isPhoto;
    if (isPhoto == NO) {
        
        [self.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).mas_offset(8);
            make.height.mas_equalTo(40);
            make.leading.mas_equalTo(self).mas_offset(8);
            make.width.mas_equalTo((ScreenW - 8 * 3) / 2);
        }];
    }
    
}


//清除图片
- (void)clearImg {

    [self.imageButton setBackgroundImage:[UIImage imageNamed:@"addImg"] forState:UIControlStateNormal];
    [self.imageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).mas_offset(-8);
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(self.imageButton.mas_width);
    }];
    
}

@end
