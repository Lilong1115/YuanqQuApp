//
//  DistributionOrderDetailsController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DistributionOrderDetailsController.h"
#import "DistributionOrderHeader.h"
#import "DistributionDetailsCell.h"
#import "DistributionTitleModel.h"
#import "RepairOrderModel.h"
#import "ReceivePersonController.h"
#import "ReceivePersonModel.h"

static NSString * const kDistributionDetailsCellID = @"kDistributionDetailsCellID";

@interface DistributionOrderDetailsController ()

//数据源
@property (nonatomic, strong) NSArray *dataArray;
//内容
@property (nonatomic, strong) NSArray *contentData;

//选择人员
@property (nonatomic, strong) NSArray *chooseUserArray;

@end

@implementation DistributionOrderDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.navTitle;
    [self setupTable];
    
    //选择接收人员通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appChooseUserSuccessNotification:) name:AppChooseUserSuccessNotification object:nil];
    //分配成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allotWorkOrderSuccessNotification:) name:AllotWorkOrderSuccessNotification object:nil];
    //受理成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addWorkacceptSuccessNotification:) name:AddWorkacceptSuccessNotification object:nil];
    
}

//受理成功
- (void)addWorkacceptSuccessNotification:(NSNotification *)noti {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

//分配成功
- (void)allotWorkOrderSuccessNotification:(NSNotification *)noti {

    
    [self.navigationController popViewControllerAnimated:YES];
}

//选择接收人员通知
- (void)appChooseUserSuccessNotification:(NSNotification *)noti {
    
    self.chooseUserArray = noti.object;
    NSMutableString *strM = [NSMutableString string];
    [self.chooseUserArray enumerateObjectsUsingBlock:^(ReceivePersonModel *model, NSUInteger idx,BOOL * _Nonnull stop) {

        switch (idx) {
            case 0:
                [strM appendString:model.name];
                break;
            default:
                [strM appendFormat:@",%@", model.name];
                break;
        }

    }];
    
    DistributionDetailsCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    cell.receivePersonStr = strM.copy;
}


//设置table
- (void)setupTable {
    
    //注册
    [self.tableView registerClass:[DistributionDetailsCell class] forCellReuseIdentifier:kDistributionDetailsCellID];
    
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 50;
    
    self.tableView.tableFooterView = [self setupFooter];
    
}

//设置按钮
- (UIView *)setupFooter {
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 60)];

    NSString *buttonStr;
    
    if ([self.navTitle isEqualToString:@"分配工单"]) {
        buttonStr = @"分配";
    } else if ([self.navTitle isEqualToString:@"受理工单"]) {
        
        buttonStr = @"受理";
    }

    UIButton *repairButton = [self creatButtonWithTitle:buttonStr];
    repairButton.frame = CGRectMake(10, 5, ScreenW - 10 * 2, 40);
    [footerView addSubview:repairButton];
    
    [repairButton addTarget:self action:@selector(clickRepairButton) forControlEvents:UIControlEventTouchUpInside];
    
    return footerView;
    
}

//footer 按钮
- (void)clickRepairButton {

    if ([self.navTitle isEqualToString:@"分配工单"]) {
        
        [self distribution];
    } else if ([self.navTitle isEqualToString:@"受理工单"]) {
        
        [self accept];
    }
    
}

//受理
- (void)accept {
    /*
     工单系统编号 :  SYSID
     当前用户ID：   USERID
     当前用户名： USERNAME
     所属公司名称：DEPTNAME
     报修单系统编号：WD_BYE
     报修单标题：	WD_BXBT
     */
    NSDictionary *dict = @{
                           @"SYSID": self.yesRepairOrderModel.sysid,
                           @"USERID": [UserInfo account].dsoa_user_code,
                           @"USERNAME": [UserInfo account].dsoa_user_name,
                           @"DEPTNAME": [UserInfo account].dsoa_dept_name,
                           @"WD_BYE": self.yesRepairOrderModel.wd_BYE,
                           @"WD_BXBT": self.yesRepairOrderModel.wd_BXBT
                           };
    
    [RepairOrderModel acceptOrderSubmitWithDict:dict];
}

//分配
- (void)distribution {

    if (self.chooseUserArray.count == 0) {
        [ProgressHUD showError:@"请选择接收人员"];
    } else {
        /*
         工单系统编号：SYSID
         工单接受人ID：WD_SLRID
         工单接收人姓名：WD_SLRNAME
         工单维修人电话：WD_LXDH
         所属公司名称：DEPTNAME
         报修单系统编号：WD_BYE
         报修单标题： WD_BXBT
         当前用户名： USERNAME
         */
        
        NSMutableString *strMWD_SLRID = [NSMutableString string];
        NSMutableString *strMWD_SLRNAME = [NSMutableString string];
        NSMutableString *strMWD_LXDH = [NSMutableString string];
        [self.chooseUserArray enumerateObjectsUsingBlock:^(ReceivePersonModel *model, NSUInteger idx,BOOL * _Nonnull stop) {
            
            switch (idx) {
                case 0:
                    [strMWD_SLRNAME appendString:model.name];
                    [strMWD_SLRID appendString:model.userid];
                    [strMWD_LXDH appendString:model.modileno];
                    break;
                default:
                    [strMWD_SLRNAME appendFormat:@",%@", model.name];
                    [strMWD_SLRID appendFormat:@",%@", model.userid];
                    [strMWD_LXDH appendFormat:@",%@", model.modileno];
                    break;
            }
            
        }];
        
        
        NSDictionary *dict = @{
                               @"SYSID": self.yesRepairOrderModel.sysid,
                               @"WD_SLRID": strMWD_SLRID.copy,
                               @"WD_SLRNAME": strMWD_SLRNAME.copy,
                               @"WD_LXDH": strMWD_LXDH,
                               @"DEPTNAME": [UserInfo account].dsoa_dept_name,
                               @"WD_BYE": self.yesRepairOrderModel.wd_BYE,
                               @"WD_BXBT": self.yesRepairOrderModel.wd_BXBT,
                               @"USERNAME": [UserInfo account].dsoa_user_name
                               };
        
        [RepairOrderModel distributionOrderSubmitWithDict:dict];
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
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)self.dataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    DistributionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:kDistributionDetailsCellID forIndexPath:indexPath];
    
    cell.titleModel = self.dataArray[indexPath.section][indexPath.row];
    cell.content = self.contentData[indexPath.section][indexPath.row];
    
    __weak DistributionOrderDetailsController *weakSelf = self;
    //接收人员
    cell.receivePersonBlock = ^(){
        __strong DistributionOrderDetailsController *strongSelf = weakSelf;
        
        ReceivePersonController *receivePersonVC = [[ReceivePersonController alloc]init];
        
        [strongSelf.navigationController pushViewController:receivePersonVC animated:YES];
        
    };
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    CGFloat height;
    if (self.yesRepairOrderModel.objname) {
        height = 0;
    } else {
        height = 30;
    }
    
    return section ==  0 ? 0 : height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    DistributionOrderHeader *header = [[DistributionOrderHeader alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];
    header.title = section == 0 ? @"工单信息" : @"分配工单";
    return header;
}



#pragma mark --lazy
- (NSArray *)dataArray {

    if (_dataArray == nil) {
        if ([self.navTitle isEqualToString:@"分配工单"]) {
            _dataArray = [DistributionTitleModel getDistributionTitleModelArray];
        } else if ([self.navTitle isEqualToString:@"受理工单"]) {
        
            _dataArray = [DistributionTitleModel getAcceptTitleModelArray];
        }
        
    }
    
    return _dataArray;
}


- (NSArray *)contentData {
    
    if (_contentData == nil) {
        
        if (self.yesRepairOrderModel.objname) {
            
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
                             @[
                                 self.yesRepairOrderModel.objname
                                 ]
                             ];
            
            if ([self.navTitle isEqualToString:@"分配工单"]) {
                self.tableView.tableFooterView.hidden = YES;
                self.tableView.userInteractionEnabled = NO;
            } else if ([self.navTitle isEqualToString:@"受理工单"]) {
                self.tableView.tableFooterView.hidden = NO;
                self.tableView.userInteractionEnabled = YES;
            }

            
            
        } else {
        
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
                                 self.yesRepairOrderModel.sysdate
                                 ],
                             @[
                                 @""
                                 ]
                             ];
        }
        
        
        
         /*
         工单系统编号：SYSID
         工单编号：ITEMID
         报修人姓名：WD_KHMC
         报修标题：WD_BXBT
         报修地址：WD_WYDZ
         报修内容：WD_BXNR
         报修电话：WD_BXDH
         紧急程度：WD_JJCD
         维修人员：WD_JDRY
         维修人电话：WD_LXDH
         报修单系统编号：WD_BYE
         工单分派时间：SENDDATE
         */
        
        
    }

    return _contentData;
}





@end
