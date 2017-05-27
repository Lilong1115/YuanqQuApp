//
//  SuggestionController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "SuggestionController.h"
#import "ScrollToSwitchView.h"
#import "SuggestionView.h"

#pragma mark --宏定义
//轮播图高度
#define ScrollToSwitchViewHeight 40
#define ScrollToSwitchViewWidth 300

@interface SuggestionController ()

@end

@implementation SuggestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupNav];
    [self setupScrollToSwitchView];
    [self setupSuggestionView];
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
    [self.view addSubview:scrollToSwitchView];
}

//设置意见箱具体内容
- (void)setupSuggestionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(ScreenW, ScreenH - ScrollToSwitchViewHeight - 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    SuggestionView *suggestionView = [[SuggestionView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight + 10 + 64, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10) collectionViewLayout:flowLayout];
    
    [self.view addSubview:suggestionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
