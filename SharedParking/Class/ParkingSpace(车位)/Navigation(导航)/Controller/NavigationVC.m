//
//  NavigationVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "NavigationVC.h"
#import "NavigationBottomView.h"
@interface NavigationVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
@property (nonatomic , strong) BMKMapView *mapView;
@property (nonatomic , strong) BMKLocationService *service;//定位服务
@property (nonatomic , strong) NavigationBottomView *bottomView;
@end

@implementation NavigationVC

#pragma mark ---------------LifeCycle-------------------------/
- (instancetype)initWithLatitude:(CGFloat )latitude longitude:(CGFloat)longitude{
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"导航";
    
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:nil imageName:@"home_qrcode" target:self action:@selector(codeAction)];
    
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.bottomView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/
- (void)codeAction{
    
}

#pragma mark ---------------Lazy-------------------------/
- (BMKMapView *)mapView{
    if (!_mapView) {
        ///初始化地图
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight - 80 - kTabbarSafeBottomMargin)];
        _mapView.delegate = self;
        _mapView.rotateEnabled = NO;//禁用旋转手势
        [_mapView setMapType:BMKMapTypeStandard];
        _mapView.isSelectedAnnotationViewFront = YES;//选中图标显示在最上面
        
        //在手机上当前可使用的级别为3-21级
        _mapView.zoomLevel = 13;
        
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;
        //
        
        BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
        displayParam.isAccuracyCircleShow = false;//精度圈是否显示
        [_mapView updateLocationViewWithParam:displayParam];
    }
    return _mapView;
}

- (NavigationBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NavigationBottomView alloc]initWithFrame:CGRectMake(0, self.mapView.bottom, kScreenWidth, 80 + kTabbarSafeBottomMargin)];
    }
    return _bottomView;
}
@end
