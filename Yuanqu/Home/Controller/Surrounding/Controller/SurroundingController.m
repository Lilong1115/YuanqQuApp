//
//  SurroundingController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/1.
//  Copyright © 2017年 李龙. All rights reserved.
//

//周边信息
#import "SurroundingController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface SurroundingController ()<AMapSearchDelegate, MAMapViewDelegate>

//地图
@property (nonatomic, strong) MAMapView *mapView;
//搜索
@property (nonatomic, strong) AMapSearchAPI *search;

@end

@implementation SurroundingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupMapView];
    
}

//设置nav
- (void)setupNav {

    self.title = @"周边信息";
}

//设置地图
- (void)setupMapView {

    [AMapServices sharedServices].apiKey = AMapKey;
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, ScreenH - 64)];
    //设置缩放级别
    self.mapView.zoomLevel = 16;
    
    ///把地图添加至view
    [self.view addSubview:self.mapView];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    self.mapView.delegate = self;
    
    
}

#pragma mark --mapdelegate
//初始化之后,搜索
- (void)mapInitComplete:(MAMapView *)mapView {

    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [self searchPOIAroundWithKeywords:@"银行"];
    [self searchPOIAroundWithKeywords:@"医院"];
}

//修改大头针图标
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        
        if ([annotation.subtitle isEqualToString:@"医院"]) {
          
            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
            MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
            }
            annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
            //        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
            annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
            annotationView.image = [UIImage imageNamed:@"location_hospital"];
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -18);
            return annotationView;
        } else {
        
            static NSString *reuseIndetifier = @"annotationReuseIndetifier";
            MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
            if (annotationView == nil)
            {
                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
            }
            annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
            //        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
            annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
            annotationView.image = [UIImage imageNamed:@"location_bank"];
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -18);
            return annotationView;
        }
        
        
    }
    return nil;
}


//搜索request
- (void)searchPOIAroundWithKeywords:(NSString *)keywords {

    //request
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location = [AMapGeoPoint locationWithLatitude:self.mapView.userLocation.location.coordinate.latitude longitude:self.mapView.userLocation.location.coordinate.longitude];
    
    request.keywords = keywords;
//    request.radius = 1000;
    /* 按照距离排序. */
//    request.sortrule = 0;
//    request.requireExtension = YES;
    
    [self.search AMapPOIAroundSearch:request];
    
}

#pragma mark --searchdelegate
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    AMapPOIAroundSearchRequest *requestAround = (AMapPOIAroundSearchRequest *)request;
    
    if ([requestAround.keywords isEqualToString:@"银行"]) {
        [response.pois enumerateObjectsUsingBlock:^(AMapPOI * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude);
            pointAnnotation.title = obj.name;
            pointAnnotation.subtitle = @"银行";
            
            [self.mapView addAnnotation:pointAnnotation];
            
        }];
    } else {
    
        [response.pois enumerateObjectsUsingBlock:^(AMapPOI * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(obj.location.latitude, obj.location.longitude);
            pointAnnotation.title = obj.name;
            pointAnnotation.subtitle = @"医院";
            
            [self.mapView addAnnotation:pointAnnotation];
        }];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
