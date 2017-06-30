//
//  TabBarController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import <RDVTabBarItem.h>
#import "HomeController.h"
#import "MineController.h"
#import "BusinessController.h"

@interface TabBarController ()<RDVTabBarControllerDelegate>

    
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setupChildVcs];
    
    [self setupBottomView];
}
    
//加载子控制器
- (void)setupChildVcs {
    
    //首页
    HomeController *homeController = [[HomeController alloc] init];
    NavigationController *homeNav =[[NavigationController alloc]initWithRootViewController:homeController];
    
    //业务
    BusinessController *businessController = [[BusinessController alloc] init];
    NavigationController *businessNav = [[NavigationController alloc]initWithRootViewController:businessController];
    
    //我的
    MineController *mineController = [[MineController alloc] init];
    NavigationController *minNav = [[NavigationController alloc]initWithRootViewController:mineController];
    
    [self setViewControllers:@[homeNav, businessNav, minNav]];
    
}
    
//添加底部的工具条
- (void)setupBottomView {
    
    NSArray *tabBarItemImages = @[@"tab1", @"tab3", @"tab2"];
    
    NSInteger index = 0;
    
//    [self tabBar]
    
    for (RDVTabBarItem *tabBarItem in [[self tabBar] items]) {
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [tabBarItem setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        switch (index) {
            case 0:
                [tabBarItem setTitle:@"首页"];
            break;
            case 1:
                [tabBarItem setTitle:@"业务"];
            break;
            case 2:
                [tabBarItem setTitle:@"我的"];
            break;
            default:
            break;
        }
        
        //设置选中或者未选中状态文字颜色
        [tabBarItem setSelectedTitleAttributes:@{
                                        NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#1296DB"]}];
        [tabBarItem setUnselectedTitleAttributes:@{
                                        NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#707070"]}];
        
        index++;
    }
    
}


#pragma mark --RDVTabBarControllerDelegate方法 设置动画
- (void)tabBarController:(RDVTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    [self animationWithIndex:self.selectedIndex];
    
}
    
    
// 动画
- (void)animationWithIndex:(NSInteger) index {

    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    //由于子视图包含view 故+1
    [[self.tabBar.subviews[index + 1] layer]
     addAnimation:pulse forKey:nil];
    
}


@end
