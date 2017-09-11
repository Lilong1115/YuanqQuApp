//
//  ImageController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/8/4.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ImageController.h"
#import "PhotoManagement.h"

@interface ImageController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGSize imageSize;

@end

@implementation ImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.title = @"图片";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setImageNoti:) name:[PhotoManagement getPHAssetArrayWithAsset:self.asset original:YES] object:nil];

}


- (void)setImageNoti:(NSNotification *)noti {

//    UIImage *image = [UIImage imageNamed:@"meinv"];
    
    UIImage *image = noti.object;
    
    self.imageSize = [self creatImageSizeWithSize:image.size];

    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.contentSize = self.imageSize;
    [self.view addSubview:self.scrollView];
    
    self.imageView = [[UIImageView alloc]initWithImage:image];
    
    self.imageView.frame = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
    self.imageView.center = self.scrollView.center;
    [self.scrollView addSubview:self.imageView];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.imageView addGestureRecognizer:pinch];
    [self.imageView addGestureRecognizer:tap];
    self.imageView.userInteractionEnabled = YES;
}

//点按手势
- (void)tap:(UITapGestureRecognizer *)tap {
    
    self.navigationController.navigationBar.alpha = self.navigationController.navigationBar.alpha == 1 ? 0 : 1;
    
}

//捏合手势
- (void)pinch:(UIPinchGestureRecognizer *)pinch {
    
    
    CGFloat scale = pinch.scale;
    
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, scale, scale); //在已缩放大小基础下进行累加变化；区别于：使用 CGAffineTransformMakeScale 方法就是在原大小基础下进行变化
    pinch.scale = 1.0;
    
    self.scrollView.contentSize = self.imageView.frame.size;
    
    if (self.imageView.frame.size.width <= self.imageSize.width) {
        
        
        
        if (pinch.state == UIGestureRecognizerStateEnded) {
            self.imageView.frame = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
            self.imageView.center = self.scrollView.center;
        }
    } else {
        
        if (self.imageView.frame.size.height >= self.view.bounds.size.height) {
            self.imageView.center = CGPointMake(self.scrollView.contentSize.width / 2, self.scrollView.contentSize.height / 2);
            
            
        } else {
        
            self.imageView.center = CGPointMake(self.scrollView.contentSize.width / 2, self.view.center.y);
//            [self.scrollView setContentOffset:CGPointMake((self.scrollView.contentSize.width - self.view.bounds.size.width) / 2, 0) animated:NO];
            
        }
        
        
        
        
        
        
    }
    
}




- (CGSize)creatImageSizeWithSize:(CGSize)size {

    CGFloat height = size.height * ScreenW / size.width;
    
    return CGSizeMake(ScreenW, height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
