//
//  HandleView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//
//报修处理
#import "HandleView.h"
#import "HandleCell.h"

static NSString * const kHandleCellID = @"kHandleCellID";

@implementation HandleView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        //注册
        [self registerClass:[HandleCell class] forCellReuseIdentifier:kHandleCellID];
        
        //去掉下划线
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //行高
        self.rowHeight = 200;
        //去掉滚动轴
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        //下拉刷新
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //获取数据
//            [GuaranteeListModel getWorkOrderListModelArray];
            [self.mj_header endRefreshing];
        }];
    }
    
    return self;
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
    
    cell.model = self.dataArray[indexPath.row];
    
    //详情回调
    __weak HandleView *weakSelf = self;
    cell.clickDetailsBlock = ^(){
        __strong HandleView *strongSelf = weakSelf;
        
//        if ([self.navTitle isEqualToString:@"任务工单"]) {
//            
//            GuaranteeDetailsController *guaranteeDetailsVC = [[GuaranteeDetailsController alloc]init];
//            guaranteeDetailsVC.navTitle = @"任务详情";
//            [strongSelf.navigationController pushViewController:guaranteeDetailsVC animated:YES];
//            
//        } else {
//            OrderDetailsController *orderDetailsVC = [[OrderDetailsController alloc]init];
//            
//            [strongSelf.navigationController pushViewController:orderDetailsVC animated:YES];
//        }
        
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//设置cell高度并缓存
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:kHandleCellID cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];
}

#pragma mark --delegate




//设置数据
- (void)setDataArray:(NSArray *)dataArray {

    _dataArray = dataArray;
    [self reloadData];
}

@end
