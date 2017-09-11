//
//  FileManagementController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/2.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "FileManagementController.h"
#import "FileManagementCell.h"
#import "FileManagementView.h"
#import "FileManagementModel.h"
//#import "PhotoFileModel.h"
#import "PhotoView.h"
#import "PhotoController.h"

@interface FileManagementController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) NSArray *viewArray;
//文件
@property (nonatomic, strong) NSArray *fileDataArray;
//相册
@property (nonatomic, strong) PHFetchResult *photoFileArray;

@property (nonatomic, strong) UIDocumentInteractionController *document;

//完成视图
@property (nonatomic, strong) UIView *finishView;
//完成按钮
@property (nonatomic, strong) UIButton *finishButton;


@end

@implementation FileManagementController

static NSString * const kFileManagementCellID = @"kFileManagementCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    NSFileManager *fileManager = [NSFileManager defaultManager];
//    // 创建目录
//    [fileManager createDirectoryAtPath:FilesPath withIntermediateDirectories:YES attributes:nil error:nil];
    
//    NSLog(@"%@", FilesPath);
//    
//    
    NSString *testPath = [FilesPath stringByAppendingPathComponent:@"test00.txt"];
    NSString *testPath2 = [FilesPath stringByAppendingPathComponent:@"test22.txt"];
    NSString *testPath3 = [FilesPath stringByAppendingPathComponent:@"test33.txt"];
    
    
    NSString *string = @"写入内容，write String";
    [fileManager createFileAtPath:testPath contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [fileManager createFileAtPath:testPath2 contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [fileManager createFileAtPath:testPath3 contents:[string  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    
    [self setupNav];
    
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.scrollEnabled = NO;
    
    [self.collectionView registerClass:[FileManagementCell class] forCellWithReuseIdentifier:kFileManagementCellID];
    
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
    if (((FileManagementView *)self.viewArray[0]).selectedModel == nil) {
        self.finishButton.enabled = NO;
    }
}

- (void)clickFinishButton {

    [[NSNotificationCenter defaultCenter] postNotificationName:FileSelectedSuccessNotification object:((FileManagementView *)self.viewArray[0]).selectedModel userInfo:@{
                                                      @"indexPath": self.indexPath                                                                                                                   }];
    
//    ((FileManagementView *)self.viewArray[0]).selectedModel
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupNav {

    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    [segment insertSegmentWithTitle:@"文件" atIndex:0 animated:YES];
    [segment insertSegmentWithTitle:@"图片" atIndex:1 animated:YES];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    [segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    
    
}


//点击事件
- (void)clickSegment:(UISegmentedControl *)segment {
        
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:segment.selectedSegmentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];

    self.finishView.hidden = segment.selectedSegmentIndex != 0;


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FileManagementCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFileManagementCellID forIndexPath:indexPath];

    cell.backgroundColor = [UIColor whiteColor];
    cell.content = self.viewArray[indexPath.row];
    
    return cell;
    
}


#pragma mark --lazy
- (NSArray *)viewArray {

    if (_viewArray == nil) {
        
        FileManagementView *fileManagementView = [[FileManagementView alloc]initWithFrame:CGRectMake(0, 30, ScreenW, ScreenH - 64 - 30) style:UITableViewStylePlain];
        fileManagementView.dataArray = self.fileDataArray;
        __weak FileManagementController *weakSelf = self;
        fileManagementView.selecteBlock = ^(NSIndexPath *indexPath) {
            __strong FileManagementController *strongSelf = weakSelf;
            
            FileManagementModel *model = strongSelf.fileDataArray[indexPath.row];
            
            NSURL *url = [NSURL fileURLWithPath:model.filePath];
            
            strongSelf.document = [UIDocumentInteractionController interactionControllerWithURL:url];
            
            self.document.delegate = self;
            
            // 不展示可选操作
            //    [self.document presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
            
            
            // 展示可选操作
            // 可结合代理方法documentInteractionControllerViewControllerForPreview:显示预览
            [self.document presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
            
        };
        
        fileManagementView.clickSelectBlock = ^{
            __strong FileManagementController *strongSelf = weakSelf;
            strongSelf.finishButton.enabled = !((FileManagementView *)strongSelf.viewArray[0]).selectedModel;
        };
        
        
        
        PhotoView *photoView = [[PhotoView alloc]initWithFrame:CGRectMake(0, 30, ScreenW, ScreenH - 64) style:UITableViewStylePlain];
        photoView.dataArray = self.photoFileArray;
        photoView.selecteBlock = ^(NSIndexPath *indexPath) {
            __strong FileManagementController *strongSelf = weakSelf;
            
            PhotoController *photoVC = [[PhotoController alloc]init];
            photoVC.assetCollection = strongSelf.photoFileArray[indexPath.row];
            [strongSelf.navigationController pushViewController:photoVC animated:YES];
        };
        
        _viewArray = @[fileManagementView, photoView];
        
    }
    
    return _viewArray;
}

#pragma mark --UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}


- (NSArray *)fileDataArray {

    if (_fileDataArray == nil) {
        _fileDataArray = [FileManagementModel getFiles];
    }
    
    return _fileDataArray;
}


- (PHFetchResult *)photoFileArray {

    if (_photoFileArray == nil) {

        
       _photoFileArray = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];

    }
    return _photoFileArray;
}



@end
