//
//  LeaseDetailsController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/6.
//  Copyright © 2017年 李龙. All rights reserved.
//

//租赁详情
#import "LeaseDetailsController.h"
#import "LeaseDetailsView.h"
#import "TimeCollectionView.h"

#pragma mark --宏
#define LeaseDetailsViewHeight 150
#define SubmitButtonHeight 50

@interface LeaseDetailsController ()

@end

@implementation LeaseDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupLeaseDetailsView];
    [self setupTimeView];
    [self setupSubmitButton];
    
}

//设置nav
- (void)setupNav {

    self.title = @"租赁详情";
}

//设置详情页
- (void)setupLeaseDetailsView {

    LeaseDetailsView *leaseDetailsView = [[LeaseDetailsView alloc]initWithFrame:CGRectMake(8, 8 + 64, ScreenW - 8 * 2, LeaseDetailsViewHeight)];
    [self.view addSubview:leaseDetailsView];
}

//设置选择时间
- (void)setupTimeView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(ScreenW / 6, 20 + ScreenW / 6 / 3 + 20);
    
    TimeCollectionView *timeCollectionView = [[TimeCollectionView alloc]initWithFrame:CGRectMake(0, 8 + 64 + LeaseDetailsViewHeight + 8, ScreenW, (20 + ScreenW / 6 / 3 + 20) * 4) collectionViewLayout:flowLayout];
    [self.view addSubview:timeCollectionView];
}

//设置确认按钮
- (void)setupSubmitButton {

    UIButton *submitButton = [[UIButton alloc]initWithFrame:CGRectMake(8, ScreenH - 20 - SubmitButtonHeight, ScreenW - 8 * 2, SubmitButtonHeight)];
    submitButton.layer.cornerRadius = 5;
    submitButton.layer.masksToBounds = YES;
    [submitButton setBackgroundColor:[UIColor orangeColor]];
    [submitButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
