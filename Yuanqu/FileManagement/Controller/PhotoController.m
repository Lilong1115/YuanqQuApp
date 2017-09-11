//
//  PhotoController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "PhotoController.h"
#import "PhotoSelectView.h"
#import "PhotoManagement.h"
#import "ImageController.h"

@interface PhotoController ()

@property (nonatomic, weak) PhotoSelectView *photoSelectView;

//完成视图
@property (nonatomic, strong) UIView *finishView;
//完成按钮
@property (nonatomic, strong) UIButton *finishButton;

//选中cell
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation PhotoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图片选择";
    self.view.backgroundColor = [UIColor whiteColor];
    
    PhotoSelectView *photoSelectView = [[PhotoSelectView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 30) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    [self.view addSubview:photoSelectView];
    self.photoSelectView = photoSelectView;
    photoSelectView.assetCollection = self.assetCollection;
    __weak PhotoController *weakSelf = self;
    photoSelectView.selectedBlock = ^(NSIndexPath *indexPath) {
        __strong PhotoController *strongSelf = weakSelf;
        
        ImageController *imageVC = [[ImageController alloc]init];
        imageVC.asset = [PhotoManagement getThumbnailImagesWithPhotoFile:strongSelf.assetCollection][indexPath.item];
        
        [strongSelf.navigationController pushViewController:imageVC animated:YES];
    };
    photoSelectView.clickSelectBlock = ^(NSIndexPath *indexPath) {
        
        __strong PhotoController *strongSelf = weakSelf;
        strongSelf.selectedIndexPath = indexPath;
        strongSelf.finishButton.enabled = self.selectedIndexPath;
        
    };
    
    [self setupFinishView];
    
}

//设置完成视图
- (void)setupFinishView {
    
    self.finishView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH - 30, ScreenW, 30)];
    self.finishView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.finishView];
    
    self.finishButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenW - 60, 0, 60, 30)];
    [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.finishButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.finishButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [self.finishView addSubview:self.finishButton];
    [self.finishButton addTarget:self action:@selector(clickFinishButton) forControlEvents:UIControlEventTouchUpInside];
    if (self.selectedIndexPath == nil) {
        self.finishButton.enabled = NO;
    }
}

- (void)clickFinishButton {

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
