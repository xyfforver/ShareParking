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
@interface GasStationVC ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate>
@property (nonatomic , strong) BMKMapView *mapView;
@property (nonatomic,strong) BMKLocationService *service;//定位服务
@property (nonatomic,strong) BMKPoiSearch *poiSearch;//搜索服务

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

    [self.infoView show];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark --------------- Map Delegate ---------------------/
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{

        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        BMKAnnotationView *annotationView = (BMKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil){
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.frame = CGRectMake(0, 0, 100, 100);
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO

        annotationView.image = [UIImage imageNamed:@"home_gasStation"];//parking_carloc
//        
//        BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:view];
//        
//        ((BMKAnnotationView*)annotationView).paopaoView = pView;
        
        annotationView.draggable = YES;
        
        return annotationView;

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

    self.mapView.centerCoordinate = userLocation.location.coordinate;
    
    if (self.mapView.annotations.count == 0) {
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
        BMKPointAnnotation *point = [[BMKPointAnnotation alloc]init];
        point.coordinate = coor;
        point.title = poi.name;
        [self.mapView addAnnotation: point];
    }
}

#pragma mark ---------------计算两点之间的距离 ---------------------/
- (double)CalculateTheDistanceWithLon1:(double) lon1
                                 Lat1:(double) lat1
                                 Lon2:(double) lon2
                                 Lat2:(double) lat2{
    double er = 6371393.0f;//地球半径
    //第一个位置的经纬度
    double radlong1 = M_PI*lon1/180.0f;
    double radlat1 = M_PI*lat1/180.0f;
    //第二个位置的经纬度
    double radlat2 = M_PI*lat2/180.0f;
    double radlong2 = M_PI*lon2/180.0f;
    //判断经纬度的正负
    if( radlat1 < 0 ) radlat1 = M_PI/2 + fabs(radlat1);
    if( radlat1 > 0 ) radlat1 = M_PI/2 - fabs(radlat1);
    if( radlat2 < 0 ) radlat2 = M_PI/2 + fabs(radlat2);
    if( radlat2 > 0 ) radlat2 = M_PI/2 - fabs(radlat2);
    if( radlong2 < 0 ) radlong2 = M_PI*2 - fabs(radlong2);
    
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    
    double dist  = theta * er;
    //返回最终的距离
    return dist;
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
