//
//  BusinessController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/26.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "BusinessController.h"
#import "BusinessCollectionView.h"
#import "BusinessFlowLayout.h"

@interface BusinessController ()

@end

@implementation BusinessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupBusinessView];
}
    
//设置nav
- (void)setupNav {
    
    self.title = @"业务";
}

//设置业务区内容
- (void)setupBusinessView {

    //flowLayout
    BusinessFlowLayout *flowLayout = [[BusinessFlowLayout alloc]init];
    
    BusinessCollectionView *businessView = [[BusinessCollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 49) collectionViewLayout:flowLayout];
    
    [self.view addSubview:businessView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
