//
//  MessageController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/7.
//  Copyright © 2017年 李龙. All rights reserved.
//
//消息
#import "MessageController.h"
#import "MessageCell.h"
#import "MessageHeaderView.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTable];
}

//设置nav
- (void)setupNav {

    self.title = @"消息";
}

//设置table
- (void)setupTable {
    
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:@"cellID"];
    
}

#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView fd_heightForCellWithIdentifier:@"cellID" cacheByIndexPath:indexPath configuration:^(id cell) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    return [[MessageHeaderView alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
