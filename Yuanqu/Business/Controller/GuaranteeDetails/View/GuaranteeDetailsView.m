//
//  GuaranteeDetailsView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//报修详情视图
#import "GuaranteeDetailsView.h"
#import "DemandHeaderView.h"
#import "GuaranteeDetailsHeaderView.h"

@interface GuaranteeDetailsView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation GuaranteeDetailsView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        //弹簧
        self.bounces = NO;
        //代理
        self.dataSource = self;
        self.delegate = self;
        
        //注册
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        
        //去掉下划线
//        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        //行高
//        self.rowHeight = 60;
        //去掉滚动轴
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.tableFooterView = [[UIView alloc]init];
        
        [self setupGuaranteeDetailsHeaderView];
    }
    return self;
}

//设置详情头部视图
- (void)setupGuaranteeDetailsHeaderView {

    GuaranteeDetailsHeaderView *guaranteeDetailsHeaderView = [[GuaranteeDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 300)];
    self.tableHeaderView = guaranteeDetailsHeaderView;
}

#pragma mark --dataSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
  
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//设置每个section的headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    DemandHeaderView *headerView = [[DemandHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44)];
    
    //设置标记
    headerView.idx = section;
    //回调
    __weak GuaranteeDetailsView *weakSelf = self;
    headerView.clickFunctionBlock = ^(NSInteger idx) {
        __strong GuaranteeDetailsView *strongSelf = weakSelf;
        switch (idx) {
            case 1:
                if (strongSelf.complaintsBlock) {
                    strongSelf.complaintsBlock();
                }
                break;
            case 2:
                
                break;
            default:
                break;
        }
    };
    
    switch (section) {
        case 0:
            headerView.isHidden = YES;
            headerView.groundColor = [UIColor greenColor];
            headerView.title = @"进度查询";
            headerView.buttonStr = @"";
            break;
        case 1:
            headerView.isHidden = NO;
            headerView.groundColor = [UIColor greenColor];
            headerView.title = @"投诉查询";
            headerView.buttonStr = @"我要投诉";
            break;
        case 2:
            headerView.isHidden = NO;
            headerView.groundColor = [UIColor greenColor];
            headerView.title = @"维修查询";
            headerView.buttonStr = @"维修确认";
            break;
        default:
            break;
    }
    
    return headerView;
    
}

//设置每个section的headerView的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}


//是否有数据
- (void)setIsTableData:(BOOL)isTableData {

    _isTableData = isTableData;
    
    if (isTableData == NO) {

        self.dataArray = @[];
        [self reloadData];
        
    }
    
}


#pragma mark --lazy
- (NSArray *)dataArray {

    if (_dataArray == nil) {
        _dataArray = @[
                       @"1",
                       @"2",
                       @"3"
                       ];
    }
    
    return _dataArray;
}

@end
