//
//  GuaranteeEstimateController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//
//报修评价
#import "GuaranteeEstimateController.h"
#import "EstimateView.h"
#import "GuaranteeListModel.h"

@interface GuaranteeEstimateController ()

@property (nonatomic, weak) EstimateView *estimateView;

@end

@implementation GuaranteeEstimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    [self setupEstimateView];
    //评价 确认成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repairOrderSuccessNotification:) name:RepairOrderSuccessNotification object:nil];
}

//评价 确认成功
- (void)repairOrderSuccessNotification:(NSNotification *)noti {
    
    [ProgressHUD showSuccess:@"评价成功"];

    [[NSNotificationCenter defaultCenter] postNotificationName:EstimateSuccessNotification object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//设置Nav
- (void)setupNav {

    self.title = self.navTitle;
}

//设置评价视图
- (void)setupEstimateView {

    EstimateView *estimaeView = [[EstimateView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64)];
    
    //设置具体评价
    if ([self.navTitle isEqualToString:@"投诉评价"]) {
        estimaeView.navTitle = @"投诉评价";
    }
    
    //确认回调
    __weak GuaranteeEstimateController *weakSelf = self;
    estimaeView.comfirmBlock = ^(){
        __strong GuaranteeEstimateController *strongSelf = weakSelf;
        
//         ITEMID ，CE_PF， CE_MYD ， CE_PJNR ， RD_CLBJ，USERNAME ，USERID
        NSDictionary *dict = @{
                               @"ITEMID": strongSelf.model.sysid,
                               @"CE_PF": strongSelf.estimateView.workAttitudeStr,
                               @"CE_MYD": strongSelf.estimateView.maintenanceStr,
                               @"CE_PJNR": strongSelf.estimateView.content,
                               @"RD_CLBJ": strongSelf.model.rd_CLBJ,
                               @"USERNAME": [UserInfo account].dsoa_user_name,
                               @"USERID": [UserInfo account].dsoa_user_code
                               };
        
        [GuaranteeListModel repairSubmitWithDict:dict];
        
    };
    
    [self.view addSubview:estimaeView];
    self.estimateView = estimaeView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
