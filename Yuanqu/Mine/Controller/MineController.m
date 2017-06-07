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

#pragma mark --宏定义
//头视图高度
#define HeaderViewHeight 150

//cellid
static NSString * const kMineCellID = @"kMineCellID";

@interface MineController ()

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"star_selecte"] style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
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
    
#pragma mark --delegate
//脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return section == 0 ? 10 : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1 && indexPath.row == 0) {
        
        MessageController *messageVC = [[MessageController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:messageVC animated:YES];
    }
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
                                 @"picture": @"star_selecte",
                                 @"text": @"个人资料"
                                 }],
                           @[@{
                                 @"picture": @"star_selecte",
                                 @"text": @"消息"
                                 },
                             @{
                                 @"picture": @"star_selecte",
                                 @"text": @"分享"
                                 }
                             ]
                           ];
        _dataArray = array.copy;
    }
    
    return _dataArray;
}



@end
