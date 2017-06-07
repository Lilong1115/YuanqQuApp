//
//  LeaseController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/6.
//  Copyright © 2017年 李龙. All rights reserved.
//

//租赁
#import "LeaseController.h"
#import "SearchBar.h"
#import "LeaseView.h"
#import "LeaseDetailsController.h"

#pragma mark --宏定义
#define SearchBarHeight 60

@interface LeaseController ()

@end

@implementation LeaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupSearchBar];
    [self setupTable];
}

//设置搜索框
- (void)setupSearchBar {

    SearchBar *searchBar = [[SearchBar alloc]initWithFrame:CGRectMake(0, 64, ScreenW, SearchBarHeight)];
    [self.view addSubview:searchBar];
    
}

//设置table
- (void)setupTable {

    LeaseView *leaseView = [[LeaseView alloc]initWithFrame:CGRectMake(0, 64 + SearchBarHeight, ScreenW, ScreenH - 64 - SearchBarHeight) style:UITableViewStylePlain];
    
    //点击cell回调
    __weak LeaseController *weakSelf = self;
    leaseView.clickCellBlock = ^(NSInteger idx) {
        
        __strong LeaseController *strongSelf = weakSelf;
        LeaseDetailsController *leaseDetailsVC = [[LeaseDetailsController alloc]init];
        [strongSelf.navigationController pushViewController:leaseDetailsVC animated:YES];
    };
    
    [self.view addSubview:leaseView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
