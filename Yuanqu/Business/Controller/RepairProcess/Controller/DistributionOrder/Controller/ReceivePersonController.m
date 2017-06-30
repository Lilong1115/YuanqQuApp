//
//  ReceivePersonController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/21.
//  Copyright © 2017年 李龙. All rights reserved.
//
//接收人员
#import "ReceivePersonController.h"
#import "ReceiveCell.h"
#include "ReceivePersonModel.h"

static NSString * const kReceiveCellID = @"kReceiveCellID";

@interface ReceivePersonController ()

//人员列表
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ReceivePersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"接收人员";
    
    [self setupTable];
    [ReceivePersonModel getReceivePersonModelArray];
    //注册通知
    //人员列表
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appChooseUserListSuccessNotification:) name:AppChooseUserListSuccessNotification object:nil];
    
}

//人员列表
- (void)appChooseUserListSuccessNotification:(NSNotification *)noti {
    
    self.dataArray = noti.object;
    [self.tableView reloadData];
    
}


//设置table
- (void)setupTable {

    [self.tableView registerClass:[ReceiveCell class] forCellReuseIdentifier:kReceiveCellID];
    
    self.tableView.tableFooterView = [self setupFooter];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ReceivePersonModel getReceivePersonModelArray];
        [self.tableView.mj_header endRefreshing];
    }];
}

//设置按钮
- (UIView *)setupFooter {
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    
    UIButton *repairButton = [self creatButtonWithTitle:@"确认"];
    repairButton.frame = CGRectMake(10, 5, ScreenW - 10 * 2, 40);
    [footerView addSubview:repairButton];
    [repairButton addTarget:self action:@selector(clickRepairButton) forControlEvents:UIControlEventTouchUpInside];
    
    return footerView;
    
}

//确认
- (void)clickRepairButton {

    NSMutableArray *arrayM = [NSMutableArray array];
    
    [self.dataArray enumerateObjectsUsingBlock:^(ReceivePersonModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        ReceiveCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
        if (cell.selected == YES) {
            [arrayM addObject:model];
        }
    }];
    
    //判断是否选择人员
    if (arrayM.count == 0) {
        [ProgressHUD showError:@"请选择接收人员"];
    } else {
    
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:AppChooseUserSuccessNotification object:arrayM.copy];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//设置按钮
- (UIButton *)creatButtonWithTitle:(NSString *)title {
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    return button;
}



#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ReceiveCell *cell = [tableView dequeueReusableCellWithIdentifier:kReceiveCellID forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
