//
//  DistributionOrderController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DistributionOrderController.h"
#import "ScrollToSwitchView.h"
#import "ScrollToView.h"
#import "RepairView.h"
#import "RepairOrderModel.h"
#import "DistributionOrderDetailsController.h"


#pragma mark --宏定义
//上部滚动高度
#define ScrollToSwitchViewHeight 40

@interface DistributionOrderController ()
//上部滚动视图
@property (nonatomic, weak) ScrollToSwitchView *scrollToSwitchView;
//下部滚动视图
@property (nonatomic, weak) ScrollToView *scrollToView;

//未分配工单
@property (nonatomic, weak) RepairView *noRepairView;
//未分配工单数据
@property (nonatomic, strong) NSArray *noRepairData;
//已分配工单
@property (nonatomic, weak) RepairView *yesRepairView;
//已分配工单数据
@property (nonatomic, strong) NSArray *yesRepairData;

@end

@implementation DistributionOrderController


- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    if ([self.navTitle isEqualToString:@"工单分配"]) {
        //获取数据
        [RepairOrderModel getYesRepairOrderListModelArray];
        [RepairOrderModel getYesDistributionOrderListModelArray];
    } else if ([self.navTitle isEqualToString:@"投诉单分配"]) {
    
        [RepairOrderModel getYesComplaintOrderListModelArray];
        [RepairOrderModel getYesComplaintDistributionOrderListModelArray];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupNav];
    [self setupScrollToSwitchView];
    [self setupScrollToView];
    
    if ([self.navTitle isEqualToString:@"工单分配"]) {
        //获取数据
        [RepairOrderModel getYesRepairOrderListModelArray];
        [RepairOrderModel getYesDistributionOrderListModelArray];
        //注册通知
        //获取未制定工单报修处理列表的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkOrderListSuccessNotification:) name:AppWorkOrderShowListSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkAcceptListSuccessNotification:) name:AppWorkAcceptListSuccessNotification object:nil];
    } else if ([self.navTitle isEqualToString:@"投诉单分配"]) {
        
        [RepairOrderModel getYesComplaintOrderListModelArray];
        [RepairOrderModel getYesComplaintDistributionOrderListModelArray];
        
        //注册通知
        //获取未制定工单报修处理列表的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkOrderListSuccessNotification:) name:AppComplainManagementShowListSuccessNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkAcceptListSuccessNotification:) name:AppComplainManagementAcceptListSuccessNotification object:nil];
    }
    
}

//获取报修处理列表的通知未分配
- (void)appWorkOrderListSuccessNotification:(NSNotification *)noti {
    self.noRepairData = noti.object;
    self.noRepairView.dataArray = self.noRepairData;
}

//获取报修处理列表的通知已分配
- (void)appWorkAcceptListSuccessNotification:(NSNotification *)noti {
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
    scrollToSwitchView.contentArray = @[@"未分配", @"已分配"];
    
    //滚动回调
    //防止循环引用
    __weak DistributionOrderController *weakSelf = self;
    scrollToSwitchView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong DistributionOrderController *strongSelf = weakSelf;
        
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
    
    //未分配
    RepairView *noRepairView = [[RepairView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) style:UITableViewStylePlain];
    self.noRepairView = noRepairView;
    noRepairView.idx = 1;
    
    //防止循环引用
    __weak DistributionOrderController *weakSelf = self;
    noRepairView.clickDetailsBlock = ^(NSIndexPath *indexPath){
        __strong DistributionOrderController *strongSelf = weakSelf;
        
        DistributionOrderDetailsController *DistributionOrderDetailsVC = [[DistributionOrderDetailsController alloc]init];
        DistributionOrderDetailsVC.navTitle = strongSelf.navTitle;
        DistributionOrderDetailsVC.yesRepairOrderModel = strongSelf.noRepairData[indexPath.row];
        [strongSelf.navigationController pushViewController:DistributionOrderDetailsVC animated:YES];
    };
    
    //下拉刷新
    noRepairView.refreshBlock = ^(){
        
        __strong DistributionOrderController *strongSelf = weakSelf;
        if ([strongSelf.navTitle isEqualToString:@"工单分配"]) {
            //获取数据
            [RepairOrderModel getYesRepairOrderListModelArray];
            
        } else if ([strongSelf.navTitle isEqualToString:@"投诉单分配"]) {
            
            [RepairOrderModel getYesComplaintOrderListModelArray];
        }
    };
    
    
    //已分配
    RepairView *yesRepairView = [[RepairView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) style:UITableViewStylePlain];
    self.yesRepairView = yesRepairView;
    yesRepairView.idx = 1;
    
    yesRepairView.clickDetailsBlock = ^(NSIndexPath *indexPath){
        __strong DistributionOrderController *strongSelf = weakSelf;
        
        DistributionOrderDetailsController *DistributionOrderDetailsVC = [[DistributionOrderDetailsController alloc]init];
        DistributionOrderDetailsVC.navTitle = strongSelf.navTitle;
        DistributionOrderDetailsVC.yesRepairOrderModel = strongSelf.yesRepairData[indexPath.row];
        [strongSelf.navigationController pushViewController:DistributionOrderDetailsVC animated:YES];
    };
    
    //下拉刷新
    yesRepairView.refreshBlock = ^(){
        __strong DistributionOrderController *strongSelf = weakSelf;
        if ([strongSelf.navTitle isEqualToString:@"工单分配"]) {
            //获取数据
            [RepairOrderModel getYesDistributionOrderListModelArray];
        } else if ([strongSelf.navTitle isEqualToString:@"投诉单分配"]) {
         
            [RepairOrderModel getYesComplaintDistributionOrderListModelArray];
        }
    };
    
    scrollToView.contentArray = @[noRepairView, yesRepairView];
    //滚动回调
    scrollToView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong DistributionOrderController *strongSelf = weakSelf;
        
        [strongSelf.scrollToSwitchView scrollToViewWithIndexPath:indexPath];
    };
    
    [self.view addSubview:scrollToView];
    self.scrollToView = scrollToView;
    
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
