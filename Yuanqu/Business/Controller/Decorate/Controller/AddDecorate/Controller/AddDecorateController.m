//
//  AddDecorateController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "AddDecorateController.h"
#import "AddDecorateCell.h"
#import "AddDecorateModel.h"
#import "DecorateModel.h"
#import "FileManagementController.h"
#import "FileManagementModel.h"

static NSString * const kAddDecorateCellID = @"kAddDecorateCellID";
@interface AddDecorateController ()

//数据
@property (nonatomic, strong) NSArray *dataArray;
//具体数据
@property (nonatomic, strong) NSArray *contentArray;
//字段列表
@property (nonatomic, strong) NSArray *submitList;


@end

@implementation AddDecorateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [AddDecorateModel getAddDecorateArray];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGetRenovatioSuccessNotification:) name:AppGetRenovatioSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRenovationSuccessNotification:) name:AddRenovationSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addModifySuccessNotification:) name:AddModifySuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fileSelectedSuccessNotification:) name:FileSelectedSuccessNotification object:nil];
    
//    [self.tableView registerClass:[AddDecorateCell class] forCellReuseIdentifier:kAddDecorateCellID];
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 48;
//    [self setupLogo];
    
    [self setupFooter];
    
}


- (void)fileSelectedSuccessNotification:(NSNotification *)noti {

    FileManagementModel *model = noti.object;
    NSIndexPath *indexPath = noti.userInfo[@"indexPath"];
    AddDecorateCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.content = model.fileName;
//    [self.tableView reloadData];
    
}


- (void)setupFooter {

    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    
    //提交
    UIButton *submitButton = [self creatButtonWithTitle:@"提交" backgroundColor:[UIColor colorWithHexString:@"#4491fa"]];
    submitButton.frame = CGRectMake(8, 8, (ScreenW - 8 * 3) / 2, 60 - 8 * 2);
    [footer addSubview:submitButton];
    
    //清除
    UIButton *clearButton = [self creatButtonWithTitle:@"清除" backgroundColor:[UIColor orangeColor]];
    clearButton.frame = CGRectMake(8 * 2 + (ScreenW - 8 * 3) / 2, 8, (ScreenW - 8 * 3) / 2, 60 - 8 * 2);
    [footer addSubview:clearButton];
    
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [clearButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = footer;
    
    if (self.listType == 0) {
        self.tableView.tableFooterView.hidden = NO;
    } else {
        
        self.tableView.tableFooterView.hidden = YES;
    }
    
}

#pragma mark --点击事件
- (void)submit {

    JCAlertController *alert = [JCAlertController alertWithTitle:@"提交数据" message:@"您确认要提交数据吗?"];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        [ProgressHUD show:@"正在提交..."];
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < self.dataArray.count; i++) {
                
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                
                AddDecorateCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
                if (cell.contentStr.length == 0) {
                    [ProgressHUD showError:@"请填写全部信息"];
                    return ;
                }
                
                dictM[self.submitList[i]] = cell.contentStr;
                
            }
            
            if (self.model) {
                dictM[@"SYSID"] = self.model.sysid;
                [DecorateModel modifyRenovationWith:dictM.copy];
            } else {
                [DecorateModel addRenovationWith:dictM.copy];
            }
            
            
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
        });
    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
    
}

- (void)clear {

    JCAlertController *alert = [JCAlertController alertWithTitle:@"清除数据" message:@"您确认要清除数据吗?"];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        [ProgressHUD show:@"正在清除..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self clearAllData];
            
            [ProgressHUD showSuccess:@"清除成功"];
            
        });
    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
    
}


- (void)clearAllData {

    for (int i = 0; i < self.dataArray.count; i++) {
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        
        AddDecorateCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        [cell clear];
    }
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
}

- (UIButton *)creatButtonWithTitle:(NSString *)title backgroundColor:(UIColor *)backgroundColor {

    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:backgroundColor];
    return button;
}


- (void)addModifySuccessNotification:(NSNotification *)noti {

    [ProgressHUD showSuccess:@"修改成功"];
    
}

- (void)addRenovationSuccessNotification:(NSNotification *)noti {

    JCAlertController *alert = [JCAlertController alertWithTitle:@"提示" message:[NSString stringWithFormat:@"请在通过电脑访问%@上传材料", BaseUrl]];

    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        [ProgressHUD showSuccess:@"提交成功"];
        [self clearAllData];

    }];
    
    [self jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
    
    
}

////获取列表
//- (void)appGetRenovatioSuccessNotification:(NSNotification *)noti {
//
//    self.dataArray = noti.object;
//    [self.tableView reloadData];
//    
//}


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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    AddDecorateCell *cell = [tableView dequeueReusableCellWithIdentifier:kAddDecorateCellID forIndexPath:indexPath];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell
    AddDecorateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //出列可重用的cell
    if (cell == nil) {
         cell = [[AddDecorateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.model = self.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    cell.listType = self.listType;
    
    //选中文件
    __weak AddDecorateController *weakSelf = self;
    cell.clickFile = ^(NSIndexPath *indexPath) {
        __strong AddDecorateController *strongSelf = weakSelf;
        [strongSelf selectFileWithIndexPath:indexPath];
    };
    
    if (self.model) {
        if (indexPath.row > self.contentArray.count - 1) {
            cell.content = @"";
        } else {
            cell.content = self.contentArray[indexPath.row];
        }
    }

    return cell;
}


- (void)selectFileWithIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(ScreenW, ScreenH);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    FileManagementController *fileManagementVC = [[FileManagementController alloc]initWithCollectionViewLayout:flowLayout];
    fileManagementVC.indexPath = indexPath;
    [self.navigationController pushViewController:fileManagementVC animated:YES];
}


////设置高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return [tableView fd_heightForCellWithIdentifier:kAddDecorateCellID cacheByKey:indexPath configuration:^(id cell) {
//        
//        ((AddDecorateCell *)cell).model = self.dataArray[indexPath.row];
//        
//    }];
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --lazy
- (NSArray *)dataArray {

    if (_dataArray == nil) {
        _dataArray = [AddDecorateModel getAddDecorateArray];
    }
    
    return _dataArray;
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
                               self.model.dec_YJWCSJ
                               ];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:arrayData];
//        NSArray *array = [self.model.dec_FUJIAN_NAME componentsSeparatedByString:@","];
        
//        [arrayM addObjectsFromArray:array];
        
        _contentArray = arrayM.copy;

    }
    return _contentArray;
}


- (NSArray *)submitList {

    if (_submitList == nil) {
        _submitList = [DecorateModel getSubmitList];
    }
    
    return _submitList;
}




//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
