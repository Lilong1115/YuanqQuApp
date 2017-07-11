//
//  AcceptOrderController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AcceptOrderController.h"
#import "ScrollToSwitchView.h"
#import "ScrollToView.h"
#import "RepairView.h"
#import "GuaranteeListModel.h"
#import "RepairOrderModel.h"
#import "RepairOrderDetailsController.h"
#import "DistributionOrderDetailsController.h"
#import "AcceptOrderDetailsControllerController.h"

#pragma mark --宏定义
//上部滚动高度
#define ScrollToSwitchViewHeight 40

@interface AcceptOrderController ()
//上部滚动视图
@property (nonatomic, weak) ScrollToSwitchView *scrollToSwitchView;
//下部滚动视图
@property (nonatomic, weak) ScrollToView *scrollToView;

//未受理工单
@property (nonatomic, weak) RepairView *noRepairView;
//未受理工单数据
@property (nonatomic, strong) NSArray *noRepairData;
//受理中工单
@property (nonatomic, weak) RepairView *acceptRepairView;
//受理中工单数据
@property (nonatomic, strong) NSArray *acceptRepairData;
//已受理工单
@property (nonatomic, weak) RepairView *yesRepairView;
//已受理工单数据
@property (nonatomic, strong) NSArray *yesRepairData;

@end

@implementation AcceptOrderController


- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    if ([self.navTitle isEqualToString:@"受理工单"]) {
        //获取数据
        [RepairOrderModel getYesDistributionOrderListModelArray];
        [RepairOrderModel getAcceptingOrderListModelArray];
        [RepairOrderModel getAcceptFinishOrderListModelArray];
    } else if ([self.navTitle isEqualToString:@"受理投诉单"]) {
        [RepairOrderModel getYesComplaintDistributionOrderListModelArray];
        [RepairOrderModel getComplaintAcceptingOrderListModelArray];
        [RepairOrderModel getComplaintAcceptFinishOrderListModelArray];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupNav];
    [self setupScrollToSwitchView];
    [self setupScrollToView];
    
    if ([self.navTitle isEqualToString:@"受理工单"]) {
        //获取数据
        [RepairOrderModel getYesDistributionOrderListModelArray];
        [RepairOrderModel getAcceptingOrderListModelArray];
        [RepairOrderModel getAcceptFinishOrderListModelArray];
        //注册通知
        //获取未制定工单报修处理列表的通知
        //未受理工单
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkAcceptListSuccessNotification:) name:AppWorkAcceptListSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkBeingtListSuccessNotification:) name:AppWorkBeingtListSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appFinishListSuccessNotification:) name:AppFinishListSuccessNotification object:nil];
    } else if ([self.navTitle isEqualToString:@"受理投诉单"]) {
        [RepairOrderModel getYesComplaintDistributionOrderListModelArray];
        [RepairOrderModel getComplaintAcceptingOrderListModelArray];
        [RepairOrderModel getComplaintAcceptFinishOrderListModelArray];
        
        //注册通知
        //获取未制定工单报修处理列表的通知
        //未受理工单
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkAcceptListSuccessNotification:) name:AppComplainManagementAcceptListSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkBeingtListSuccessNotification:) name:AppComplainManagementBeingtListSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appFinishListSuccessNotification:) name:AppFinishComplainLogsSuccessNotification object:nil];
        
    }
    
}

//受理中
- (void)appWorkBeingtListSuccessNotification:(NSNotification *)noti {

    self.acceptRepairData = noti.object;
    self.acceptRepairView.dataArray = self.acceptRepairData;
    
}


//获取报修处理列表的通知未受理
- (void)appWorkAcceptListSuccessNotification:(NSNotification *)noti {
    self.noRepairData = noti.object;
    self.noRepairView.dataArray = self.noRepairData;
}

//已完成
- (void)appFinishListSuccessNotification:(NSNotification *)noti {

    self.yesRepairData = noti.object;
    self.yesRepairView.dataArray = self.yesRepairData;
    
}



//设置nav
- (void)setupNav {
    
    self.title = self.navTitle;
    
}

//设置ScrollToSwitchView
- (void)setupScrollToSwitchView {
    
    //不设置这个参数,cell不走item方法
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ScrollToSwitchView *scrollToSwitchView = [[ScrollToSwitchView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, ScrollToSwitchViewHeight)];
    //设置滚动不同内容
    scrollToSwitchView.contentArray = @[@"未受理", @"受理中", @"已受理"];
    
    //滚动回调
    //防止循环引用
    __weak AcceptOrderController *weakSelf = self;
    scrollToSwitchView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong AcceptOrderController *strongSelf = weakSelf;
        
        [strongSelf.scrollToView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    };
    
    [self.view addSubview:scrollToSwitchView];
    self.scrollToSwitchView = scrollToSwitchView;
}

//设置我要报修具体内容
- (void)setupScrollToView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(ScreenW, ScreenH - ScrollToSwitchViewHeight - 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    ScrollToView *scrollToView = [[ScrollToView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight + 10 + 64, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) collectionViewLayout:flowLayout];
    
    //未受理
    RepairView *noRepairView = [[RepairView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) style:UITableViewStylePlain];
    self.noRepairView = noRepairView;
    noRepairView.idx = 1;
    
    //防止循环引用
    __weak AcceptOrderController *weakSelf = self;
    noRepairView.clickDetailsBlock = ^(NSIndexPath *indexPath){
        
        __strong AcceptOrderController *strongSelf = weakSelf;
        
        DistributionOrderDetailsController *DistributionOrderDetailsVC = [[DistributionOrderDetailsController alloc]init];
        DistributionOrderDetailsVC.navTitle = strongSelf.navTitle;
        DistributionOrderDetailsVC.yesRepairOrderModel = strongSelf.noRepairData[indexPath.row];
        [strongSelf.navigationController pushViewController:DistributionOrderDetailsVC animated:YES];
    };
    
    //下拉刷新
    noRepairView.refreshBlock = ^(){
        
        __strong AcceptOrderController *strongSelf = weakSelf;
        if ([strongSelf.navTitle isEqualToString:@"受理工单"]) {
            //获取数据
            [RepairOrderModel getYesDistributionOrderListModelArray];
        
        } else if ([strongSelf.navTitle isEqualToString:@"受理投诉单"]) {
            [RepairOrderModel getYesComplaintDistributionOrderListModelArray];
            
            
        }
    };
    
    //受理中
    RepairView *acceptRepairView = [[RepairView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) style:UITableViewStylePlain];
    self.acceptRepairView = acceptRepairView;
    acceptRepairView.idx = 1;
    
    acceptRepairView.clickDetailsBlock = ^(NSIndexPath *indexPath){
        
        __strong AcceptOrderController *strongSelf = weakSelf;
        
        AcceptOrderDetailsControllerController *DistributionOrderDetailsVC = [[AcceptOrderDetailsControllerController alloc]init];
        DistributionOrderDetailsVC.isFinish = NO;
        DistributionOrderDetailsVC.navTitle = strongSelf.navTitle;
        DistributionOrderDetailsVC.yesRepairOrderModel = strongSelf.acceptRepairData[indexPath.row];
        [strongSelf.navigationController pushViewController:DistributionOrderDetailsVC animated:YES];
        
    };
    
    //下拉刷新
    acceptRepairView.refreshBlock = ^(){
        __strong AcceptOrderController *strongSelf = weakSelf;
        if ([strongSelf.navTitle isEqualToString:@"受理工单"]) {
            
            [RepairOrderModel getAcceptingOrderListModelArray];
            
        } else if ([strongSelf.navTitle isEqualToString:@"受理投诉单"]) {
            
            [RepairOrderModel getComplaintAcceptingOrderListModelArray];
            
            
        }
    };
    
    
    //已受理
    RepairView *yesRepairView = [[RepairView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) style:UITableViewStylePlain];
    self.yesRepairView = yesRepairView;
    yesRepairView.idx = 1;
    
    yesRepairView.clickDetailsBlock = ^(NSIndexPath *indexPath){
        __strong AcceptOrderController *strongSelf = weakSelf;
        
        AcceptOrderDetailsControllerController *DistributionOrderDetailsVC = [[AcceptOrderDetailsControllerController alloc]init];
        DistributionOrderDetailsVC.isFinish = YES;
        DistributionOrderDetailsVC.navTitle = strongSelf.navTitle;
        DistributionOrderDetailsVC.yesRepairOrderModel = strongSelf.yesRepairData[indexPath.row];
        [strongSelf.navigationController pushViewController:DistributionOrderDetailsVC animated:YES];
    };
    
    //下拉刷新
    yesRepairView.refreshBlock = ^(){
        __strong AcceptOrderController *strongSelf = weakSelf;
        if ([strongSelf.navTitle isEqualToString:@"受理工单"]) {
            //获取数据
            
            [RepairOrderModel getAcceptFinishOrderListModelArray];
        } else if ([strongSelf.navTitle isEqualToString:@"受理投诉单"]) {
            
            [RepairOrderModel getComplaintAcceptFinishOrderListModelArray];
            
        }
    };
    
    scrollToView.contentArray = @[noRepairView, acceptRepairView, yesRepairView];
    //滚动回调
    scrollToView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong AcceptOrderController *strongSelf = weakSelf;
        
        [strongSelf.scrollToSwitchView scrollToViewWithIndexPath:indexPath];
    };
    
    [self.view addSubview:scrollToView];
    self.scrollToView = scrollToView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
