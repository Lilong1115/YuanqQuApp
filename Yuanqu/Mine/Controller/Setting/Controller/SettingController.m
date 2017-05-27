//
//  SettingController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/26.
//  Copyright © 2017年 李龙. All rights reserved.
//

//设置
#import "SettingController.h"
#import "SuggestionController.h"

//cellid
static NSString * const kSettingCellID = @"kSettingCellID";

@interface SettingController ()

//table内容数组
@property (nonatomic, strong) NSArray *dataArray;

//退出登录
@property (nonatomic, weak) UIButton *logoutButton;
    
@end

@implementation SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTable];
    [self setupLogoutButton];
}

    
//设置nav
- (void)setupNav {
    
    self.title = @"设置";
    
}
    
//设置table
- (void)setupTable {
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSettingCellID];
    
    //设置高度
    self.tableView.rowHeight = 60;
    
    //取消弹簧
    self.tableView.bounces = NO;
    
    //取消多于的格
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}
 

//设置logout
- (void)setupLogoutButton {
    
    //退出登录
    UIButton *logoutButton = [[UIButton alloc]init];
    [logoutButton setBackgroundColor:[UIColor redColor]];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutButton.layer.cornerRadius = 10;
    logoutButton.layer.masksToBounds = YES;
    [self.view addSubview:logoutButton];
    self.logoutButton = logoutButton;
    
    //退出登录点击事件
    [logoutButton addTarget:self action:@selector(clickLogoutButton) forControlEvents:UIControlEventTouchUpInside];
    
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).mas_offset(self.tableView.rowHeight * self.dataArray.count + 60);
        make.centerX.mas_equalTo(self.tableView);
        make.width.mas_equalTo(ScreenW - 20 * 2);
        make.height.mas_equalTo(50);
    }];
}

//退出登录
- (void)clickLogoutButton {

    NSLog(@"退出登录");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
#pragma mark --dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingCellID forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
    
#pragma mark --delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SuggestionController *suggestionVC = [[SuggestionController alloc]init];
    
    [self.navigationController pushViewController:suggestionVC animated:YES];
    
}
    

#pragma mark --lazy
//table内容
- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
        
        NSArray *array = @[
                           @"意见箱",
                           @"关于"
                           ];
        _dataArray = array.copy;
    }
    
    return _dataArray;
}

@end
