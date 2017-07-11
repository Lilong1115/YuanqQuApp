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
#import "RepairProcessController.h"

@interface BusinessController ()

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, weak) BusinessCollectionView *businessView;

@end

@implementation BusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupBusinessView];
    
    //业务
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appShowMenuListNotification:) name:AppShowMenuListNotification object:nil];
}

//业务
- (void)appShowMenuListNotification:(NSNotification *)noti {
    
    self.dataArray = noti.object;
    self.businessView.contentArray = self.dataArray;
    [self.businessView reloadData];
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
    
    BusinessCollectionView *businessView = [[BusinessCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 49) collectionViewLayout:flowLayout];
    
    [HomeModel getMenuListModelArray];
    
    businessView.contentArray = self.dataArray;
    
    //点击回调
    __weak BusinessController *weakSelf = self;
    businessView.selectedBlock = ^(NSIndexPath *indexPath) {
        __strong BusinessController *strongSelf = weakSelf;
        
        HomeModel *model = strongSelf.dataArray[indexPath.item];
        
        NSInteger type = [model.type integerValue];
        
        //报修
        if (type == RepairType) {
            
            ToGuaranteeController *ToGuaranteeVC = [[ToGuaranteeController alloc]init];
            ToGuaranteeVC.navTitle = @"我要报修";
            ToGuaranteeVC.isPhoto = YES;
            ToGuaranteeVC.isAppComplaints = NO;
            [strongSelf.navigationController pushViewController:ToGuaranteeVC animated:YES];
            //工单管理
        } else if (type == RepairOrderType) {
        
            RepairProcessController *repairProcessVC = [[RepairProcessController alloc]init];
            repairProcessVC.navTitle = model.name;
            [strongSelf.navigationController pushViewController:repairProcessVC animated:YES];
            //投诉
        } else if (type == ToComplaintType) {
            
            ToGuaranteeController *ToGuaranteeVC = [[ToGuaranteeController alloc]init];
            ToGuaranteeVC.navTitle = @"我要投诉";
            ToGuaranteeVC.isPhoto = NO;
            ToGuaranteeVC.isAppComplaints = YES;
            [strongSelf.navigationController pushViewController:ToGuaranteeVC animated:YES];
            //投诉处理
        } else if (type == ComplaintType) {
            
            RepairProcessController *repairProcessVC = [[RepairProcessController alloc]init];
            repairProcessVC.navTitle = model.name;
            [strongSelf.navigationController pushViewController:repairProcessVC animated:YES];
        } else if ([model.name isEqualToString:@"任务"]) {
            
            HandleController *handleVC = [[HandleController alloc]init];
            handleVC.navTitle = @"任务工单";
            [strongSelf.navigationController pushViewController:handleVC animated:YES];
        } else if ([model.name isEqualToString:@"租赁"]) {
            
            LeaseController *leaseVC = [[LeaseController alloc]init];
            [strongSelf.navigationController pushViewController:leaseVC animated:YES];
        }
        
    };
    
    [self.view addSubview:businessView];
    self.businessView = businessView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
