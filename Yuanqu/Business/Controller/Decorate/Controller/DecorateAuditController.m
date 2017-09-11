//
//  DecorateAuditController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/3.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "DecorateAuditController.h"
#import "ScrollToSwitchView.h"
#import "ScrollToView.h"
#import "DecorateView.h"
#import "AddDecorateController.h"
#import "DecorateModel.h"
#import "AuditDecorateController.h"


#pragma mark --宏定义
//上部滚动高度
#define ScrollToSwitchViewHeight 40
#define ScrollToSwitchViewWidth 300

@interface DecorateAuditController ()

//上部滚动视图
@property (nonatomic, weak) ScrollToSwitchView *scrollToSwitchView;
//滚动视图内容
@property (nonatomic, strong) NSArray *scrollToSwitchArray;
//下部滚动视图
@property (nonatomic, weak) ScrollToView *scrollToView;

//待审核数据列表
@property (nonatomic, strong) DecorateView *renovationListView;
//已审核数据列表
@property (nonatomic, strong) DecorateView *renovationSubmittedView;


//待审核数据
@property (nonatomic, strong) NSArray *renovationList;
//已审核数据
@property (nonatomic, strong) NSArray *renovationSubmitted;


@end

@implementation DecorateAuditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取数据
    [DecorateModel getDshList];
    [DecorateModel getYshList];
    
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDshListSuccessNotification:) name:AppDshListSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appYshListSuccessNotification:) name:AppYshListSuccessNotification object:nil];
    
    
    self.title = self.navTitle;
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupLogo];
    [self setupScrollToSwitchView];
    [self setupScrollToView];
    
    
}


//待提交
- (void)appDshListSuccessNotification:(NSNotification *)noti {
    
    if (noti.object) {
        self.renovationList = noti.object;
        self.renovationListView.dataArray = self.renovationList;
        [self.renovationListView reloadData];
    }
    
    [self.renovationListView.mj_header endRefreshing];
    
}

//已提交
- (void)appYshListSuccessNotification:(NSNotification *)noti {
    
    if (noti.object) {
        self.renovationSubmitted = noti.object;
        self.renovationSubmittedView.dataArray = self.renovationSubmitted;
        [self.renovationSubmittedView reloadData];
    }
    [self.renovationSubmittedView.mj_header endRefreshing];
    
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
    __weak DecorateAuditController *weakSelf = self;
    scrollToSwitchView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong DecorateAuditController *strongSelf = weakSelf;
        
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
    __weak DecorateAuditController *weakSelf = self;
    
    scrollToView.contentArray = @[self.renovationListView, self.renovationSubmittedView];
    //滚动回调
    scrollToView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong DecorateAuditController *strongSelf = weakSelf;
        
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
        _scrollToSwitchArray = @[@"待审核", @"已审核"];
    }
    
    return _scrollToSwitchArray;
}


- (DecorateView *)renovationListView {
    
    if (_renovationListView == nil) {
        _renovationListView = [[DecorateView alloc]initWithFrame:CGRectMake(0, 30, ScreenW, ScreenH - ScrollToSwitchViewHeight - 64 - 10) style:UITableViewStylePlain];
        _renovationListView.listType = ToAuditType;
        _renovationListView.refreshBlock = ^(){
            [DecorateModel getDshList];
        };
        __weak DecorateAuditController *weakSelf = self;
        _renovationListView.clickAuditBlock = ^(NSIndexPath *indexPath) {
            __weak DecorateAuditController *strongSelf = weakSelf;
            [strongSelf addDecorateWithModel:strongSelf.renovationList[indexPath.row] listType:ToAuditType];
        };
    }
    return _renovationListView;
}


- (DecorateView *)renovationSubmittedView {
    
    if (_renovationSubmittedView == nil) {
        _renovationSubmittedView = [[DecorateView alloc]initWithFrame:CGRectMake(0, 30, ScreenW, ScreenH - ScrollToSwitchViewHeight - 64 - 10) style:UITableViewStylePlain];
        _renovationSubmittedView.listType = AuditedType;
        _renovationSubmittedView.refreshBlock = ^(){
            [DecorateModel getYshList];
        };
        __weak DecorateAuditController *weakSelf = self;
        _renovationSubmittedView.clickDetailsBlock = ^(NSIndexPath *indexPath) {
            __weak DecorateAuditController *strongSelf = weakSelf;
            [strongSelf addDecorateWithModel:strongSelf.renovationSubmitted[indexPath.row] listType:AuditedType];
        };
    }
    return _renovationSubmittedView;
}


- (void)addDecorateWithModel:(DecorateModel *)model listType:(DecorateListType)listType {
    
    AuditDecorateController *addDecorateVC = [[AuditDecorateController alloc]init];
    addDecorateVC.model = model;
    addDecorateVC.listType = listType;
    [self.navigationController pushViewController:addDecorateVC animated:YES];
    
}


//移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
