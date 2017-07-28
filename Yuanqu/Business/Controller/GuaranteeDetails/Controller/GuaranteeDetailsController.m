//
//  GuaranteeDetailsController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//报修详情
#import "GuaranteeDetailsController.h"
#import "GuaranteeDetailsView.h"
#import "GuaranteeEstimateController.h"
#import "ToGuaranteeController.h"
#import "OptionsView.h"
#import "GuaranteeListModel.h"
#import "LogModel.h"
#import "LogBaseModel.h"

#pragma mark --宏定义
//底部视图高度
#define FooterViewHeight 80
//间距
#define FooterViewMargin 15

@interface GuaranteeDetailsController ()

//维修确认
@property (nonatomic, strong) UIView *maintenanceConfirmView;
//是否收费
@property (nonatomic, strong) OptionsView *optionsView;

@property (nonatomic, weak) GuaranteeDetailsView *guaranteeDetailsView;

@property (nonatomic, weak) UIButton *estimateButton;

@end

@implementation GuaranteeDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupGuaranteeDetailsView];
    [self setupToEstimate];
    
    //通知 确认成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repairOrderSuccessNotification:) name:RepairOrderSuccessNotification object:nil];
    
    //评价成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(estimateSuccessNotification:) name:EstimateSuccessNotification object:nil];
    
    //log列表通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appLogListSuccessNotification:) name:AppLogListSuccessNotification object:nil];
}

//log列表通知
- (void)appLogListSuccessNotification:(NSNotification *)noti {
    
    //刷新
    self.guaranteeDetailsView.dataArray = noti.object;
    [self.guaranteeDetailsView reloadData];
}

//评价成功
- (void)estimateSuccessNotification:(NSNotification *)noti {
    
    //变成1
    self.model.rd_CLBJ = @"2";
    self.estimateButton.hidden = YES;
    
}

//通知 确认成功
- (void)repairOrderSuccessNotification:(NSNotification *)noti {
    
    [ProgressHUD showSuccess:@"确认成功"];
    [self.estimateButton setTitle:@"我要评价" forState:UIControlStateNormal];
    //变成1
    self.model.rd_CLBJ = @"1";
}

//设置导航
- (void)setupNav {

    self.title = self.navTitle;
}

//设置详情内容
- (void)setupGuaranteeDetailsView {

    GuaranteeDetailsView *guaranteeDetailsView = [[GuaranteeDetailsView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - FooterViewHeight) style:UITableViewStylePlain];
    guaranteeDetailsView.isComplaints = self.isComplaints;
    
    
    if ([self.navTitle isEqualToString:@"投诉详情"] && self.isComplaints == YES) {
        [LogBaseModel getComplaintLogModelArrayWithDict:@{@"SYSID": self.model.sysid}];
    } else if ([self.navTitle isEqualToString:@"投诉详情"] && self.isComplaints == NO) {
        [LogBaseModel getComplaintLogModelArrayWithDict:@{@"SYSID": self.model.SYSID}];
    } else {
    
        [LogBaseModel getLogModelArrayWithDict:@{
                                                 @"SYSID": self.model.sysid
                                                 }];
    }
    
    
    
    //回调
    __weak GuaranteeDetailsController *weakSelf = self;
    guaranteeDetailsView.complaintsBlock = ^(){
        __strong GuaranteeDetailsController *strongSelf = weakSelf;
        ToGuaranteeController *ToGuaranteeVC = [[ToGuaranteeController alloc]init];
        ToGuaranteeVC.navTitle = @"我要投诉";
        ToGuaranteeVC.model = strongSelf.model;
        ToGuaranteeVC.isPhoto = NO;
        ToGuaranteeVC.isAppComplaints = NO;
        [strongSelf.navigationController pushViewController:ToGuaranteeVC animated:YES];
    };
    
    //设置不同内容
    if ([self.navTitle isEqualToString:@"投诉详情"]) {
        guaranteeDetailsView.isTableData = NO;
    } else if ([self.navTitle isEqualToString:@"任务详情"]) {
        guaranteeDetailsView.isTableData = NO;
    }
    [self.view addSubview:guaranteeDetailsView];
    self.guaranteeDetailsView = guaranteeDetailsView;
    guaranteeDetailsView.model = self.model;
}


//- (void)setModel:(GuaranteeListModel *)model {
//    
//    _model = model;
////    self.guaranteeDetailsView.model = model;
//}

//设置我要评价
- (void)setupToEstimate {

    //设置不同Y
    CGFloat estimateButtonY = 0;
    NSString *estimateStr;
    
//    if ([self.navTitle isEqualToString:@"报修详情"] || self.isComplaints == YES || self.isComplaints == NO) {
                
        estimateButtonY += ScreenH - FooterViewHeight + FooterViewMargin;
        if ([self.model.rd_CLBJ integerValue] == 0) {
            estimateStr = @"我要确认";
        } else if ([self.model.rd_CLBJ integerValue] == 1) {
            estimateStr = @"我要评价";
        } else if ([self.model.rd_CLBJ integerValue] > 1) {
            return;
        }
        
        
//    } else if ([self.navTitle isEqualToString:@"任务详情"]) {
//    
//        estimateButtonY += 320;
//        estimateStr = @"收取任务";
//    }
    
//    else if ([self.navTitle isEqualToString:@"投诉详情"] && self.isComplaints == NO) {
//        //
//        //        estimateButtonY += 320;
//        //        estimateStr = @"我要评价";
//    }
    
    //我要评价按钮
    UIButton *estimateButton = [[UIButton alloc]initWithFrame:CGRectMake(FooterViewMargin, estimateButtonY, ScreenW - FooterViewMargin * 2, FooterViewHeight - FooterViewMargin * 2)];
    [estimateButton setTitle:estimateStr forState:UIControlStateNormal];
    [estimateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [estimateButton setBackgroundColor:[UIColor orangeColor]];
    
    [estimateButton addTarget:self action:@selector(clickEstimateButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:estimateButton];
    self.estimateButton = estimateButton;
    
}

//我要评价/收取任务/任务确认
- (void)clickEstimateButton:(UIButton *)sender {

    if ([self.navTitle isEqualToString:@"任务详情"]) {
        CGRect rect = sender.frame;
        rect.origin.y = 520;
        //动画
        [UIView animateWithDuration:0.5 animations:^{
            sender.frame = rect;
            self.maintenanceConfirmView.alpha = 1;
            self.optionsView.alpha = 1;
            [sender setTitle:@"任务确认" forState:UIControlStateNormal];
        }];;
        return;
    }
    
    if ([self.model.rd_CLBJ integerValue] == 0) {
        //ITEMID  ，USERID  ，USERNAME ，RD_CLBJ
        NSDictionary *dict = @{
                               @"ITEMID": self.model.sysid,
                               @"USERID": [UserInfo account].dsoa_user_code,
                               @"USERNAME": [UserInfo account].dsoa_user_name,
                               @"RD_CLBJ": self.model.rd_CLBJ
                               };
        
        if (self.isComplaints == YES) {
            [GuaranteeListModel complainSubmitWithDict:dict];
        } else {
            [GuaranteeListModel repairSubmitWithDict:dict];
        }
        return;
    }
    
    GuaranteeEstimateController *guaranteeEstimateVC = [[GuaranteeEstimateController alloc]init];
    
    //设置标题
    if ([self.navTitle isEqualToString:@"报修详情"]) {
        
        guaranteeEstimateVC.navTitle = @"报修评价";
        guaranteeEstimateVC.model = self.model;
        guaranteeEstimateVC.isComplaints = NO;
        
    } else if ([self.navTitle isEqualToString:@"投诉详情"]) {
        
        guaranteeEstimateVC.navTitle = @"投诉评价";
        guaranteeEstimateVC.model = self.model;
        guaranteeEstimateVC.isComplaints = YES;
    }
    
    [self.navigationController pushViewController:guaranteeEstimateVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --lazy
- (UIView *)maintenanceConfirmView {

    if (_maintenanceConfirmView == nil) {
        _maintenanceConfirmView = [[UIView alloc]initWithFrame:CGRectMake(0, 400, ScreenW, FooterViewHeight - FooterViewMargin * 2)];
        _maintenanceConfirmView.backgroundColor = [UIColor colorWithHexString:@"#4491fa"];
        UILabel *maintenanceConfirmLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, ScreenW - 8 * 2, FooterViewHeight - FooterViewMargin * 2)];
        maintenanceConfirmLabel.text = @"维修确认";
        maintenanceConfirmLabel.textColor = [UIColor whiteColor];
        [_maintenanceConfirmView addSubview:maintenanceConfirmLabel];
        [self.view addSubview:_maintenanceConfirmView];
        _maintenanceConfirmView.alpha = 0;
    }
    return _maintenanceConfirmView;
}

- (OptionsView *)optionsView {

    if (_optionsView == nil) {
        _optionsView = [[OptionsView alloc]initWithFrame:CGRectMake(FooterViewMargin * 2, 400 + 60, ScreenW - FooterViewMargin * 4, 40)];
        _optionsView.alpha = 0;
        [self.view addSubview:_optionsView];
    }
    return _optionsView;
}


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
