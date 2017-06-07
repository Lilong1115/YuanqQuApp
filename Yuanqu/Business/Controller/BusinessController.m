//
//  BusinessController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/26.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "BusinessController.h"
#import "BusinessCollectionView.h"
#import "BusinessFlowLayout.h"
#import "ToGuaranteeController.h"
#import "HomeModel.h"
#import "HandleController.h"
#import "LeaseController.h"

@interface BusinessController ()

@end

@implementation BusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupBusinessView];
}
    
//设置nav
- (void)setupNav {
    
    self.title = @"业务";
}

//设置业务区内容
- (void)setupBusinessView {

    //flowLayout
    BusinessFlowLayout *flowLayout = [[BusinessFlowLayout alloc]init];
    flowLayout.businessColumns = 3;
    
    NSArray *array = [HomeModel getHomeModelArray];
    
    BusinessCollectionView *businessView = [[BusinessCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 49) collectionViewLayout:flowLayout];
    
    businessView.contentArray = array;
    
    //点击回调
    __weak BusinessController *weakSelf = self;
    businessView.selectedBlock = ^(NSIndexPath *indexPath) {
        __strong BusinessController *strongSelf = weakSelf;
        
        HomeModel *model = array[indexPath.item];
        
        if ([model.title isEqualToString:@"报修"]) {
            
            ToGuaranteeController *ToGuaranteeVC = [[ToGuaranteeController alloc]init];
            ToGuaranteeVC.navTitle = @"我要报修";
            [strongSelf.navigationController pushViewController:ToGuaranteeVC animated:YES];
        } else if ([model.title isEqualToString:@"报修处理"]) {
        
            HandleController *handleVC = [[HandleController alloc]init];
            handleVC.navTitle = model.title;
            [strongSelf.navigationController pushViewController:handleVC animated:YES];
        } else if ([model.title isEqualToString:@"投诉"]) {
            
            ToGuaranteeController *ToGuaranteeVC = [[ToGuaranteeController alloc]init];
            ToGuaranteeVC.navTitle = @"我要投诉";
            [strongSelf.navigationController pushViewController:ToGuaranteeVC animated:YES];
        } else if ([model.title isEqualToString:@"投诉处理"]) {
            
            HandleController *handleVC = [[HandleController alloc]init];
            handleVC.navTitle = model.title;
            [strongSelf.navigationController pushViewController:handleVC animated:YES];
        } else if ([model.title isEqualToString:@"任务"]) {
            
            HandleController *handleVC = [[HandleController alloc]init];
            handleVC.navTitle = @"任务工单";
            [strongSelf.navigationController pushViewController:handleVC animated:YES];
        } else if ([model.title isEqualToString:@"租赁"]) {
            
            LeaseController *leaseVC = [[LeaseController alloc]init];
            [strongSelf.navigationController pushViewController:leaseVC animated:YES];
        }
        
    };
    
    [self.view addSubview:businessView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
