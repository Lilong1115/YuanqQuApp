//
//  RepairProcessController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//
//报修处理
#import "RepairProcessController.h"
#import "BusinessFlowLayout.h"
#import "BusinessCollectionView.h"
#import "HomeModel.h"
#import "RepairOrderController.h"
#import "DistributionOrderController.h"
#import "AcceptOrderController.h"

@interface RepairProcessController ()

@end

@implementation RepairProcessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"报修处理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLogo];
    [self setupBusinessView];
    [self setupFooter];
}

//设置logo
- (void)setupLogo {

    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, 250)];
    logo.image = [UIImage imageNamed:@"meinv"];
    [self.view addSubview:logo];
    
}


//设置业务区内容
- (void)setupBusinessView {
    
    //flowLayout
    BusinessFlowLayout *flowLayout = [[BusinessFlowLayout alloc]init];
    flowLayout.businessColumns = 3;
    
    
    BusinessCollectionView *businessView = [[BusinessCollectionView alloc]initWithFrame:CGRectMake(0, 64 + 250, ScreenW, ScreenW / 3) collectionViewLayout:flowLayout];
    businessView.contentArray = [HomeModel getOrderModelArray];
    
    //点击回调
    __weak RepairProcessController *weakSelf = self;
    businessView.selectedBlock = ^(NSIndexPath *indexPath) {
        __strong RepairProcessController *strongSelf = weakSelf;
        
        if (indexPath.item == 0) {
            RepairOrderController *repairOrderVC = [[RepairOrderController alloc]init];
            repairOrderVC.navTitle = @"制定工单";
            
            [strongSelf.navigationController pushViewController:repairOrderVC animated:YES];
        } else if (indexPath.item == 1) {
        
            DistributionOrderController *distributionOrderVC = [[DistributionOrderController alloc]init];
            distributionOrderVC.navTitle = @"分配工单";
            [strongSelf.navigationController pushViewController:distributionOrderVC animated:YES];
            
        } else if (indexPath.item == 2) {
        
            AcceptOrderController *acceptOrderVC = [[AcceptOrderController alloc]init];
            acceptOrderVC.navTitle = @"受理工单";
            [strongSelf.navigationController pushViewController:acceptOrderVC animated:YES];
            
        }
        
        
        
    };
    
    [self.view addSubview:businessView];
}


//设置footer
- (void)setupFooter {

    UIButton *footerBotton = [[UIButton alloc]initWithFrame:CGRectMake(0, ScreenH - 50, ScreenW, 50)];
    [footerBotton setTitle:@"客服电话:400-800803042" forState:UIControlStateNormal];
    [footerBotton setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:footerBotton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
