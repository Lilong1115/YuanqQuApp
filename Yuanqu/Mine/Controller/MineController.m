//
//  MineController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//

//我的
#import "MineController.h"
#import "MineHeaderView.h"
#import "SettingController.h"
#import "MessageController.h"
#import "PersonalController.h"
#import "QRCodeReaderViewController.h"
#import "ScanController.h"
#import "ShareController.h"

#pragma mark --宏定义
//头视图高度
#define HeaderViewHeight 150

//cellid
static NSString * const kMineCellID = @"kMineCellID";

@interface MineController ()<QRCodeReaderDelegate, ShareDismissDelegate>

//我的头视图
@property (nonatomic, weak) MineHeaderView *headerView;

//table内容数组
@property (nonatomic, strong) NSArray *dataArray;
    
@end

@implementation MineController
    
    
//// 隐藏 TabBar
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//}
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    [self setupHeader];
    [self setupNav];
    
}

//设置nav
- (void)setupNav {

    self.title = @"我的";
    //设置
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
}

//设置点击事件
- (void)setting {

    //去设置
    SettingController *settingVC = [[SettingController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

//设置header
- (void)setupHeader {

    //我的头视图
    MineHeaderView *headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, HeaderViewHeight)];
    self.headerView = headerView;
    self.tableView.tableHeaderView = headerView;
    
    //取消多于的格
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}
    
//设置table
- (void)setupTable {

    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMineCellID];
    
    //设置高度
    self.tableView.rowHeight = 60;
    
    //取消弹簧
    self.tableView.bounces = NO;
    
}
    
#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataArray.count;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = self.dataArray[section];
    
    return array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMineCellID forIndexPath:indexPath];
    
    NSDictionary *dict = self.dataArray[indexPath.section][indexPath.row];
    
    cell.textLabel.text = dict[@"text"];
    cell.imageView.image = [UIImage imageNamed:dict[@"picture"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return section == 0 ? 10 : 0;
}
    
#pragma mark --delegate

//选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1 && indexPath.row == 0) {
        
        MessageController *messageVC = [[MessageController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:messageVC animated:YES];
    } else if (indexPath.section == 0 && indexPath.row == 0) {
    
        PersonalController *personalVC = [[PersonalController alloc]init];
        [self.navigationController pushViewController:personalVC animated:YES];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
    
        QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
        reader.navigationItem.rightBarButtonItem = nil;
        reader.navigationItem.title = @"扫一扫";
        reader.modalPresentationStyle = UIModalPresentationFormSheet;
        reader.delegate = self;
        
        [self.navigationController pushViewController:reader animated:YES];
        
    } else if (indexPath.section == 1 && indexPath.row == 1) {
    
        ShareController *shareVC = [[ShareController alloc]init];
        shareVC.delegate = self;
        shareVC.blurStyle = UIBlurEffectStyleDark;
        [self presentViewController:shareVC animated:YES completion:nil];

    }
}

//设置主控制器去dismiss弹出的视图，而不是弹出的视图自己dismiss自己
-(void)didDismissKYShareVC:(ShareController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark --reader delegate
//扫描信息
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result {
    
    ScanController *scanVC = [[ScanController alloc]init];
    scanVC.url = result;
    
    [reader.navigationController pushViewController:scanVC animated:YES];
    
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma mark --lazy
//table内容
- (NSArray *)dataArray {

    if (_dataArray == nil) {
        
        NSArray *array = @[
                           @[@{
                                 @"picture": @"personal",
                                 @"text": @"个人资料"
                                 }],
                           @[@{
                                 @"picture": @"msg",
                                 @"text": @"消息"
                                 },
                             @{
                                 @"picture": @"share",
                                 @"text": @"分享"
                                 },
                             @{
                                 @"picture": @"qe",
                                 @"text": @"扫一扫"
                                 }
                             ]
                           ];
        _dataArray = array.copy;
    }
    
    return _dataArray;
}



@end
