//
//  MineController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//

//我的
#import "MineController.h"
#import "MineHeaderView.h"

@interface MineController ()<UITableViewDelegate, UITableViewDataSource>

//我的头视图
@property (nonatomic, weak) MineHeaderView *headerView;
    
@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    [self setupHeader];
    [self setupTable];
}

//设置header
- (void)setupHeader {

    
    
}
    
//设置table
- (void)setupTable {

    //设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //取消弹簧
    self.tableView.bounces = NO;
    
}
    
#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0 ? 1 : 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld---%ld", indexPath.section, indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"star_selecte"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
    
#pragma mark --delegate
    
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
