//
//  HandleController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

//报修处理/投诉处理/任务详情
#import "HandleController.h"
#import "OrderDetailsController.h"
#import "GuaranteeDetailsController.h"
#import "GuaranteeListModel.h"
#import "HandleView.h"

static NSString * const kHandleCellID = @"kHandleCellID";

@interface HandleController ()

//数据源
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation HandleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTable];
    
    //获取数据
//    [GuaranteeListModel getWorkOrderListModelArray];
    //注册通知
    //获取报修处理列表的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWorkOrderListSuccessNotification:) name:AppWorkOrderListSuccessNotification object:nil];
}

//获取报修处理列表的通知
- (void)appWorkOrderListSuccessNotification:(NSNotification *)noti {

    self.dataArray = noti.object;
    [self.tableView reloadData];

}

//设置nav
- (void)setupNav {

    self.title = self.navTitle;
    
}

//设置table
- (void)setupTable {
    
//    HandleView *repairOrderView = []
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
