//
//  HandleController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

//报修处理/投诉处理
#import "HandleController.h"
#import "HandleCell.h"
#import "OrderDetailsController.h"

static NSString * const kHandleCellID = @"kHandleCellID";

@interface HandleController ()

@end

@implementation HandleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTable];
}

//设置nav
- (void)setupNav {

    self.title = self.navTitle;
    
}

//设置table
- (void)setupTable {

    //注册
    [self.tableView registerClass:[HandleCell class] forCellReuseIdentifier:kHandleCellID];
    
    //去掉下划线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //行高
    self.tableView.rowHeight = 230;
    //去掉滚动轴
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    HandleCell *cell = [tableView dequeueReusableCellWithIdentifier:kHandleCellID forIndexPath:indexPath];
    
    //详情回调
    __weak HandleController *weakSelf = self;
    cell.clickDetailsBlock = ^(){
        __strong HandleController *strongSelf = weakSelf;
        
        OrderDetailsController *orderDetailsVC = [[OrderDetailsController alloc]init];
        
        [strongSelf.navigationController pushViewController:orderDetailsVC animated:YES];
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark --delegate



@end
