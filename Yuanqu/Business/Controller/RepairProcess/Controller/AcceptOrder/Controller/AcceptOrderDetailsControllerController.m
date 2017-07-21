//
//  AcceptOrderDetailsControllerController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/22.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AcceptOrderDetailsControllerController.h"
#import "DistributionOrderHeader.h"
#import "DistributionDetailsCell.h"
#import "DistributionTitleModel.h"
#import "RepairOrderModel.h"
#import "ReceivePersonController.h"
#import "ReceivePersonModel.h"

static NSString * const kDistributionDetailsCellID = @"kDistributionDetailsCellID";

@interface AcceptOrderDetailsControllerController ()

//数据源
@property (nonatomic, strong) NSArray *dataArray;
//内容
@property (nonatomic, strong) NSArray *contentData;

//维修描述
@property (nonatomic, weak) UITextView *textView;

@end

@implementation AcceptOrderDetailsControllerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navTitle;
    [self setupTable];
    
    //受理中提交成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addMaintenaceSuccessNotification:) name:AddMaintenaceSuccessNotification object:nil];
    //受理中投诉单提交成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addMaintenaceSuccessNotification:) name:AddComplainLogsSuccessNotification object:nil];
    //受理完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appfinishWorkSuccessNotification:) name:AppfinishWorkSuccessNotification object:nil];
    //受理投诉单完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appfinishWorkSuccessNotification:) name:AppFinishComplainLogsSuccessNotification object:nil];
    
}

//受理完成
- (void)appfinishWorkSuccessNotification:(NSNotification *)noti {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//受理中提交成功
- (void)addMaintenaceSuccessNotification:(NSNotification *)noti {
    
    self.textView.text = @"";
}


//设置table
- (void)setupTable {
    
    //注册
    [self.tableView registerClass:[DistributionDetailsCell class] forCellReuseIdentifier:kDistributionDetailsCellID];
    
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 50;
    
    self.tableView.tableFooterView = [self setupFooter];
    
    self.tableView.tableFooterView.hidden = self.isFinish;
    self.tableView.userInteractionEnabled = !self.isFinish;
}

//设置按钮
- (UIView *)setupFooter {
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 8, ScreenW - 8 * 2, 30)];
    label.text = @"维修描述";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor grayColor];
    [footerView addSubview:label];
    
    UITextView *textView = [UITextView creatTextViewWithPlaceholder:@"请输入维修描述"];
    textView.frame = CGRectMake(8, 8 + 30, ScreenW - 8 * 2, 100);
    textView.layer.borderWidth = 0.5;
    textView.layer.borderColor = [UIColor grayColor].CGColor;
    [footerView addSubview:textView];
    self.textView = textView;
    
    UIButton *repairButton = [self creatButtonWithTitle:@"提交"];
    repairButton.frame = CGRectMake(10, 5 + 30 + 8 * 2 + 100, (ScreenW - 10 * 3) / 2, 40);
    [footerView addSubview:repairButton];
    
    [repairButton addTarget:self action:@selector(clickRepairButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *completeButton = [self creatButtonWithTitle:@"完成"];
    completeButton.frame = CGRectMake(10 * 2 + (ScreenW - 10 * 3) / 2, 5 + 30 + 8 * 2 + 100, (ScreenW - 10 * 3) / 2, 40);
    [footerView addSubview:completeButton];
    
    [completeButton addTarget:self action:@selector(clickCompleteButton) forControlEvents:UIControlEventTouchUpInside];
    
    return footerView;
    
}

//完成按钮
- (void)clickCompleteButton {

    
    JCAlertController *alert = [JCAlertController alertWithTitle:@"完成" message:@"确认完成?"];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        
        NSDictionary *dict = @{
                               @"MR_GDBH": self.yesRepairOrderModel.wd_BYE,
                               @"USERNAME": [UserInfo account].dsoa_user_name,
                               @"USERID": [UserInfo account].dsoa_user_code,
                               @"MR_WXBZ": self.textView.text,
                               @"SSBM": [UserInfo account].dsoa_user_suoscode,
                               @"DEPTNAME": [UserInfo account].dsoa_dept_name,
                               @"WD_BXBT": self.yesRepairOrderModel.wd_BXBT
                               };
        
        
        if ([self.navTitle isEqualToString:@"受理工单"])  {
            [RepairOrderModel acceptFinishOrderSubmitWithDict:dict];
        } else if ([self.navTitle isEqualToString:@"受理投诉单"]) {
            
            [RepairOrderModel complaintAcceptFinishOrderSubmitWithDict:dict];
        }
        
        
        
        
    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
    
    
    
    
    
}

//提交按钮
- (void)clickRepairButton {
    
    JCAlertController *alert = [JCAlertController alertWithTitle:@"提交" message:@"确认提交?"];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        
        NSDictionary *dict = @{
                               @"MR_GDBH": self.yesRepairOrderModel.wd_BYE,
                               @"USERNAME": [UserInfo account].dsoa_user_name,
                               @"USERID": [UserInfo account].dsoa_user_code,
                               @"MR_WXBZ": self.textView.text,
                               @"SSBM": [UserInfo account].dsoa_user_suoscode,
                               @"DEPTNAME": [UserInfo account].dsoa_dept_name,
                               @"WD_BXBT": self.yesRepairOrderModel.wd_BXBT
                               };
        
        if ([self.navTitle isEqualToString:@"受理工单"])  {
            [RepairOrderModel acceptingOrderSubmitWithDict:dict];
        } else if ([self.navTitle isEqualToString:@"受理投诉单"]) {
            
            [RepairOrderModel complaintAcceptingOrderSubmitWithDict:dict];
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
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)self.dataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DistributionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:kDistributionDetailsCellID forIndexPath:indexPath];
    
    cell.titleModel = self.dataArray[indexPath.section][indexPath.row];
    cell.content = self.contentData[indexPath.section][indexPath.row];
    
    
    return cell;
}


#pragma mark --lazy
- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
            
        _dataArray = [DistributionTitleModel getAcceptTitleModelArray];
        
    }
    
    return _dataArray;
}


- (NSArray *)contentData {
    
    if (_contentData == nil) {
            
        _contentData = @[
                         @[
                             self.yesRepairOrderModel.itemid,
                             self.yesRepairOrderModel.wd_BXBT,
                             self.yesRepairOrderModel.wd_KHMC,
                             self.yesRepairOrderModel.wd_BXNR,
                             self.yesRepairOrderModel.wd_BXDH,
                             self.yesRepairOrderModel.wd_WYDZ,
                             self.yesRepairOrderModel.wd_JJCD,
                             self.yesRepairOrderModel.username,
                             self.yesRepairOrderModel.senddate
                             ],
//                         @[
//                             self.yesRepairOrderModel.objname
//                             ]
                         ];
        
    }
    
    return _contentData;
}


@end
