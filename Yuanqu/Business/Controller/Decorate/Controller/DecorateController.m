//
//  DecorateController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/7/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

//装修申报
#import "DecorateController.h"
#import "ScrollToSwitchView.h"
#import "ScrollToView.h"
#import "DecorateView.h"
#import "AddDecorateController.h"
#import "DecorateModel.h"


#pragma mark --宏定义
//上部滚动高度
#define ScrollToSwitchViewHeight 40
#define ScrollToSwitchViewWidth 300

@interface DecorateController ()

//上部滚动视图
@property (nonatomic, weak) ScrollToSwitchView *scrollToSwitchView;
//滚动视图内容
@property (nonatomic, strong) NSArray *scrollToSwitchArray;
//下部滚动视图
@property (nonatomic, weak) ScrollToView *scrollToView;

//待提交数据列表
@property (nonatomic, strong) DecorateView *renovationListView;
//已提交数据列表
@property (nonatomic, strong) DecorateView *renovationSubmittedView;
//待清除数据列表
@property (nonatomic, strong) DecorateView *deleteView;

//填写申报列表
@property (nonatomic, strong) AddDecorateController *addDecorateVC;

//待提交数据
@property (nonatomic, strong) NSArray *renovationList;
//已提交数据
@property (nonatomic, strong) NSArray *renovationSubmitted;
//待清除数据
@property (nonatomic, strong) NSArray *deleteList;

@end

@implementation DecorateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取数据
    [DecorateModel getRenovationList];
    [DecorateModel getRenovationSubmitted];
    [DecorateModel getDeleteList];
    
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGetRenovationListSuccessNotification:) name:AppGetRenovationListSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGetRenovationSubmittedSuccessNotification:) name:AppGetRenovationSubmittedSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDeleteListSuccessNotification:) name:AppDeleteListSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRenovationSubmitSuccessNotification:) name:AddRenovationSubmitSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRenovationDeleteSuccessNotification:) name:AddRenovationDeleteSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDeleteCleanSuccessNotification:) name:AppDeleteCleanSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addRestoreSuccessNotification:) name:AddRestoreSuccessNotification object:nil];
    
    
    self.title = self.navTitle;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDecorate)];

    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupLogo];
    [self setupScrollToSwitchView];
    [self setupScrollToView];
    
    
}

//还原
- (void)addRestoreSuccessNotification:(NSNotification *)noti {

    [DecorateModel getDeleteList];
    [ProgressHUD showSuccess:@"还原成功"];
    
}

- (void)appDeleteCleanSuccessNotification:(NSNotification *)noti {

    [DecorateModel getDeleteList];
    [ProgressHUD showSuccess:@"清除成功"];
    
}

//提交
- (void)addRenovationSubmitSuccessNotification:(NSNotification *)noti {

    [DecorateModel getRenovationList];
    [ProgressHUD showSuccess:@"提交成功"];
}

//删除
- (void)addRenovationDeleteSuccessNotification:(NSNotification *)noti {
    
    [DecorateModel getRenovationList];
    [ProgressHUD showSuccess:@"删除成功"];
}


//待提交
- (void)appGetRenovationListSuccessNotification:(NSNotification *)noti {

    self.renovationList = noti.object;
    self.renovationListView.dataArray = self.renovationList;
    [self.renovationListView reloadData];
    [self.renovationListView.mj_header endRefreshing];
    
}

//已提交
- (void)appGetRenovationSubmittedSuccessNotification:(NSNotification *)noti {
    
    if (noti.object) {
        self.renovationSubmitted = noti.object;
        self.renovationSubmittedView.dataArray = self.renovationSubmitted;
        [self.renovationSubmittedView reloadData];
    }

    [self.renovationSubmittedView.mj_header endRefreshing];
    
}

//带清除
- (void)appDeleteListSuccessNotification:(NSNotification *)noti {
    
    self.deleteList = noti.object;
    self.deleteView.dataArray = self.deleteList;
    [self.deleteView reloadData];
    [self.deleteView.mj_header endRefreshing];
    
}

//添加申报
- (void)addDecorate {

    AddDecorateController *addDecorateVC = [[AddDecorateController alloc]init];
    [self.navigationController pushViewController:addDecorateVC animated:YES];
    
}


//设置logo
- (void)setupLogo {
    
    
    NSLog(@"%@", [UserInfo account].dsoa_user_suoscode);
    
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ScreenW, 200)];
//    [logo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@vi/lanm/%@.png", BaseUrl, [UserInfo account].dsoa_user_suoscode]]];
    
    [logo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@vi/lanm/%@.png", BaseUrl, [UserInfo account].dsoa_user_suoscode]] placeholderImage:[UIImage imageNamed:@"meinv"]];
    
    [self.view addSubview:logo];
    
}

//设置ScrollToSwitchView
- (void)setupScrollToSwitchView {
    
    //不设置这个参数,cell不走item方法
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ScrollToSwitchView *scrollToSwitchView = [[ScrollToSwitchView alloc]initWithFrame:CGRectMake(0, 64, ScrollToSwitchViewWidth, ScrollToSwitchViewHeight)];
    //设置滚动不同内容
    scrollToSwitchView.contentArray = self.scrollToSwitchArray;
    
    //滚动回调
    //防止循环引用
    __weak DecorateController *weakSelf = self;
    scrollToSwitchView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong DecorateController *strongSelf = weakSelf;
        
        [strongSelf.scrollToView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    };
    
    [self.view addSubview:scrollToSwitchView];
    self.scrollToSwitchView = scrollToSwitchView;
}


//设置装修申报具体内容
- (void)setupScrollToView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(ScreenW, ScreenH - ScrollToSwitchViewHeight - 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    ScrollToView *scrollToView = [[ScrollToView alloc]initWithFrame:CGRectMake(0, 64 + ScrollToSwitchViewHeight + 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 64 - 10) collectionViewLayout:flowLayout];
    scrollToView.layer.borderWidth = 0.5;
    scrollToView.layer.borderColor = [UIColor grayColor].CGColor;

    //防止循环引用
    __weak DecorateController *weakSelf = self;
    
    scrollToView.contentArray = @[self.addDecorateVC.tableView, self.renovationSubmittedView];
    //滚动回调
    scrollToView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong DecorateController *strongSelf = weakSelf;
        
        [strongSelf.scrollToSwitchView scrollToViewWithIndexPath:indexPath];
    };
    
    [self.view addSubview:scrollToView];
    self.scrollToView = scrollToView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --lazy
- (NSArray *)scrollToSwitchArray {

    if (_scrollToSwitchArray == nil) {
        _scrollToSwitchArray = @[@"填写申报", @"查询申报"];
    }
    
    return _scrollToSwitchArray;
}


- (DecorateView *)renovationListView {

    if (_renovationListView == nil) {
        _renovationListView = [[DecorateView alloc]initWithFrame:CGRectMake(0, 30, ScreenW, ScreenH - ScrollToSwitchViewHeight - 64 - 10) style:UITableViewStylePlain];
        _renovationListView.listType = RenovationListType;
        _renovationListView.refreshBlock = ^(){
            [DecorateModel getRenovationList];
        };
        __weak DecorateController *weakSelf = self;
        _renovationListView.clickDetailsBlock = ^(NSIndexPath *indexPath) {
            __strong DecorateController *strongSelf = weakSelf;
            [strongSelf addDecorateWithModel:strongSelf.renovationList[indexPath.row] listType:RenovationListType];
        };
        _renovationListView.clickSubmitBlock = ^(NSIndexPath *indexPath) {
            __strong DecorateController *strongSelf = weakSelf;
            
            JCAlertController *alert = [JCAlertController alertWithTitle:@"提交数据" message:@"您确认要提交数据吗?"];
            
            [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
            [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
                [ProgressHUD show:@"正在提交..."];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [((DecorateModel *)strongSelf.renovationList[indexPath.row]) addRenovationSubmit];
                    
                });
            }];
            
            [strongSelf jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
            
            
        };
        _renovationListView.clickDeleteBlock = ^(NSIndexPath *indexPath) {
            __strong DecorateController *strongSelf = weakSelf;
            
            JCAlertController *alert = [JCAlertController alertWithTitle:@"删除数据" message:@"您确认要删除数据吗?"];
            
            [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
            [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
                [ProgressHUD show:@"正在删除..."];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [((DecorateModel *)strongSelf.renovationList[indexPath.row]) addRenovationDelete];
                    
                });
            }];
            
            [strongSelf jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
            
        };
    }
    return _renovationListView;
}


- (DecorateView *)renovationSubmittedView {
    
    if (_renovationSubmittedView == nil) {
        _renovationSubmittedView = [[DecorateView alloc]initWithFrame:CGRectMake(0, 30, ScreenW, ScreenH - ScrollToSwitchViewHeight - 64 - 10) style:UITableViewStylePlain];
        _renovationSubmittedView.listType = RenovationSubmittedType;
        _renovationSubmittedView.refreshBlock = ^(){
            [DecorateModel getRenovationSubmitted];
        };
        __weak DecorateController *weakSelf = self;
        _renovationSubmittedView.clickDetailsBlock = ^(NSIndexPath *indexPath) {
            __strong DecorateController *strongSelf = weakSelf;
            [strongSelf addDecorateWithModel:strongSelf.renovationSubmitted[indexPath.row] listType:RenovationSubmittedType];
        };
    }
    return _renovationSubmittedView;
}


- (DecorateView *)deleteView {
    
    if (_deleteView == nil) {
        _deleteView = [[DecorateView alloc]initWithFrame:CGRectMake(0, 30, ScreenW, ScreenH - ScrollToSwitchViewHeight - 64 - 10) style:UITableViewStylePlain];
        _deleteView.listType = DeleteListType;
        _deleteView.refreshBlock = ^(){
            [DecorateModel getDeleteList];
        };
        __weak DecorateController *weakSelf = self;
        _deleteView.clickDetailsBlock = ^(NSIndexPath *indexPath) {
            __strong DecorateController *strongSelf = weakSelf;
            [strongSelf addDecorateWithModel:strongSelf.deleteList[indexPath.row] listType:DeleteListType];
        };
        _deleteView.clickClearBlock = ^(NSIndexPath *indexPath) {
            __strong DecorateController *strongSelf = weakSelf;
            JCAlertController *alert = [JCAlertController alertWithTitle:@"清除数据" message:@"您确认要彻底清除数据吗?"];
            
            [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
            [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
                [ProgressHUD show:@"正在清除..."];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [strongSelf.deleteList[indexPath.row] addRenovationClear];
                    
                });
            }];
            
            [strongSelf jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
        };
        _deleteView.clickReductionBlock = ^(NSIndexPath *indexPath) {
            __strong DecorateController *strongSelf = weakSelf;
            JCAlertController *alert = [JCAlertController alertWithTitle:@"还原数据" message:@"您确认要还原数据吗?"];
            
            [alert addButtonWithTitle:@"取消" type:JCButtonTypeWarning clicked:nil];
            [alert addButtonWithTitle:@"确定" type:JCButtonTypeWarning clicked:^{
                [ProgressHUD show:@"正在还原..."];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [strongSelf.deleteList[indexPath.row] addRenovationReduction];
                    
                });
            }];
            
            [strongSelf jc_presentViewController:alert presentType:JCPresentTypeFIFO presentCompletion:nil dismissCompletion:nil];
        };
    }
    return _deleteView;
}


- (AddDecorateController *)addDecorateVC {

    if (_addDecorateVC == nil) {
        _addDecorateVC = [[AddDecorateController alloc]init];
        _addDecorateVC.tableView.frame = CGRectMake(0, 30, ScreenW, ScreenH - ScrollToSwitchViewHeight - 64 - 10);
    }
    return _addDecorateVC;
}





- (void)addDecorateWithModel:(DecorateModel *)model listType:(DecorateListType)listType {

    AddDecorateController *addDecorateVC = [[AddDecorateController alloc]init];
    addDecorateVC.model = model;
    addDecorateVC.listType = listType;
    addDecorateVC.title = self.title;
    [self.navigationController pushViewController:addDecorateVC animated:YES];
    
}


//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
