//
//  GasStationVC.m
//  SharedParking
//
//  Created by galaxy on 2017/10/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "GasStationVC.h"
#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

#import "GasStationInfoView.h"
#import "CustomAnnotation.h"
@interface GasStationVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
@property (nonatomic , strong) BMKMapView *mapView;
@property (nonatomic , strong) BMKLocationService *service;//定位服务
@property (nonatomic , strong) BMKPoiSearch *poiSearch;//搜索服务
@property (nonatomic , assign) CLLocationCoordinate2D userCoordinate;
@property (nonatomic , strong) GasStationInfoView *infoView;
@end

@implementation GasStationVC

#pragma mark ---------------LifeCycle-------------------------/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.mapView.delegate = nil; // 不用时，置nil
    //关闭定位
    [self.service stopUserLocationService];
    self.service.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"附近加油站";
    self.fd_interactivePopDisabled = YES;
    
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.infoView];
    
    //初始化定位
    self.service = [[BMKLocationService alloc] init];
    //设置代理
    self.service.delegate = self;
    //开启定位
    [self.service startUserLocationService];

}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark --------------- Map Delegate ---------------------/
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    if ([annotation isKindOfClass:[CustomAnnotation class]]){

        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        BMKAnnotationView *annotationView = (BMKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil){
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.frame = CGRectMake(0, 0, 100, 100);
        annotationView.canShowCallout= NO;       //设置气泡可以弹出，默认为NO

        annotationView.image = [UIImage imageNamed:@"home_gasStation"];
        
        annotationView.draggable = YES;
        
        return annotationView;
    }
    return nil;
}


- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    CustomAnnotation *annotation = (CustomAnnotation *) view.annotation;
    if(annotation.customType == CustomAnnotationTypeGasStation){
        //店铺
        self.infoView.gasStationModel = annotation.gasStationModel;
        [self.infoView show];

    }else{
        [self.infoView dismiss];
    }
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    
    [self.infoView dismiss];
}

#pragma mark --------------- 定位 ---------------------/
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //展示定位
    self.mapView.showsUserLocation = YES;
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
//    DLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //展示定位
    self.mapView.showsUserLocation = YES;
    //更新位置数据
    [self.mapView updateLocationData:userLocation];

    self.userCoordinate = userLocation.location.coordinate;
    if (self.mapView.annotations.count == 0) {
        self.mapView.centerCoordinate = userLocation.location.coordinate;
        
        [self addNearGasStationWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    }
}


#pragma mark -------搜索-------------------------
- (void)addNearGasStationWithLatitude:(CGFloat)latitude longitude:(CGFloat )longitude{
    CLLocationCoordinate2D coordinate = {latitude,longitude};
    //初始化搜索
    self.poiSearch =[[BMKPoiSearch alloc] init];
    self.poiSearch.delegate = self;
    
    //初始化一个周边云检索对象
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc] init];
    
    //索引 默认为0
    option.pageIndex = 0;
    //页数默认为10
    option.pageCapacity = 20;
    //搜索半径
    option.radius = 10000;
    //检索的中心点，经纬度
    option.location = coordinate;
    //搜索的关键字
    option.keyword = @"加油站";
    
    //根据中心点、半径和检索词发起周边检索
    BOOL flag = [self.poiSearch poiSearchNearBy:option];
    if (flag) {
        NSLog(@"搜索成功");
    }
    else {
        NSLog(@"搜索失败");
    }
}

/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    //若搜索成功
    if (errorCode ==BMK_SEARCH_NO_ERROR) {
        //POI信息类
        //poi列表
        [self setupPointAnotation:poiResult.poiInfoList];
    }
}

#pragma mark --搜索附近成功后设置大头针
-(void)setupPointAnotation:(NSArray *)array{
    
    NSInteger count = array.count > 20 ? 20 : array.count;
    for (int i = 0; i < count; i++) {
        CLLocationCoordinate2D coor;
        BMKPoiInfo *poi = array[i];
        coor.latitude = poi.pt.latitude;
        coor.longitude = poi.pt.longitude;
        CustomAnnotation *point = [[CustomAnnotation alloc]init];
        point.customType = CustomAnnotationTypeGasStation;
        point.coordinate = coor;
        point.title = poi.name;

        GasStationModel *model = [[GasStationModel alloc]init];
        model.title = poi.name;
        model.longitude = coor.longitude;
        model.latitude = coor.latitude;
        model.location = poi.address;
        model.distance = [HelpTool calculateTheDistanceWithLon1:self.userCoordinate.longitude Lat1:self.userCoordinate.latitude Lon2:coor.longitude Lat2:coor.latitude];
        point.gasStationModel = model;
        
        [self.mapView addAnnotation: point];
    }
}

#pragma mark ---------------Lazy-------------------------/
- (BMKMapView *)mapView{
    if (!_mapView) {
        ///初始化地图
        _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
        _mapView.delegate = self;
        _mapView.rotateEnabled = NO;//禁用旋转手势
        [_mapView setMapType:BMKMapTypeStandard];
        _mapView.isSelectedAnnotationViewFront = YES;//选中图标显示在最上面
        
        //在手机上当前可使用的级别为3-21级
        _mapView.zoomLevel = 14;
        
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;
        //
        
        BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
        displayParam.isAccuracyCircleShow = false;//精度圈是否显示
        [_mapView updateLocationViewWithParam:displayParam];
    }
    return _mapView;
}

- (GasStationInfoView *)infoView{
    if (!_infoView) {
        _infoView = [[GasStationInfoView alloc]initWithConfirmBlock:^(CGFloat latitude, CGFloat longitude) {

        }];
    }
    return _infoView;
}

@end
