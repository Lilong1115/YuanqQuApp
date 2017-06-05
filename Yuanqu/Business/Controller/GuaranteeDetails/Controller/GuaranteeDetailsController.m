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

@end

@implementation GuaranteeDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupGuaranteeDetailsView];
    [self setupToEstimate];
}

//设置导航
- (void)setupNav {

    self.title = self.navTitle;
}

//设置详情内容
- (void)setupGuaranteeDetailsView {

    GuaranteeDetailsView *guaranteeDetailsView = [[GuaranteeDetailsView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - FooterViewHeight) style:UITableViewStylePlain];
    
    //回调
    __weak GuaranteeDetailsController *weakSelf = self;
    guaranteeDetailsView.complaintsBlock = ^(){
        __strong GuaranteeDetailsController *strongSelf = weakSelf;
        ToGuaranteeController *ToGuaranteeVC = [[ToGuaranteeController alloc]init];
        ToGuaranteeVC.navTitle = @"我要投诉";
        [strongSelf.navigationController pushViewController:ToGuaranteeVC animated:YES];
    };
    
    //设置不同内容
    if ([self.navTitle isEqualToString:@"投诉详情"]) {
        guaranteeDetailsView.isTableData = NO;
    } else if ([self.navTitle isEqualToString:@"任务详情"]) {
        guaranteeDetailsView.isTableData = NO;
    }
    [self.view addSubview:guaranteeDetailsView];
}

//设置我要评价
- (void)setupToEstimate {

    //设置不同Y
    CGFloat estimateButtonY = 0;
    NSString *estimateStr;
    
    if ([self.navTitle isEqualToString:@"报修详情"]) {
        
        estimateButtonY += ScreenH - FooterViewHeight + FooterViewMargin;
        estimateStr = @"我要评价";
        
    } else if ([self.navTitle isEqualToString:@"投诉详情"]) {
    
        estimateButtonY += 400;
        estimateStr = @"我要评价";
    } else if ([self.navTitle isEqualToString:@"任务详情"]) {
    
        estimateButtonY += 400;
        estimateStr = @"收取任务";
    }
    
    //我要评价按钮
    UIButton *estimateButton = [[UIButton alloc]initWithFrame:CGRectMake(FooterViewMargin, estimateButtonY, ScreenW - FooterViewMargin * 2, FooterViewHeight - FooterViewMargin * 2)];
    [estimateButton setTitle:estimateStr forState:UIControlStateNormal];
    [estimateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [estimateButton setBackgroundColor:[UIColor orangeColor]];
    
    [estimateButton addTarget:self action:@selector(clickEstimateButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:estimateButton];
    
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
    
    GuaranteeEstimateController *guaranteeEstimateVC = [[GuaranteeEstimateController alloc]init];
    
    //设置标题
    if ([self.navTitle isEqualToString:@"报修详情"]) {
        
        guaranteeEstimateVC.navTitle = @"报修评价";
        
    } else if ([self.navTitle isEqualToString:@"投诉详情"]) {
        
        guaranteeEstimateVC.navTitle = @"投诉评价";
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

@end
