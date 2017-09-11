//
//  BusinessController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/26.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "BusinessController.h"
#import "BusinessCollectionView.h"
#import "BusinessFlowLayout.h"
#import "ToGuaranteeController.h"
#import "HomeModel.h"
#import "HandleController.h"
#import "LeaseController.h"
#import "RepairProcessController.h"
#import "WebViewController.h"
#import "DecorateController.h"
#import "DecorateAuditController.h"
#import "PolingController.h"
#import "QRCodeReaderViewController.h"
#import "PatrolListRegister.h"

@interface BusinessController ()<QRCodeReaderDelegate>

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, weak) BusinessCollectionView *businessView;

@end

@implementation BusinessController


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [HomeModel getMenuListModelArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupBusinessView];
    
    //业务
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appShowMenuListNotification:) name:AppShowMenuListNotification object:nil];
}

//业务
- (void)appShowMenuListNotification:(NSNotification *)noti {
    
    self.dataArray = noti.object;
    self.businessView.contentArray = self.dataArray;
    [self.businessView reloadData];
}
    
//设置nav
- (void)setupNav {
    
    self.title = @"业务";
}

//设置业务区内容
- (void)setupBusinessView {

    //flowLayout
    BusinessFlowLayout *flowLayout = [[BusinessFlowLayout alloc]init];
    flowLayout.businessColumns = 3;
    
    BusinessCollectionView *businessView = [[BusinessCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 49) collectionViewLayout:flowLayout];
    
    [HomeModel getMenuListModelArray];
    
    businessView.contentArray = self.dataArray;
    
    //点击回调
    __weak BusinessController *weakSelf = self;
    businessView.selectedBlock = ^(NSIndexPath *indexPath) {
        __strong BusinessController *strongSelf = weakSelf;
        
        HomeModel *model = strongSelf.dataArray[indexPath.item];
        
        NSInteger type = [model.type integerValue];
        
        //报修
        if (type == RepairType) {
            
            ToGuaranteeController *ToGuaranteeVC = [[ToGuaranteeController alloc]init];
            ToGuaranteeVC.navTitle = @"我要报修";
            ToGuaranteeVC.isPhoto = YES;
            ToGuaranteeVC.isAppComplaints = NO;
            [strongSelf.navigationController pushViewController:ToGuaranteeVC animated:YES];
            //工单管理
        } else if (type == RepairOrderType) {
        
            RepairProcessController *repairProcessVC = [[RepairProcessController alloc]init];
            repairProcessVC.navTitle = model.name;
            [strongSelf.navigationController pushViewController:repairProcessVC animated:YES];
            //投诉
        } else if (type == ToComplaintType) {
            
            ToGuaranteeController *ToGuaranteeVC = [[ToGuaranteeController alloc]init];
            ToGuaranteeVC.navTitle = @"我要投诉";
            ToGuaranteeVC.isPhoto = NO;
            ToGuaranteeVC.isAppComplaints = YES;
            [strongSelf.navigationController pushViewController:ToGuaranteeVC animated:YES];
            //投诉处理
        } else if (type == ComplaintType) {
            
            RepairProcessController *repairProcessVC = [[RepairProcessController alloc]init];
            repairProcessVC.navTitle = model.name;
            [strongSelf.navigationController pushViewController:repairProcessVC animated:YES];
        } else if ([model.name isEqualToString:@"任务"]) {
            
            HandleController *handleVC = [[HandleController alloc]init];
            handleVC.navTitle = @"任务工单";
            [strongSelf.navigationController pushViewController:handleVC animated:YES];
        } else if ([model.name isEqualToString:@"租赁"]) {
            
            LeaseController *leaseVC = [[LeaseController alloc]init];
            [strongSelf.navigationController pushViewController:leaseVC animated:YES];
            //会议预约
        } else if (type == ConferenceReservationType) {
        
            WebViewController *conferenceReservationVC = [[WebViewController alloc]init];
            
            conferenceReservationVC.navTitle = model.name;
            conferenceReservationVC.url = [NSString stringWithFormat:@"%@%@", model.url, model.ticket];
            [strongSelf.navigationController pushViewController:conferenceReservationVC animated:YES];
            //装修申报
        } else if (type == DecorateType) {
        
            DecorateController *decorateVC = [[DecorateController alloc]init];
            decorateVC.navTitle = model.name;
            [strongSelf.navigationController pushViewController:decorateVC animated:YES];
            
        } else if (type == AuditDecorateType) {
            
            DecorateAuditController *decorateVC = [[DecorateAuditController alloc]init];
            decorateVC.navTitle = model.name;
            [strongSelf.navigationController pushViewController:decorateVC animated:YES];
        } else if ([model.name isEqualToString:@"装修巡视"]) {
        
            QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
            reader.navigationItem.rightBarButtonItem = nil;
            reader.navigationItem.title = @"扫一扫";
            reader.modalPresentationStyle = UIModalPresentationFormSheet;
            reader.delegate = self;
            
            [self.navigationController pushViewController:reader animated:YES];
            
        }
        
    };
    
    [self.view addSubview:businessView];
    self.businessView = businessView;
}


#pragma mark --reader delegate
//扫描信息
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result {
    
    NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    
    if (dict[@"itemId"] == nil) {
        [ProgressHUD showError:@"请重新扫码"];
        return;
    }
    
    NSString *json = [NSString ObjectTojsonString:dict];
    
    PatrolListRegister *registe = [[PatrolListRegister alloc]initWithDict:@{@"basic": json}];
    
    [registe startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        NSDictionary *response = (NSDictionary *)registe.responseObject;

//        NSLog(@"%@", response);
        
        NSInteger ret = [response[@"ret"] integerValue];
        if (ret == Success_Code) {
            //主线程发送通知,更新界面
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                NSDictionary *dict = @{
                                       @"DEC_SGMC": response[@"data"][@"dec_SGMC"],
                                       @"DEC_NRMS": response[@"data"][@"dec_NRMS"],
                                       @"DEC_XCFZR": response[@"data"][@"dec_XCFZR"],
                                       @"DEC_XCLXDH": response[@"data"][@"dec_XCLXDH"],
                                       @"itemid": response[@"data"][@"itemid"]
                                       };
                
                PolingController *polingVC = [[PolingController alloc]init];
                polingVC.itemID = dict[@"itemId"];
                polingVC.dict = dict;
                [self.navigationController pushViewController:polingVC animated:YES];
                
            }];
        } else {
            [ProgressHUD showSuccess:@"提交失败"];
        }
        
        
    } failure:^(YTKBaseRequest *request) {
        // 你可以直接在这里使用 self
        [ProgressHUD showError:@"网络请求失败"];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
