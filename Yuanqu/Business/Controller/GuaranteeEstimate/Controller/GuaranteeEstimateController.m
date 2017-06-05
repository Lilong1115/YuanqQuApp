//
//  GuaranteeEstimateController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//
//报修评价
#import "GuaranteeEstimateController.h"
#import "EstimateView.h"

@interface GuaranteeEstimateController ()

@end

@implementation GuaranteeEstimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    [self setupEstimateView];
}

//设置Nav
- (void)setupNav {

    self.title = @"报修评价";
}

//设置评价视图
- (void)setupEstimateView {

    EstimateView *estimaeView = [[EstimateView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64)];
    //确认回调
    estimaeView.comfirmBlock = ^(){
        
        NSLog(@"确认");
    };
    
    [self.view addSubview:estimaeView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
