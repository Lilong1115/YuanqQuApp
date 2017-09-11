//
//  PhotoSelectCell.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PhotoSelectCell.h"
#import "PhotoManagement.h"

@interface PhotoSelectCell()

@property (nonatomic, weak) UIImageView *photo;

@property (nonatomic, weak) UIButton *selectButton;

@property (nonatomic, copy) NSString *notificationID;

@end

@implementation PhotoSelectCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    UIImageView *photo = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:photo];
    self.photo = photo;
    
    UIButton *selectButton = [[UIButton alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width - 3 - 20, 3, 20, 20)];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"checkbox_pic_non"] forState:UIControlStateNormal];
    [selectButton setBackgroundImage:[UIImage imageNamed:@"checkbox_pic"] forState:UIControlStateSelected];
    [selectButton addTarget:self action:@selector(clickSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectButton];
    self.selectButton = selectButton;
    
    
}

//选择按钮
- (void)clickSelectButton:(UIButton *)sender {

    sender.selected = !sender.selected;
    
    if (self.selectedBlock) {
        self.selectedBlock(self.indexPath);
    }
    
}

//解除选择
- (void)noSelected {
    
    self.selectButton.selected = NO;
}

- (void)setAsset:(PHAsset *)asset {

    _asset = asset;
    self.notificationID = [PhotoManagement getPHAssetArrayWithAsset:asset original:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setImageNoti:) name:self.notificationID object:nil];
    
}

- (void)setImageNoti:(NSNotification *)noti {
    
    NSLog(@"%@----%@", noti.object, self.photo);
    
    self.photo.image = noti.object;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
