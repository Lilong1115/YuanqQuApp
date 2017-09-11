//
//  AuditDecorateController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/7.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AuditDecorateController.h"
#import "AddDecorateCell.h"
#import "AddDecorateModel.h"
#import "DecorateModel.h"
#import "AuditDecorateCell.h"
#import "AuditModel.h"

static NSString * const kAddDecorateCellID = @"kAddDecorateCellID";
@interface AuditDecorateController ()

//数据
@property (nonatomic, strong) NSArray *dataArray;
//具体数据
@property (nonatomic, strong) NSArray *contentArray;
//字段列表
@property (nonatomic, strong) NSArray *submitList;
//审核结果
@property (nonatomic, strong) NSMutableArray *resultList;

@end

@implementation AuditDecorateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AuditModel getAuditArrayWithDict:@{
                                        @"SYSID": self.model.sysid
                                        }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAuditSuccessNotification:) name:AddAuditSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appCheckListSuccessNotification:) name:AppCheckListSuccessNotification object:nil];
    
//    [self.tableView registerClass:[AddDecorateCell class] forCellReuseIdentifier:kAddDecorateCellID];
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 48;
    [self setupLogo];
    
    [self setupFooter];
    
}


//审核结果
- (void)appCheckListSuccessNotification:(NSNotification *)noti {

    [self.resultList addObjectsFromArray:noti.object];
    [self.tableView reloadData];
    
}



- (void)setupFooter {
    
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    
    //提交
    UIButton *submitButton = [self creatButtonWithTitle:@"审核" backgroundColor:[UIColor colorWithHexString:@"#4491fa"]];
    submitButton.frame = CGRectMake(8, 8, ScreenW - 8 * 2, 60 - 8 * 2);
    [footer addSubview:submitButton];
    
    
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = footer;
    
    if (self.listType == 4) {
        self.tableView.tableFooterView.hidden = YES;
    } else {
        
        self.tableView.tableFooterView.hidden = NO;
    }
    
}

#pragma mark --点击事件
- (void)submit {
    
    JCAlertController *alert = [JCAlertController alertWithTitle:@"审核数据" message:@"您确认要审核数据吗?"];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        [ProgressHUD show:@"正在审核..."];
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < self.submitList.count; i++) {
                
                if (i < ((NSArray *)self.dataArray[2]).count) {
                    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                    
                    AddDecorateCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:2]];
                    
                    if (cell.contentStr.length == 0) {
                        [ProgressHUD showError:@"请填写全部信息"];
                        return ;
                    }
                    
                    dictM[self.submitList[i]] = cell.contentStr;
                } else {
                    if (i == ((NSArray *)self.dataArray[2]).count) {
                        dictM[self.submitList[i]] = [UserInfo account].dsoa_user_code;
                    } else if (i == ((NSArray *)self.dataArray[2]).count + 1) {
                    
                        dictM[self.submitList[i]] = self.model.sysid;
                    }
                }
                
                
            }
            
            [AuditModel addAuditSubmitWithDict:dictM.copy];
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:((NSArray *)self.dataArray[2]).count - 1 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        });
    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
    
}


- (UIButton *)creatButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor {
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    return button;
}


- (void)addAuditSuccessNotification:(NSNotification *)noti {
    
    [ProgressHUD showSuccess:@"审核成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
}



//设置logo
- (void)setupLogo {
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, 220)];
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    //    [logo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@vi/lanm/%@.png", BaseUrl, [UserInfo account].dsoa_user_suoscode]]];
    
    [logo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@vi/lanm/%@.png", BaseUrl, [UserInfo account].dsoa_user_suoscode]] placeholderImage:[UIImage imageNamed:@"meinv"]];
    [header addSubview:logo];
    
    self.tableView.tableHeaderView = header;
    
}

#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSArray *)self.dataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    AddDecorateCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddDecorateCellID forIndexPath:indexPath];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
    if (cell == nil) {
        
        
        if (indexPath.section == 0) {
            cell = [[AddDecorateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            ((AddDecorateCell *)cell).model = self.dataArray[indexPath.section][indexPath.row];
            ((AddDecorateCell *)cell).indexPath = indexPath;
            ((AddDecorateCell *)cell).content = self.contentArray[indexPath.row];
            ((AddDecorateCell *)cell).listType = RenovationSubmittedType;
        } else if (indexPath.section == 1) {
        
            cell = [[AuditDecorateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            ((AuditDecorateCell *)cell).model = self.resultList[indexPath.row];
            
        } else {
        
            cell = [[AddDecorateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            ((AddDecorateCell *)cell).model = self.dataArray[indexPath.section][indexPath.row];
            ((AddDecorateCell *)cell).indexPath = indexPath;
            
            if (indexPath.row == 2) {
                ((AddDecorateCell *)cell).content = [UserInfo account].dsoa_dept_name;
                ((AddDecorateCell *)cell).listType = RenovationSubmittedType;
            } else if (indexPath.row == 3) {
                ((AddDecorateCell *)cell).content = [UserInfo account].dsoa_user_name;
                ((AddDecorateCell *)cell).listType = RenovationSubmittedType;
            } else if (indexPath.row == 0) {
                ((AddDecorateCell *)cell).listType = RenovationSubmittedType;
            }
            
        }
        
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        if (self.resultList.count == 0) {
            return 0;
        } else {
            return 48;
        }
    }
    
    return 48;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return @"申报信息";
    } else if (section == 1) {
        return @"审核结果";
    } else {
        return @"申报审核";
    }
}



//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0 || indexPath.section == 2) {
        
        return 48;
    } else {

        return 150;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --lazy
- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        if (self.listType == 3) {
            _dataArray = @[[AddDecorateModel getAddDecorateArray], self.resultList, [AddDecorateModel getAuditDecorateArray]];
        } else {
        
            _dataArray = @[[AddDecorateModel getAddDecorateArray], self.resultList];
        }
        
        
    }
    
    return _dataArray;
}

- (NSMutableArray *)resultList {

    if (_resultList == nil) {
        _resultList = [NSMutableArray array];
    }
    return _resultList;
}

- (NSArray *)contentArray {
    
    if (_contentArray == nil) {
        
        NSArray *arrayData = @[
                               //客户名称：	DEC_KHMC;
                               self.model.dec_KHMC,
                               //单元名称：	DEC_DYMC;
                               self.model.dec_DYMC,
                               //施工名称：	DEC_SGMC;
                               self.model.dec_SGMC,
                               //位置面积：	DEC_WZMJ;
                               self.model.dec_WZMJ,
                               //客户联系：	DEC_KHLX;
                               self.model.dec_KHLX,
                               //联系电话：	DEC_LXDH;
                               self.model.dec_LXDH,
                               //内容描述：	DEC_NRMS;
                               self.model.dec_NRMS,
                               //施工单位：	DEC_SGDW;
                               self.model.dec_SGDW,
                               //单位电话：	DEC_DWDH;
                               self.model.dec_DWDH,
                               //现场负责人：DEC_XCFZR;
                               self.model.dec_XCFZR,
                               //现场联系人电话：DEC_XCLXDH;
                               self.model.dec_XCLXDH,
                               //施工人数：	DEC_SGRS;
                               self.model.dec_SGRS,
                               //进场日期：	DEC_JCRQ;
                               self.model.dec_JCRQ,
                               //预计完成时间：DEC_YJWCSJ;
                               self.model.dec_YJWCSJ,
                               //延长期限：	DEC_YCQX;
                               self.model.dec_YCQX
                               ];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:arrayData];
        
        _contentArray = arrayM.copy;
        
    }
    return _contentArray;
}


- (NSArray *)submitList {

    if (_submitList == nil) {
        _submitList = [AuditModel getAuditSubmitList];
    }
    return _submitList;
}


//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
