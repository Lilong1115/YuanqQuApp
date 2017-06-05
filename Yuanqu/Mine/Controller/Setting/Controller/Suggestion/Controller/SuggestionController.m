//
//  SuggestionController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "SuggestionController.h"
#import "ScrollToSwitchView.h"
#import "ScrollToView.h"

#pragma mark --宏定义
//上部滚动高度
#define ScrollToSwitchViewHeight 40
#define ScrollToSwitchViewWidth 300

@interface SuggestionController ()

//上部滚动视图
@property (nonatomic, weak) ScrollToSwitchView *scrollToSwitchView;
//下部滚动视图
@property (nonatomic, weak) ScrollToView *scrollToView;

@end

@implementation SuggestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupNav];
    [self setupScrollToSwitchView];
    [self setupScrollToView];
}
    
//设置nav
- (void)setupNav {
    
    self.title = @"意见箱";
    
}

//设置ScrollToSwitchView
- (void)setupScrollToSwitchView {

    //不设置这个参数,cell不走item方法
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ScrollToSwitchView *scrollToSwitchView = [[ScrollToSwitchView alloc]initWithFrame:CGRectMake(0, 64, ScrollToSwitchViewWidth, ScrollToSwitchViewHeight)];
    scrollToSwitchView.contentArray = @[@"填写意见", @"查询意见"];
    //滚动回调
    //防止循环引用
    __weak SuggestionController *weakSelf = self;
    scrollToSwitchView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong SuggestionController *strongSelf = weakSelf;
        
        [strongSelf.scrollToView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    };
    
    [self.view addSubview:scrollToSwitchView];
    self.scrollToSwitchView = scrollToSwitchView;
}

//设置意见箱具体内容
- (void)setupScrollToView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(ScreenW, ScreenH - ScrollToSwitchViewHeight - 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    ScrollToView *scrollToView = [[ScrollToView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight + 10 + 64, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) collectionViewLayout:flowLayout];
    //滚动回调
    //防止循环引用
    __weak SuggestionController *weakSelf = self;
    scrollToView.scrollToViewBlock = ^(NSIndexPath *indexPath){
    
        __strong SuggestionController *strongSelf = weakSelf;
        
        [strongSelf.scrollToSwitchView scrollToViewWithIndexPath:indexPath];
    };
    
    [self.view addSubview:scrollToView];
    self.scrollToView = scrollToView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
