//
//  RepairOrderController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "RepairOrderController.h"
#import "ScrollToSwitchView.h"
#import "ScrollToView.h"
#import "RepairView.h"
#import "GuaranteeListModel.h"
#import "RepairOrderModel.h"
#import "RepairOrderDetailsController.h"

#pragma mark --宏定义
//上部滚动高度
#define ScrollToSwitchViewHeight 40

@interface RepairOrderController ()
//上部滚动视图
@property (nonatomic, weak) ScrollToSwitchView *scrollToSwitchView;
//下部滚动视图
@property (nonatomic, weak) ScrollToView *scrollToView;

//未制定工单
@property (nonatomic, weak) RepairView *noRepairView;
//未制定工单数据
@property (nonatomic, strong) NSArray *noRepairData;
//已制定工单
@property (nonatomic, weak) RepairView *yesRepairView;
//已制定工单数据
@property (nonatomic, strong) NSArray *yesRepairData;

@end

@implementation RepairOrderController

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    //获取数据
    [GuaranteeListModel getNoRepairOrderListModelArray];
    [RepairOrderModel getYesRepairOrderListModelArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupNav];
    [self setupScrollToSwitchView];
    [self setupScrollToView];

    //获取数据
    [GuaranteeListModel getNoRepairOrderListModelArray];
    [RepairOrderModel getYesRepairOrderListModelArray];
    //注册通知
    //获取未制定害怕工单报修处理列表的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkOrderListSuccessNotification:) name:AppWorkOrderListSuccessNotification object:nil];
    //已制定
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkOrderShowListSuccessNotification:) name:AppWorkOrderShowListSuccessNotification object:nil];
}

//获取报修处理列表的通知
- (void)appWorkOrderListSuccessNotification:(NSNotification *)noti {
    self.noRepairData = noti.object;
    self.noRepairView.dataArray = self.noRepairData;
}

//获取报修处理列表的通知已制定
- (void)appWorkOrderShowListSuccessNotification:(NSNotification *)noti {
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
    scrollToSwitchView.contentArray = @[@"未制定", @"已制定"];
    
    //滚动回调
    //防止循环引用
    __weak RepairOrderController *weakSelf = self;
    scrollToSwitchView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong RepairOrderController *strongSelf = weakSelf;
        
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
    
    //未制定
    RepairView *noRepairView = [[RepairView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) style:UITableViewStylePlain];
    self.noRepairView = noRepairView;
    noRepairView.idx = 0;
    
    //防止循环引用
    __weak RepairOrderController *weakSelf = self;
    noRepairView.clickDetailsBlock = ^(NSIndexPath *indexPath){
        __strong RepairOrderController *strongSelf = weakSelf;
        
        RepairOrderDetailsController *repairOrderDetailsVC = [[RepairOrderDetailsController alloc]init];
        repairOrderDetailsVC.repairOrderModel = strongSelf.noRepairData[indexPath.row];
        [strongSelf.navigationController pushViewController:repairOrderDetailsVC animated:YES];
    };
    
    //下拉刷新
    noRepairView.refreshBlock = ^(){
        [GuaranteeListModel getNoRepairOrderListModelArray];
    };
    
    
    //已制定
    RepairView *yesRepairView = [[RepairView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) style:UITableViewStylePlain];
    self.yesRepairView = yesRepairView;
    yesRepairView.idx = 1;
    
    yesRepairView.clickDetailsBlock = ^(NSIndexPath *indexPath){
        __strong RepairOrderController *strongSelf = weakSelf;
        
        RepairOrderDetailsController *repairOrderDetailsVC = [[RepairOrderDetailsController alloc]init];
        repairOrderDetailsVC.yesRepairOrderModel = strongSelf.yesRepairData[indexPath.row];
        [strongSelf.navigationController pushViewController:repairOrderDetailsVC animated:YES];
    };
    
    //下拉刷新
    yesRepairView.refreshBlock = ^(){
        [RepairOrderModel getYesRepairOrderListModelArray];
    };
    
    scrollToView.contentArray = @[noRepairView, yesRepairView];
    //滚动回调
    scrollToView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong RepairOrderController *strongSelf = weakSelf;
        
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
