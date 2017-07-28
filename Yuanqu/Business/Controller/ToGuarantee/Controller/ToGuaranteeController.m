//
//  ToGuaranteeController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ToGuaranteeController.h"
#import "ScrollToSwitchView.h"
#import "ScrollToView.h"
#import "WriteGuaranteeView.h"
#import "DemandGuaranteeView.h"
#import "GuaranteeDetailsController.h"
#import "GuaranteeDetailsModel.h"
#import "GuaranteeListModel.h"

#pragma mark --宏定义
//上部滚动高度
#define ScrollToSwitchViewHeight 40
#define ScrollToSwitchViewWidth 300

@interface ToGuaranteeController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

//上部滚动视图
@property (nonatomic, weak) ScrollToSwitchView *scrollToSwitchView;
//下部滚动视图
@property (nonatomic, weak) ScrollToView *scrollToView;

//填写报修
@property (nonatomic, weak) WriteGuaranteeView *writeGuaranteeView;
//报修列表
@property (nonatomic, weak) DemandGuaranteeView *demandGuaranteeView;

//获取图片
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) UIActionSheet *actionSheet;

//报修图片
@property (nonatomic, strong) UIImage *guaranteeImage;

//列表数据
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ToGuaranteeController


- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    
    if ([self.navTitle isEqualToString:@"我要报修"]) {
        [GuaranteeListModel getGuaranteeListModelArray];
    } else if ([self.navTitle isEqualToString:@"我要投诉"]) {
        if (self.isAppComplaints == YES) {
            [GuaranteeListModel getAppComplaintsListModelArray];
        } else {
            [GuaranteeListModel getComplaintsListModelArray];
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupNav];
    [self setupScrollToSwitchView];
    [self setupScrollToView];
    [self setupNotification];
    
    
}

- (void)setupNotification {

    //注册通知
    //报修提交成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRepairSuccessNotification:) name:AddRepairSuccessNotification object:nil];
    //获取报修列表成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appRepairListSuccessNotification:) name:AppRepairListSuccessNotification object:nil];
    //投诉提交
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(complaintsSuccessNotification:) name:ComplaintsSuccessNotification object:nil];
    //我要投诉提交
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(complaintsSuccessNotification:) name:AppComplaintsSuccessNotification object:nil];
    //投诉列表获取成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(complaintListSuccessNotification:) name:ComplaintListSuccessNotification object:nil];
    //我要投诉列表获取成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(complaintListSuccessNotification:) name:AppComplainListSuccessNotification object:nil];
    
}

//投诉列表获取成功
- (void)complaintListSuccessNotification:(NSNotification *)noti {

    self.dataArray = noti.object;
    
    //设置数据源
    self.demandGuaranteeView.dataArray = self.dataArray;
    
}

//投诉提交
- (void)complaintsSuccessNotification:(NSNotification *)noti {

    [ProgressHUD showSuccess:@"投诉成功"];
    [self clearData];
}

//获取报修列表成功的通知
- (void)appRepairListSuccessNotification:(NSNotification *)noti {

    self.dataArray = noti.object;
    
    //设置数据源
    self.demandGuaranteeView.dataArray = self.dataArray;
}

//报修提交成功的通知
- (void)addRepairSuccessNotification:(NSNotification *)noti {

    [self clearData];
    
}

//设置nav
- (void)setupNav {
    
    self.title = self.navTitle;
    
}

//设置ScrollToSwitchView
- (void)setupScrollToSwitchView {
    
    //不设置这个参数,cell不走item方法
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ScrollToSwitchView *scrollToSwitchView = [[ScrollToSwitchView alloc]initWithFrame:CGRectMake(0, 64, ScrollToSwitchViewWidth, ScrollToSwitchViewHeight)];
    //设置滚动不同内容
    if ([self.navTitle isEqualToString:@"我要报修"]) {
        scrollToSwitchView.contentArray = @[@"填写报修", @"查询报修"];
    } else if ([self.navTitle isEqualToString:@"我要投诉"]) {
        scrollToSwitchView.contentArray = @[@"填写投诉", @"查询投诉"];
    }
    
    //滚动回调
    //防止循环引用
    __weak ToGuaranteeController *weakSelf = self;
    scrollToSwitchView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong ToGuaranteeController *strongSelf = weakSelf;
        
        [strongSelf.scrollToView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    };
    
    [self.view addSubview:scrollToSwitchView];
    self.scrollToSwitchView = scrollToSwitchView;
}

//设置我要报修具体内容
- (void)setupScrollToView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(ScreenW, ScreenH - ScrollToSwitchViewHeight - 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    ScrollToView *scrollToView = [[ScrollToView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight + 10 + 64, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) collectionViewLayout:flowLayout];
    
    //填写报修视图
    WriteGuaranteeView *writeGuaranteeView = [[WriteGuaranteeView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64)];
    writeGuaranteeView.isPhoto = self.isPhoto;
    self.writeGuaranteeView = writeGuaranteeView;
    //防止循环引用
    __weak ToGuaranteeController *weakSelf = self;
    //选取相册回调
    writeGuaranteeView.selectedImageBlock = ^(){
        __strong ToGuaranteeController *strongSelf = weakSelf;
        [strongSelf callActionSheetFunc];
    };
    //清除
    writeGuaranteeView.clearBlock = ^(){
        __strong ToGuaranteeController *strongSelf = weakSelf;
        [strongSelf clearData];
    };
    //提交
    writeGuaranteeView.uploadBlock = ^(NSDictionary *dict){
        __strong ToGuaranteeController *strongSelf = weakSelf;
        
        if ([strongSelf judgeValuesWithDict:dict]) {
            [ProgressHUD showError:@"请填写信息"];
            return;
        };
        
        JCAlertController *alert = [JCAlertController alertWithTitle:@"提交" message:@"确认提交?"];
        
        [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
        [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
        
            [ProgressHUD show:@"正在提交..."];
            
            if ([strongSelf.navTitle isEqualToString:@"我要报修"]) {
                [strongSelf uploadDataWithDict:dict];
            } else if ([strongSelf.navTitle isEqualToString:@"我要投诉"]) {
                if (strongSelf.isAppComplaints == YES) {
                    
                    [strongSelf uploadDataWithDict:dict];
                } else {
                    [strongSelf uploadComplaintsDataWithDict:dict];
                }
                
            }
            
        }];
        
        [strongSelf jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];

    };
    
    //查询保修视图
    DemandGuaranteeView *demandGuaranteeView = [[DemandGuaranteeView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64)];
    self.demandGuaranteeView = demandGuaranteeView;
    
    if ([self.navTitle isEqualToString:@"我要报修"]) {
        [GuaranteeListModel getGuaranteeListModelArray];
    } else if ([self.navTitle isEqualToString:@"我要投诉"]) {
        if (self.isAppComplaints == YES) {
            [GuaranteeListModel getAppComplaintsListModelArray];
        } else {
            [GuaranteeListModel getComplaintsListModelArray];
        }
        
    }
    
    
    
    //报修详情回调
    demandGuaranteeView.clickDetailsBlock = ^(NSIndexPath *indexPath){
        
        __strong ToGuaranteeController *strongSelf = weakSelf;
        
        GuaranteeDetailsController *guaranteeDetailsVC = [[GuaranteeDetailsController alloc]init];
        guaranteeDetailsVC.model = strongSelf.dataArray[indexPath.row];
        
        //设置不同内容
        if ([strongSelf.navTitle isEqualToString:@"我要报修"]) {
            guaranteeDetailsVC.navTitle = @"报修详情";
            guaranteeDetailsVC.isComplaints = NO;
        } else if ([strongSelf.navTitle isEqualToString:@"我要投诉"] && strongSelf.isAppComplaints == YES) {
            guaranteeDetailsVC.navTitle = @"投诉详情";
            guaranteeDetailsVC.isComplaints = YES;
        } else if ([strongSelf.navTitle isEqualToString:@"我要投诉"] && strongSelf.isAppComplaints == NO) {
        
            guaranteeDetailsVC.navTitle = @"投诉详情";
            guaranteeDetailsVC.isComplaints = NO;
            
        }
        
        [strongSelf.navigationController pushViewController:guaranteeDetailsVC animated:YES];
    };
    
    //下拉刷新
    demandGuaranteeView.refreshBlock = ^(){
        
        __strong ToGuaranteeController *strongSelf = weakSelf;
        if ([strongSelf.navTitle isEqualToString:@"我要报修"]) {
            [GuaranteeListModel getGuaranteeListModelArray];
        } else if ([strongSelf.navTitle isEqualToString:@"我要投诉"]) {
            if (strongSelf.isAppComplaints == YES) {
                [GuaranteeListModel getAppComplaintsListModelArray];
            } else {
                [GuaranteeListModel getComplaintsListModelArray];
            }
            
        }
        
    };
    
    scrollToView.contentArray = @[writeGuaranteeView, demandGuaranteeView];
    //滚动回调
    scrollToView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong ToGuaranteeController *strongSelf = weakSelf;
        
        [strongSelf.scrollToSwitchView scrollToViewWithIndexPath:indexPath];
    };
    
    [self.view addSubview:scrollToView];
    self.scrollToView = scrollToView;
    
}

//判断字典是否为空
- (BOOL)judgeValuesWithDict:(NSDictionary *)dict {

    __block BOOL judge = NO;
    
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        
        if ([obj isEqualToString:@""]) {
            judge = YES;
        }
    }];
    
    
    return judge;
}

//提交投诉数据
- (void)uploadComplaintsDataWithDict:(NSDictionary *)dict {
    
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"ITEMID"] = self.model.sysid;
    dictM[@"CD_TSXM"] = dict[@"RD_BXXM"];
    dictM[@"CD_LXSJ"] = dict[@"RD_BXDH"];
    dictM[@"CD_LXDZ"] = dict[@"RD_SFZB"];
    dictM[@"CD_TSBT"] = dict[@"RD_BXBT"];
    dictM[@"CD_NRMS"] = dict[@"RD_BXNR"];
    dictM[@"USERNAME"] = [UserInfo account].dsoa_user_name;
    dictM[@"USERID"] = [UserInfo account].dsoa_user_code;
    dictM[@"RD_CLBJ"] = @"2";
    [GuaranteeDetailsModel uploadComplaintsDataWithDict:dictM.copy];
    
    
}

//提交报修数据
- (void)uploadDataWithDict:(NSDictionary *)dict {
    
        
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    //用户姓名 admin
    dictM[@"USERNAME"] = [UserInfo account].dsoa_user_name;
    //用户ID 9E8E79216D9A4F8BB696FA4E3499E57
    dictM[@"UUID"] = [UserInfo account].dsoa_user_code;
    //用户所属编号 01
    dictM[@"SSBM"] = [UserInfo account].dsoa_user_suoscode;
    //所属公司名称：DEPTNAME
    dictM[@"DEPTNAME"] = [UserInfo account].dsoa_dept_name;
    
    // UIImage图片转成Base64字符串：
    if (self.guaranteeImage) {
        NSData *imgData = UIImageJPEGRepresentation(self.guaranteeImage, 1.0f);
        NSString *encodedImgStr = [imgData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        dictM[@"imgStr"] = encodedImgStr;
    }
    
    GuaranteeDetailsModel *model = [GuaranteeDetailsModel mj_objectWithKeyValues:dictM.copy];
    
    if (self.isAppComplaints == YES) {
        [model uploadAppComplaintsInformation];
    } else {
        [model uploadInformation];
    }

}



//清除数据
- (void)clearData {

    [self.writeGuaranteeView clearData];
    self.guaranteeImage = nil;
}

#pragma mark --调取相册
/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil, nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil, nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage *newImage = [UIImage imageWithImage:image scaledToSize:CGSizeMake(image.size.width * 0.1, image.size.height * 0.1)];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        self.guaranteeImage = newImage;
        self.writeGuaranteeView.guaranteeImage = self.guaranteeImage;
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
