//
//  HomeView.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

//首页业务视图
#import "HomeView.h"
#import "HomeCell.h"
#import "HomeHeaderView.h"
#import "HomeBaseModel.h"
#import "HomeModel.h"
#import "Calculate.h"



//cellid
static NSString * const kHomeCellID = @"kHomeCellID";

@interface HomeView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        //设置代理
        self.dataSource = self;
        self.delegate = self;
        
        //取消弹簧
        self.bounces = NO;
        
        //注册
        [self registerClass:[HomeCell class] forCellReuseIdentifier:kHomeCellID];
    }
    return self;
}
    
#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.contentArray.count;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeCellID forIndexPath:indexPath];
    
    HomeBaseModel *baseModel = self.contentArray[indexPath.section];
    
    NSArray *array = baseModel.content;
    
    cell.contentArray = array;
    
    //点击业务回调
    __weak HomeView *weakSelf = self;
    cell.selectedBlock = ^(NSIndexPath *idx) {
        __strong HomeView *strongSelf = weakSelf;
        
        //点击区域
        if (strongSelf.selectedBlock != nil) {
            strongSelf.selectedBlock([NSIndexPath indexPathForRow:idx.item inSection:indexPath.section]);
        }
    };

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    HomeBaseModel *model = self.contentArray[indexPath.section];
    
    return ScreenW / BusinessColumns * [Calculate calculateRowsWithCount:model.content.count columns:BusinessColumns];
}

//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return HomeHeaderViewHeight;
}
    
//设置头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HomeHeaderViewHeight)];
    
    HomeBaseModel *model = self.contentArray[section];
    
    homeHeaderView.headerStr = model.type;
    
    return homeHeaderView;
}
    
#pragma mark --delegate






- (void)setContentArray:(NSArray *)contentArray {

    _contentArray = contentArray;
    [self reloadData];
}

@end
