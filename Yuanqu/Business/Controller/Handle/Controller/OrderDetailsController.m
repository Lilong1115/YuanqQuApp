//
//  OrderDetailsController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/5.
//  Copyright © 2017年 李龙. All rights reserved.
//

//工单详情
#import "OrderDetailsController.h"
#import "DetailsView.h"
#import "AssignedPersonnelView.h"
#import "DispatchPersonnelController.h"
#import "BusinessCollectionView.h"
#import "BusinessFlowLayout.h"
#import "HomeModel.h"

#pragma mark --宏定义
#define DetailsViewHeight 200
#define AssignedPersonnelViewHeight 40
#define SubmitButtonHeight 50


@interface OrderDetailsController ()

//指派人员
@property (nonatomic, weak) AssignedPersonnelView *assignedPersonnelView;

//人员数组
@property (nonatomic, strong) NSMutableArray *personnelArray;
//网格数据
@property (nonatomic, weak) BusinessCollectionView *collectionView;

@end

@implementation OrderDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupDetailsView];
    [self setupAssignedPersonnelView];
    [self setupCollectionView];
    [self setupSubmitButton];
}

//设置nav
- (void)setupNav {

    self.title = @"工单详情";
}

//设置详情view
- (void)setupDetailsView {

    DetailsView *detailsView = [[DetailsView alloc]initWithFrame:CGRectMake(8, 64 + 8, ScreenW - 8 * 2, DetailsViewHeight)];
    [self.view addSubview:detailsView];
    
}

//设置指派人员
- (void)setupAssignedPersonnelView {

    AssignedPersonnelView *assignedPersonnelView = [[AssignedPersonnelView alloc]initWithFrame:CGRectMake(8, DetailsViewHeight + 64 + 20, ScreenW - 8 * 2, AssignedPersonnelViewHeight)];
    //先隐藏
    assignedPersonnelView.hidden = YES;
    [self.view addSubview:assignedPersonnelView];
    self.assignedPersonnelView = assignedPersonnelView;
    
    //按钮回调
    __weak OrderDetailsController *weakSelf = self;
    assignedPersonnelView.clickDistributedBlock = ^(){
        __strong OrderDetailsController *strongSelf = weakSelf;
        
        DispatchPersonnelController *dispatchPersonnelVC = [[DispatchPersonnelController alloc]init];
        
        //选择人员回调
        dispatchPersonnelVC.dispatchPersonnelBlock = ^(){
            
            HomeModel *model = [HomeModel mj_objectWithKeyValues:@{
                                                            @"title": @"1"
                                                                   }];
            
            [strongSelf.personnelArray addObject:model];
            strongSelf.collectionView.contentArray = strongSelf.personnelArray;
        };
        
        [strongSelf.navigationController pushViewController:dispatchPersonnelVC animated:YES];
        
    };
    assignedPersonnelView.clickRemoveBlock = ^(){
        __strong OrderDetailsController *strongSelf = weakSelf;
        
        [strongSelf.personnelArray removeLastObject];
        strongSelf.collectionView.contentArray = strongSelf.personnelArray;
    };
    assignedPersonnelView.clickEmptyBlock = ^(){
        __strong OrderDetailsController *strongSelf = weakSelf;
        [strongSelf.personnelArray removeAllObjects];
        strongSelf.collectionView.contentArray = strongSelf.personnelArray;
    };
}


//设置网格数据
- (void)setupCollectionView {

    BusinessFlowLayout *flowLayout = [[BusinessFlowLayout alloc]init];
    BusinessCollectionView *collectionView = [[BusinessCollectionView alloc]initWithFrame:CGRectMake(0, DetailsViewHeight + 64 + 20 + AssignedPersonnelViewHeight + 10, ScreenW, ScreenH - DetailsViewHeight - 64 - 20 - AssignedPersonnelViewHeight - 10 - 20 * 2 - SubmitButtonHeight) collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    //设置可以滚动
    collectionView.scrollEnabled = YES;
}

//设置提交工单
- (void)setupSubmitButton {

    UIButton *submitButton = [[UIButton alloc]init];
    [submitButton setTitle:@"制定工单" forState:UIControlStateNormal];
    [submitButton setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-20);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(ScreenW - 20 * 2);
        make.height.mas_equalTo(SubmitButtonHeight);
    }];
    [submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
}

//点击制定工单/提交订单
- (void)clickSubmitButton:(UIButton *)sender {

    if ([sender.titleLabel.text isEqualToString:@"制定工单"]) {
        [sender setTitle:@"提交订单" forState:UIControlStateNormal];
        self.assignedPersonnelView.hidden = NO;
    } else {
    
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --lazy
- (NSMutableArray *)personnelArray {

    if (_personnelArray == nil) {
        _personnelArray = [NSMutableArray array];
    }
    return _personnelArray;
}


@end
