//
//  PolingController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/17.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PolingController.h"
#import "AddDecorateCell.h"
#import "AddDecorateModel.h"
//#import "DecorateModel.h"
#import "PolingModel.h"

@interface PolingController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//数据
@property (nonatomic, strong) NSArray *dataArray;
//具体数据
@property (nonatomic, strong) NSArray *contentArray;

//字段
@property (nonatomic, strong) NSArray *submitList;

@property (nonatomic, strong) UIImage *image;

@end

@implementation PolingController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.title = @"装修巡检";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addSearchSuccessNotification:) name:AddSearchSuccessNotification object:nil];

    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 48;
    [self setupLogo];
    
    [self setupFooter];
    
}



- (void)setupFooter {
    
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    
    //提交
    UIButton *submitButton = [self creatButtonWithTitle:@"提交" backgroundColor:[UIColor colorWithHexString:@"#4491fa"]];
    submitButton.frame = CGRectMake(8, 8, (ScreenW - 8 * 2), 60 - 8 * 2);
    [footer addSubview:submitButton];
    
    
    [submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableFooterView = footer;
    
}

#pragma mark --点击事件
- (void)submit {
    
    if (!self.image) {
        [ProgressHUD showError:@"请添加现场照片"];
        return;
    }
    
    JCAlertController *alert = [JCAlertController alertWithTitle:@"提交数据" message:@"您确认要提交数据吗?"];
    
    [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
    [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        [ProgressHUD show:@"正在提交..."];
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < self.dataArray.count - 1; i++) {
                
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                
                AddDecorateCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
                if (cell.contentStr.length == 0) {
                    [ProgressHUD showError:@"请填写全部信息"];
                    return ;
                }
                dictM[self.submitList[i]] = cell.contentStr;
                
            }
            
            NSData *imgData = UIImageJPEGRepresentation(self.image, 1.0f);
            NSString *encodedImgStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            [PolingModel submitDataWithDict:dictM.copy imgStr:encodedImgStr itemId:self.dict[@"itemid"]];
            
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            
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


- (void)addSearchSuccessNotification:(NSNotification *)noti {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
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
    //@{
//    @"DEC_SGMC": response[@"data"][@"dec_SGMC"],
//    @"DEC_NRMS": response[@"data"][@"dec_NRMS"],
//    @"DEC_XCFZR": response[@"data"][@"dec_XCFZR"],
//    @"DEC_XCLXDH": response[@"data"][@"dec_XCLXDH"],
//    @"itemid": response[@"data"][@"itemid"]
//};
    if (indexPath.row == 1) {
        cell.content = [self getCurrentDate];
        cell.listType = 1;
    } else if (indexPath.row == 0) {
        cell.content = self.dict[@"DEC_SGMC"];
        cell.listType = 1;
    } else if (indexPath.row == 2) {
        cell.content = [self getWeekDate];
        cell.listType = 1;
    } else if (indexPath.row == 4) {
        cell.content = self.dict[@"DEC_NRMS"];
        cell.listType = 1;
    } else if (indexPath.row == 8) {
        cell.content = self.dict[@"DEC_XCFZR"];
        cell.listType = 0;
    } else if (indexPath.row == 9) {
        cell.content = self.dict[@"DEC_XCLXDH"];
        cell.listType = 0;
    } else if (indexPath.row == 7) {
        cell.content = [UserInfo account].dsoa_user_name;
        cell.listType = 1;
    }
    
    __weak PolingController *weakSelf = self;
    cell.clickFile = ^(NSIndexPath *indexPath) {
        __strong PolingController *strongSelf = weakSelf;
        [strongSelf callCamera];
    };
    
    return cell;
}


//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == self.dataArray.count - 1) {
        return 108;
    } else {
    
        return 48;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --lazy
- (NSArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [AddDecorateModel getSearchArray];
    }
    
    return _dataArray;
}

- (NSArray *)submitList {

    if (_submitList == nil) {
        _submitList = [PolingModel getSubmitList];
    }
    return _submitList;
}


//获取当前时间
- (NSString *)getCurrentDate {

    NSDate *date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init ];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

- (NSString *)getWeekDate {

    NSArray *arrWeek = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger unitFlags = NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitMonth;
    
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%ld月份第%ld周%@", [comps month], [comps weekOfMonth], arrWeek[[comps weekday] - 1]];
    
}


//打开相机
- (void)callCamera {

    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage *newImage = [UIImage imageWithImage:image scaledToSize:CGSizeMake(image.size.width * 0.1, image.size.height * 0.1)];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        self.image = newImage;
        ((AddDecorateCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]]).image = image;
    }];
    
}


//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
