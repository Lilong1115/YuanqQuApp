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

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    
//采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"
                                  ];
    
    CGFloat w = self.view.bounds.size.width;
    
    
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, w, 200) delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    cycleView.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    cycleView.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    cycleView.imageURLStringsGroup = imagesURLStrings;
    
    [self.view addSubview:cycleView];
    
}
    

@end
