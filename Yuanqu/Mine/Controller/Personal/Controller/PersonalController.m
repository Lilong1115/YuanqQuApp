//
//  PersonalController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/19.
//  Copyright © 2017年 李龙. All rights reserved.
//
//个人资料
#import "PersonalController.h"
#import "PersonalCell.h"
#import "PersonalModel.h"

//cellid
static NSString * const kPersonalCellID = @"kPersonalCellID";

@interface PersonalController ()

//数据源
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    
    [self setupTable];
    
}

//设置table
- (void)setupTable {

    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //注册
    [self.tableView registerClass:[PersonalCell class] forCellReuseIdentifier:kPersonalCellID];
    
    //设置高度
    self.tableView.rowHeight = 60;
    
    //取消弹簧
    self.tableView.bounces = NO;
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}


#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PersonalCell *cell = [tableView dequeueReusableCellWithIdentifier:kPersonalCellID forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark --lazy
- (NSArray *)dataArray {

    if (_dataArray == nil) {
        _dataArray = [PersonalModel getPersonalModelArray];
        [self.tableView reloadData];
    }
    
    return _dataArray;
}


@end
