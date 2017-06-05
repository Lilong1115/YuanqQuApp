//
//  GuaranteeDetailsController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//报修详情
#import "GuaranteeDetailsController.h"
#import "GuaranteeDetailsView.h"
#import "GuaranteeEstimateController.h"

#pragma mark --宏定义
//底部视图高度
#define FooterViewHeight 80
//间距
#define FooterViewMargin 15

@interface GuaranteeDetailsController ()

@end

@implementation GuaranteeDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupGuaranteeDetailsView];
    [self setupToEstimate];
}

//设置导航
- (void)setupNav {

    self.title = @"报修详情";
}

//设置详情内容
- (void)setupGuaranteeDetailsView {

    GuaranteeDetailsView *guaranteeDetailsView = [[GuaranteeDetailsView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - FooterViewHeight) style:UITableViewStylePlain];
    [self.view addSubview:guaranteeDetailsView];
}

//设置我要评价
- (void)setupToEstimate {

    //我要评价按钮
    UIButton *estimateButton = [[UIButton alloc]initWithFrame:CGRectMake(FooterViewMargin, ScreenH - FooterViewHeight + FooterViewMargin, ScreenW - FooterViewMargin * 2, FooterViewHeight - FooterViewMargin * 2)];
    [estimateButton setTitle:@"我要评价" forState:UIControlStateNormal];
    [estimateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [estimateButton setBackgroundColor:[UIColor orangeColor]];
    
    [estimateButton addTarget:self action:@selector(clickEstimateButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:estimateButton];
    
}

//我要评价
- (void)clickEstimateButton {

    GuaranteeEstimateController *guaranteeEstimateVC = [[GuaranteeEstimateController alloc]init];
    
    [self.navigationController pushViewController:guaranteeEstimateVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
