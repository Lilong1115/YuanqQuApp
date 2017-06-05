//
//  HomeController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//
//首页
#import "HomeController.h"
#import <SDCycleScrollView.h>
#import "BusinessFlowLayout.h"
#import "BusinessCollectionView.h"
#import "HomeView.h"
#import "SurroundingController.h"
#import "HomeBaseModel.h"
#import "Calculate.h"
#import "HomeModel.h"

#pragma mark --宏定义
//轮播图高度
#define CycleViewHeight 200


@interface HomeController ()<UIScrollViewDelegate>

@end

@implementation HomeController

#pragma mark --重新设置view视图
- (void)loadView {
    
    //设置为滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    
    //取消弹簧
    scrollView.bounces = NO;
    
    scrollView.delegate = self;
    
    NSArray *array = [HomeBaseModel getHomeBaseModelArray];
    
    __block CGFloat homeHeight = 0;
    [array enumerateObjectsUsingBlock:^(HomeBaseModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        homeHeight += (ScreenW / BusinessColumns * [Calculate calculateRowsWithCount:obj.content.count columns:BusinessColumns] + HomeHeaderViewHeight);
    }];
    
    //滚动范围
    scrollView.contentSize = CGSizeMake(ScreenW, homeHeight + CycleViewHeight);
    
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupCycleView];
    [self setupBusinessView];
    
}
    
//设置nav
- (void)setupNav {
    
    self.title = @"首页";
}

//设置轮播图
- (void)setupCycleView {
    
    //采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, CycleViewHeight) delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    cycleView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleView.imageURLStringsGroup = imagesURLStrings;
    
    [self.view addSubview:cycleView];
    
}
    
//设置业务区内容
- (void)setupBusinessView {
    
    NSArray *array = [HomeBaseModel getHomeBaseModelArray];
    
    __block CGFloat homeHeight = 0;
    [array enumerateObjectsUsingBlock:^(HomeBaseModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        homeHeight += (ScreenW / BusinessColumns * [Calculate calculateRowsWithCount:obj.content.count columns:BusinessColumns] + HomeHeaderViewHeight);
    }];
    
    //业务视图
    HomeView *homeView = [[HomeView alloc]initWithFrame:CGRectMake(0, CycleViewHeight, ScreenW, homeHeight) style:UITableViewStylePlain];
    
    homeView.contentArray = array;
    
    //点击业务回调
    __weak HomeController *weakSelf = self;
    homeView.selectedBlock = ^(NSIndexPath *indexPath) {
        __strong HomeController *strongSelf = weakSelf;
        
        HomeBaseModel *baseModel = array[indexPath.section];
        HomeModel *model = baseModel.content[indexPath.item];
        
        //周边信息
        if ([model.title isEqualToString:@"周边信息"]) {
            SurroundingController *surroundingVC = [[SurroundingController alloc]init];
            [strongSelf.navigationController pushViewController:surroundingVC animated:YES];
        }
        
    };

    [self.view addSubview:homeView];
}


@end
