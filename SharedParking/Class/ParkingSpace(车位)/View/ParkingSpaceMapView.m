//
//  ParkingSpaceMapView.m
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceMapView.h"
@interface ParkingSpaceMapView ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>

@end

@implementation ParkingSpaceMapView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    
    [self addSubview:self.mapView];
}

- (void)setUpMapDelegate{
    self.mapView.delegate = self;
}

#pragma mark ---------------event ---------------------/

#pragma mark -----------------Lazy---------------------/
- (BMKMapView *)mapView{
    if (!_mapView) {
        ///初始化地图
        _mapView = [[BMKMapView alloc] initWithFrame:self.bounds];
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


@end
