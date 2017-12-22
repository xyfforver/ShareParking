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

@property (nonatomic) CLLocationCoordinate2D userCoordinate;
@end

@implementation NavigationVC

#pragma mark ---------------LifeCycle-------------------------/
- (instancetype)initWithLatitude:(CGFloat )latitude longitude:(CGFloat)longitude titleStr:(NSString *)titleStr{
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
        self.titleStr = titleStr;
        
        self.title = titleStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self addAnnotations];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self;
    self.service.delegate = self;
    [self.service startUserLocationService];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.mapView.delegate = nil; // 不用时，置nil
    //关闭定位
    [self.service stopUserLocationService];
    self.service.delegate = nil;
    
}

- (void)initView{
    self.title = @"导航";
    self.fd_interactivePopDisabled = YES;
    
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:nil imageName:@"home_qrcode" target:self action:@selector(codeAction)];
    
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.bottomView];
    
}

//添加大头针
- (void)addAnnotations{
    BMKPointAnnotation *annotation =  [[BMKPointAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    annotation.title = self.titleStr;
    [self.mapView addAnnotation:annotation];
}
#pragma mark ---------------NetWork-------------------------/


#pragma mark --------------- 定位 ---------------------/
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    
    if (!self.userCoordinate.latitude) {
        self.mapView.centerCoordinate = userLocation.location.coordinate;
    }
    self.userCoordinate = userLocation.location.coordinate;;
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //如果是注释点
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        //根据注释点,创建并初始化注释点视图
        BMKPinAnnotationView  *newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"an"];
        
        //设置大头针的颜色
        newAnnotation.pinColor = BMKPinAnnotationColorRed;
        
        //设置动画
        newAnnotation.animatesDrop = YES;
        
        return newAnnotation;
        
    }
    
    return nil;
}


#pragma mark ---------------Event-------------------------/
- (void)codeAction{
    [self openQRCode];
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

- (BMKLocationService *)service{
    if (!_service) {
        _service = [[BMKLocationService alloc]init];
        _service.desiredAccuracy =  kCLLocationAccuracyBest;
        _service.distanceFilter = 100;//大于100米
    }
    return _service;
}


- (NavigationBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[NavigationBottomView alloc]initWithFrame:CGRectMake(0, self.mapView.bottom, kScreenWidth, 80 + kTabbarSafeBottomMargin)];
    }
    return _bottomView;
}
@end
