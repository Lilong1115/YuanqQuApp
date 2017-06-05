//
//  DispatchPersonnelController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

//派发人员
#import "DispatchPersonnelController.h"

static NSString * const kDispatchPersonnelCellID = @"kDispatchPersonnelCellID";

@interface DispatchPersonnelController ()

@end

@implementation DispatchPersonnelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
}


//设置table
- (void)setupTable {

    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDispatchPersonnelCellID];
    
    //去掉下划线
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    //去掉滚动轴
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDispatchPersonnelCellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"io%ld(职务)", indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark --delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.dispatchPersonnelBlock) {
        self.dispatchPersonnelBlock();
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
