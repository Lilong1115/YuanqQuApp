//
//  RepairOrderDetailsController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//
//制定工单详情
#import "RepairOrderDetailsController.h"
#import "RepairDetailsCell.h"
#import "RepairTitleModel.h"
#import "GuaranteeListModel.h"
#import "RepairOrderModel.h"

static NSString * const kRepairDetailsCellID = @"kRepairDetailsCellID";

@interface RepairOrderDetailsController ()

//数据源
@property (nonatomic, strong) NSArray *dataArray;
//内容
@property (nonatomic, strong) NSArray *contentData;

@end

@implementation RepairOrderDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navTitle;
    [self setupTable];
    
    //注册通知
    //制单成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWorkOrderSuccessNotification:) name:AddWorkOrderSuccessNotification object:nil];
    //制定投诉单成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWorkOrderSuccessNotification:) name:AddComplainManagementSuccessNotification object:nil];
}

//制单成功的通知
- (void)addWorkOrderSuccessNotification:(NSNotification *)noti {
    
    //跳转
    [self.navigationController popViewControllerAnimated:YES];
}


//设置table
- (void)setupTable {

    //注册
    [self.tableView registerClass:[RepairDetailsCell class] forCellReuseIdentifier:kRepairDetailsCellID];
    
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [self setupFooter];
    
}

//设置按钮
- (UIView *)setupFooter {

    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    
    UIButton *repairButton = [self creatButtonWithTitle:@"制单"];
    repairButton.frame = CGRectMake(10, 5, ScreenW - 10 * 2, 40);
    [footerView addSubview:repairButton];
    
    [repairButton addTarget:self action:@selector(clickRepairButton) forControlEvents:UIControlEventTouchUpInside];
    
    return footerView;
    
}

//制单
- (void)clickRepairButton {

    JCAlertController *alert = [JCAlertController alertWithTitle:@"制单" message:@"确认制单?"];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        
        RepairDetailsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]];
        
        NSDictionary *dict = @{
                               /*
                                报修姓名：WD_KHMC
                                报修单系统编号：WD_BYE
                                报修单工单：ITEMID
                                事发地址：WD_WYDZ
                                报修内容：WD_BXNR
                                报修标题：WD_BXBT
                                报修电话：WD_BXDH
                                紧急程度：WD_JJCD
                                登录用户名：USERNAME
                                登录用户ID：UUID
                                登录用户所属编号：SSBM
                                所属公司名称：DEPTNAME
                                
                                */
                               @"WD_KHMC": self.repairOrderModel.rd_BXXM,
                               @"WD_BYE": self.repairOrderModel.sysid,
                               @"ITEMID": self.repairOrderModel.itemid,
                               @"WD_WYDZ": self.repairOrderModel.rd_SFZB,
                               @"WD_BXNR": self.repairOrderModel.rd_BXNR,
                               @"WD_BXBT": self.repairOrderModel.rd_BXBT,
                               @"WD_BXDH": self.repairOrderModel.rd_BXDH,
                               @"WD_JJCD": cell.degreeStr,
                               @"USERNAME": [UserInfo account].dsoa_user_name,
                               @"UUID": [UserInfo account].dsoa_user_code,
                               @"SSBM": [UserInfo account].dsoa_user_suoscode,
                               @"DEPTNAME": [UserInfo account].dsoa_dept_name
                               };
        
        
        if ([self.navTitle isEqualToString:@"制定工单"]) {
            //提交
            [GuaranteeListModel repairOrderSubmitWithDict:dict];
        } else if ([self.navTitle isEqualToString:@"制定投诉单"]) {
        
            [GuaranteeListModel complaintOrderSubmitWithDict:dict];
        }
        
        
    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
    
    
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

    RepairDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:kRepairDetailsCellID forIndexPath:indexPath];
    
    if (self.repairOrderModel) {
        cell.isHidden = NO;
    } else {
        cell.isHidden = YES;
    }
    
    cell.titleModel = self.dataArray[indexPath.row];
    cell.content = self.contentData[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [tableView fd_heightForCellWithIdentifier:kRepairDetailsCellID configuration:^(id cell) {
        
        if (self.repairOrderModel) {
            ((RepairDetailsCell *)cell).isHidden = NO;
        } else {
            ((RepairDetailsCell *)cell).isHidden = YES;
        }
        
        ((RepairDetailsCell *)cell).titleModel = self.dataArray[indexPath.row];
        ((RepairDetailsCell *)cell).content = self.contentData[indexPath.row];
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --lazy
- (NSArray *)dataArray {

    if (_dataArray == nil) {
        if (self.yesRepairOrderModel) {
            _dataArray = [RepairTitleModel getNewRepairTitleModelArray];
        } else {
            _dataArray = [RepairTitleModel getRepairTitleModelArray];
        }
        
    }
    
    return _dataArray;
    
}

- (NSArray *)contentData {

    if (_contentData == nil) {
        
        if (self.repairOrderModel) {
            _contentData = @[
                             self.repairOrderModel.itemid,
                             self.repairOrderModel.rd_BXXM,
                             self.repairOrderModel.rd_BXDH,
                             self.repairOrderModel.rd_SFZB,
                             self.repairOrderModel.rd_BXBT,
                             self.repairOrderModel.rd_BXNR,
                             self.repairOrderModel.username,
                             self.repairOrderModel.senddate,
                             @"一般"
                             ];
        } else {
            _contentData = @[
                             self.yesRepairOrderModel.itemid,
                             self.yesRepairOrderModel.wd_KHMC,
                             self.yesRepairOrderModel.wd_BXDH,
                             self.yesRepairOrderModel.wd_WYDZ,
                             self.yesRepairOrderModel.wd_BXBT,
                             self.yesRepairOrderModel.wd_BXNR,
                             [UserInfo account].dsoa_user_name,
                             self.yesRepairOrderModel.sysdate,
                             self.yesRepairOrderModel.wd_JJCD
                             ];
            self.tableView.tableFooterView.hidden = YES;
        }
        
        
    }
    
    return _contentData;
}


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
