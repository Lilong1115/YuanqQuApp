//
//  ToGuaranteeController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/5/31.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ToGuaranteeController.h"
#import "ScrollToSwitchView.h"
#import "ScrollToView.h"
#import "WriteGuaranteeView.h"
#import "DemandGuaranteeView.h"
#import "GuaranteeDetailsController.h"

#pragma mark --宏定义
//上部滚动高度
#define ScrollToSwitchViewHeight 40
#define ScrollToSwitchViewWidth 300

@interface ToGuaranteeController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

//上部滚动视图
@property (nonatomic, weak) ScrollToSwitchView *scrollToSwitchView;
//下部滚动视图
@property (nonatomic, weak) ScrollToView *scrollToView;

//填写报修
@property (nonatomic, weak) WriteGuaranteeView *writeGuaranteeView;

//获取图片
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) UIActionSheet *actionSheet;

//报修图片
@property (nonatomic, strong) UIImage *guaranteeImage;

@end

@implementation ToGuaranteeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self setupNav];
    [self setupScrollToSwitchView];
    [self setupScrollToView];
}

//设置nav
- (void)setupNav {
    
    self.title = self.navTitle;
    
}

//设置ScrollToSwitchView
- (void)setupScrollToSwitchView {
    
    //不设置这个参数,cell不走item方法
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ScrollToSwitchView *scrollToSwitchView = [[ScrollToSwitchView alloc]initWithFrame:CGRectMake(0, 64, ScrollToSwitchViewWidth, ScrollToSwitchViewHeight)];
    //设置滚动不同内容
    if ([self.navTitle isEqualToString:@"我要报修"]) {
        scrollToSwitchView.contentArray = @[@"填写报修", @"查询报修"];
    } else if ([self.navTitle isEqualToString:@"我要投诉"]) {
        scrollToSwitchView.contentArray = @[@"填写投诉", @"查询投诉"];
    }
    
    //滚动回调
    //防止循环引用
    __weak ToGuaranteeController *weakSelf = self;
    scrollToSwitchView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong ToGuaranteeController *strongSelf = weakSelf;
        
        [strongSelf.scrollToView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    };
    
    [self.view addSubview:scrollToSwitchView];
    self.scrollToSwitchView = scrollToSwitchView;
}

//设置我要报修具体内容
- (void)setupScrollToView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(ScreenW, ScreenH - ScrollToSwitchViewHeight - 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    ScrollToView *scrollToView = [[ScrollToView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight + 10 + 64, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64) collectionViewLayout:flowLayout];
    
    //填写报修视图
    WriteGuaranteeView *writeGuaranteeView = [[WriteGuaranteeView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64)];
    self.writeGuaranteeView = writeGuaranteeView;
    //防止循环引用
    __weak ToGuaranteeController *weakSelf = self;
    //选取相册回调
    writeGuaranteeView.selectedImageBlock = ^(){
        __strong ToGuaranteeController *strongSelf = weakSelf;
        [strongSelf callActionSheetFunc];
    };
    
    //查询保修视图
    DemandGuaranteeView *demandGuaranteeView = [[DemandGuaranteeView alloc]initWithFrame:CGRectMake(0, ScrollToSwitchViewHeight - 10, ScreenW, ScreenH - ScrollToSwitchViewHeight - 10 - 64)];
    //报修详情回调
    demandGuaranteeView.clickDetailsBlock = ^(){
        
        __strong ToGuaranteeController *strongSelf = weakSelf;
        
        GuaranteeDetailsController *guaranteeDetailsVC = [[GuaranteeDetailsController alloc]init];
        
        //设置不同内容
        if ([self.navTitle isEqualToString:@"我要报修"]) {
            guaranteeDetailsVC.navTitle = @"报修详情";
        } else if ([self.navTitle isEqualToString:@"我要投诉"]) {
            guaranteeDetailsVC.navTitle = @"投诉详情";
        }
        
        [strongSelf.navigationController pushViewController:guaranteeDetailsVC animated:YES];
    };
    
    scrollToView.contentArray = @[writeGuaranteeView, demandGuaranteeView];
    //滚动回调
    scrollToView.scrollToViewBlock = ^(NSIndexPath *indexPath){
        
        __strong ToGuaranteeController *strongSelf = weakSelf;
        
        [strongSelf.scrollToSwitchView scrollToViewWithIndexPath:indexPath];
    };
    
    [self.view addSubview:scrollToView];
    self.scrollToView = scrollToView;
    
}

#pragma mark --调取相册
/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil, nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil, nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}


// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    UIImage *newImage = [UIImage imageWithImage:image scaledToSize:CGSizeMake(image.size.width * 0.1, image.size.height * 0.1)];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        self.guaranteeImage = newImage;
        self.writeGuaranteeView.guaranteeImage = self.guaranteeImage;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
