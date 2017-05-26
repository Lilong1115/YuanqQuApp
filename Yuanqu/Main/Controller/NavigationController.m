//
//  NavigationController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/25.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

+ (void)initialize {
    // 系统初始化,当前类时调用!
    
    // 统一设置导航条外观
    // 0.获取导航条的外观代理对象 proxy 代理
    // 通过appearance方法获取导航条的外观代理对象,是个单例!
    // 直接决定了导航条的外观! -> 以后其他所有此类型的对象,显示效果都一样!
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    
    // MARK: - 1设置背景
    navBar.backgroundColor = [UIColor redColor];
    
//    navBar.translucent = NO;
    
    // MARK: - 2.设置标题颜色
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     }];
    
    // MARK: - 3.修改导航栏两侧按钮的颜色
    [navBar setTintColor:[UIColor whiteColor]];
    
}
    
    
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
    
    
    
#pragma mark - 重写系统的push方法!隐藏底部的工具条
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 如果纯代码写的时候,第一显示会走一次push方法的!
    // 需要做一个判断,防止在显示根控制器的时候,隐藏底部的工具条
    // 判断的情况,仅仅是针对纯代码写的!
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 统一设置返回文字
        // 在上一级控制器,设置返回文字
        self.topViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}
    
    
    // 可以拦截pop操作!
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    return [super popViewControllerAnimated:animated];
}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end