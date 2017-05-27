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

#pragma mark --宏定义

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
        
        //设置高度
        self.rowHeight = ScreenW / 4 * 2;
        
        //取消弹簧
        self.bounces = NO;
        
        //注册
        [self registerClass:[HomeCell class] forCellReuseIdentifier:kHomeCellID];
    }
    return self;
}
    
#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeCellID forIndexPath:indexPath];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return HomeHeaderViewHeight;
}
    
//设置头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    HomeHeaderView *homeHeaderView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HomeHeaderViewHeight)];
    
    return homeHeaderView;
}
    
#pragma mark --delegate

@end
