//
//  DecorateView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DecorateView.h"
#import "DecorateCell.h"
#import "DecorateModel.h"

static NSString * const kDecorateCellID = @"kDecorateCellID";

@interface DecorateView()<UITableViewDelegate, UITableViewDataSource>

@end


@implementation DecorateView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[DecorateCell class] forCellReuseIdentifier:kDecorateCellID];
        //去掉滚动轴
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        //下拉刷新
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            
//            [self.mj_header endRefreshing];
        }];
        
        self.tableFooterView = [[UIView alloc]init];
        
    }
    
    return self;
}


#pragma mark --UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    /**
     *  如果没有数据的时候提示用户的信息
     */
    [tableView tableViewDisplayWitMsg:@"暂无数据" ifNecessaryForRowCount:self.dataArray.count];
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DecorateCell *cell = [tableView dequeueReusableCellWithIdentifier:kDecorateCellID forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    cell.listType = self.listType;
    
    //回调
    __weak DecorateView *weakSelf = self;
    cell.clickDetailsBlock = ^(NSIndexPath *indexPath) {
        __strong DecorateView *strongSelf = weakSelf;
        if (strongSelf.clickDetailsBlock) {
            strongSelf.clickDetailsBlock(indexPath);
        }
        
    };
    cell.clickDeleteBlock = ^(NSIndexPath *indexPath) {
        __strong DecorateView *strongSelf = weakSelf;
        if (strongSelf.clickDeleteBlock) {
            strongSelf.clickDeleteBlock(indexPath);
        }
        
    };
    cell.clickSubmitBlock = ^(NSIndexPath *indexPath) {
        __strong DecorateView *strongSelf = weakSelf;
        if (strongSelf.clickSubmitBlock) {
            strongSelf.clickSubmitBlock(indexPath);
        }
        
    };
    cell.clickAuditBlock = ^(NSIndexPath *indexPath) {
        __strong DecorateView *strongSelf = weakSelf;
        if (strongSelf.clickAuditBlock) {
            strongSelf.clickAuditBlock(indexPath);
        }
        
    };
    cell.clickClearBlock = ^(NSIndexPath *indexPath) {
        __strong DecorateView *strongSelf = weakSelf;
        if (strongSelf.clickClearBlock) {
            strongSelf.clickClearBlock(indexPath);
        }
        
    };
    cell.clickReductionBlock = ^(NSIndexPath *indexPath) {
        __strong DecorateView *strongSelf = weakSelf;
        if (strongSelf.clickReductionBlock) {
            strongSelf.clickReductionBlock(indexPath);
        }
        
    };
    
    
    return cell;
    
}


//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:kDecorateCellID cacheByKey:indexPath configuration:^(id cell) {
    
        ((DecorateCell *)cell).model = self.dataArray[indexPath.row];
        
    }];
    
}

@end
