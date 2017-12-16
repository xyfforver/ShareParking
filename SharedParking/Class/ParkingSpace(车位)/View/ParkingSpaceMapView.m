//
//  ParkingSpaceMapView.m
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceMapView.h"
#import "GasStationVC.h"
#import "FuelCounterVC.h"
#import "FindBreakRulesVC.h"
#import "MyRequestVC.h"

#import "RobParkingView.h"
#import "LongRentView.h"
#import "ParkingOrderView.h"

#import "CarportShortListModel.h"
#import "CarportLongListModel.h"
#import "CustomAnnotation.h"

#import "BMKClusterManager.h"
#import "XJCluster.h"
#import "XJClusterAnnotation.h"
#import "XJClusterAnnotationView.h"

#define viewMultiple 2
@interface ParkingSpaceMapView ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,XJClusterAnnotationViewDelegate>
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIButton *userCenterBtn;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *minusBtn;
@property (nonatomic,strong) BMKClusterManager *clusterManager;//点聚合管理类
@property (nonatomic,assign) NSInteger clusterZoom;//聚合级别

/// 当前地图的中心点
@property (nonatomic) CLLocationCoordinate2D cCoordinate;
@property (nonatomic , strong) RobParkingView *itemView;
@property (nonatomic , strong) LongRentView *rentView;
@property (nonatomic , strong) ParkingOrderView *orderView;
@end

@implementation ParkingSpaceMapView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setType:(CarportRentType)type{
    _type = type;
}

#pragma mark ---------------network ---------------------/
- (void)loadMapData{
    self.type != CarportLongRentType ? [self loadShortMapData] : [self loadLongMapData];
}

- (void)loadShortMapData{
    kSelfWeak;
    
    [CarportShortListModel carportShortListWithLatitude:self.cCoordinate.latitude longitude:self.cCoordinate.longitude success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            strongSelf.dataArr = dataArr;
            [strongSelf addAnnoWithPT];
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

- (void)loadLongMapData{
    kSelfWeak;
    [CarportShortListModel carportLongListWithLatitude:self.cCoordinate.latitude longitude:self.cCoordinate.longitude success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            NSArray *dataArr = statusModel.data;
            strongSelf.dataArr = dataArr;
            [strongSelf addAnnoWithPT];
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}


- (void)addAnnoWithPT{
    [_clusterManager clearClusterItems];
    for (CarportShortListModel *model in self.dataArr) {
        XJCluster *cluster = [[XJCluster alloc] init];
        cluster.name = [NSString stringWithFormat:@"￥%.2f元",model.park_fee];
        
        CLLocationCoordinate2D coor;
        coor.latitude = model.latitude;
        coor.longitude = model.longitude;
        cluster.pt = coor;
        cluster.shortModel = model;
        
        BMKClusterItem *clusterItem = [[BMKClusterItem alloc] init];
        clusterItem.coor = cluster.pt;
        clusterItem.title = cluster.name;
        clusterItem.kongxiandu = model.kongxiandu;
        clusterItem.cluster = cluster;
        [_clusterManager addClusterItem:clusterItem];
    }
    
    [self updateClusters];
}

#pragma mark -----------------ww ---------------------/
//更新聚合状态
- (void)updateClusters {
    
    _clusterZoom = (NSInteger)_mapView.zoomLevel;
//    @synchronized(_clusterCaches) {
    
        
        NSMutableArray *clusters = [NSMutableArray array];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            ///获取聚合后的标注
            __block NSArray *array = [_clusterManager getClusters:_clusterZoom];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                for (BMKCluster *item in array) {
                    XJClusterAnnotation *annotation = [[XJClusterAnnotation alloc] init];
                    annotation.coordinate = item.coordinate;
                    annotation.size = item.size;
                    annotation.title = item.title;
                    annotation.cluster = item.cluster;
                    [clusters addObject:annotation];
                }
                [_mapView removeOverlays:_mapView.overlays];
                [_mapView removeAnnotations:_mapView.annotations];
                [_mapView addAnnotations:clusters];
                
            });
        });
//    }
}


#pragma mark - XJClusterAnnotationViewDelegate
- (void)didAddreesWithClusterAnnotationView:(XJCluster *)cluster clusterAnnotationView:(XJClusterAnnotationView *)clusterAnnotationView{
    
//    if (clusterAnnotationView.size > 3) {
        //        [_mapView setCenterCoordinate:clusterAnnotationView.annotation.coordinate];
        //        [_mapView zoomIn];
//    }
}

- (void)onGetDistrictResult:(BMKDistrictSearch *)searcher result:(BMKDistrictResult *)result errorCode:(BMKSearchErrorCode)error {
    
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = result.center;//中心点
    region.span.latitudeDelta = 0.02;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.02;//纬度范围
    [_mapView setRegion:region animated:YES];
}

#pragma mark --------------- Map Delegate ---------------------/
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //屏幕坐标转地图经纬度
    CLLocationCoordinate2D MapCoordinate = [_mapView convertPoint:_mapView.center toCoordinateFromView:_mapView];
    
    DLog(@"regionDidChangeAnimated:%f---%f",MapCoordinate.latitude , MapCoordinate.longitude);
    
    [self loadMapData];

}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    NSString *AnnotationViewID = @"ClusterMark";
    XJClusterAnnotation *cluster = (XJClusterAnnotation*)annotation;
    XJClusterAnnotationView *annotationView = [[XJClusterAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    annotationView.title = cluster.title;
    annotationView.kongxiandu = cluster.cluster.kongxiandu;
    annotationView.size = cluster.size;
    annotationView.cluster = cluster.cluster;
    annotationView.delegate = self;
    annotationView.canShowCallout = NO;//在点击大头针的时候会弹出那个黑框框
    annotationView.draggable = NO;//禁止标注在地图上拖动
    annotationView.annotation = cluster;
    
    UIView *viewForImage=[[UIView alloc]init];
    UIImageView *imageview=[[UIImageView alloc]init];
    CGSize contentSize = [HelpTool sizeWithString:cluster.title font:kFontSize15 maxSize:CGSizeMake(kScreenWidth- 100, 35)];
    CGFloat XJ_OffsetX = 15.0f;
    [viewForImage setFrame:CGRectMake(0, 0, (contentSize.width + XJ_OffsetX ) *viewMultiple, (contentSize.height + XJ_OffsetX ) *viewMultiple)];
    [imageview setFrame:CGRectMake(0, 0, (contentSize.width + XJ_OffsetX ) *viewMultiple, (contentSize.height + XJ_OffsetX ) *viewMultiple)];
    annotationView.mj_size = CGSizeMake(contentSize.width + 10, 50);
    
    [imageview setImage:[UIImage imageNamed:@"kong"]];
    
    imageview.layer.masksToBounds=YES;
    imageview.layer.cornerRadius = 10;
    [viewForImage addSubview:imageview];
    annotationView.image = [HelpTool getImageFromView:viewForImage];
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    if ([view isKindOfClass:[XJClusterAnnotationView class]]) {
        XJClusterAnnotationView *anView = (XJClusterAnnotationView *)view;
        anView.imageView.image = [UIImage imageNamed:@"map_leisure4"];
    
        [self showInfoView:anView.cluster];
    }
    
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    if ([view isKindOfClass:[XJClusterAnnotationView class]]) {
        XJClusterAnnotationView *anView = (XJClusterAnnotationView *)view;
        anView.imageView.image = [UIImage imageNamed:[HelpTool imageStringWithLeisure:anView.cluster.kongxiandu]];
    }
    
    [self dismissInfoView];
}

/**
 *地图初始化完毕时会调用此接口
 *@param mapView 地图View
 */
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    displayParam.isAccuracyCircleShow = NO;//精度圈是否显示
    [_mapView updateLocationViewWithParam:displayParam];
    
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = _mapView.centerCoordinate;//中心点
    
    region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.2;//纬度范围
    [_mapView setRegion:region animated:YES];
    [self updateClusters];
}

#pragma mark --------------- 定位 ---------------------/
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    
    if (!self.cCoordinate.latitude) {
        self.mapView.centerCoordinate = userLocation.location.coordinate;
    }

    [self updateClusters];
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);

    //初始化逆地理编码类
    BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
    //需要逆地理编码的坐标位置
    reverseGeoCodeOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL reg = [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
    if (reg) {
        NSLog(@"_____编码成功");
    }else{
        NSLog(@"_____编码失败");
    }
}


/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR){
        
        GetDataManager.selectCity = [NSString isNull:result.addressDetail.city] ?
        GetDataManager.selectCity : result.addressDetail.city;
        
        GetDataManager.geoCodeResult = result;
        DLog(@"%@------%@------%@",GetDataManager.latitude,GetDataManager.longitude,GetDataManager.selectCity);
        [self loadMapData];
//        if (self.loadBlock) {
//            self.loadBlock();
//        }
        
    }else if (error == BMK_SEARCH_PERMISSION_UNFINISHED){
        
    }
}


#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    
    GetDataManager.selectCity = @"杭州市";
    
    [self addSubview:self.mapView];
    [self addSubview:self.imgView];
    [self addSubview:self.userCenterBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.minusBtn];
    [self addSubview:self.itemView];
    [self addSubview:self.rentView];
    [self addSubview:self.orderView];
    
    _clusterManager = [[BMKClusterManager alloc] init];
    
    [self addItemButton];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
    }];
    
    [self.userCenterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView);
        make.bottom.mas_equalTo(-15);
    }];
    
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.userCenterBtn);
        make.width.height.mas_equalTo(35);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self.minusBtn.mas_top);
        make.width.height.mas_equalTo(self.minusBtn);
    }];
}

- (void)setUpMapDelegate{
    self.mapView.delegate = self;
    self.service.delegate = self;
    self.geoCodeSearch.delegate = self;
    [self.service startUserLocationService];
}

- (void)cancelMapDelegate{
    self.mapView.delegate = nil; // 不用时，置nil
    //关闭定位
    [self.service stopUserLocationService];
    self.service.delegate = nil;
    
    self.geoCodeSearch.delegate = nil;
}

- (void)addItemButton{
    NSArray *titleArr = @[@"求租",@"违章",@"加油",@"油耗"];
    NSArray *imgArr = @[@"home_rent",@"home_search",@"home_addFuel",@"home_fuel"];
    CGFloat itemWidth = 40;
    for (int i = 0; i < imgArr.count; i++) {
        UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        itemBtn.titleLabel.font = kFontSize10;
        [itemBtn setTitleColor:kColor4292D3 forState:UIControlStateNormal];
        [itemBtn setBackgroundColor:kColorWhite];
        [itemBtn addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.layer.cornerRadius = 3;
        itemBtn.layer.borderColor = kBackGroundGrayColor.CGColor;
        itemBtn.layer.borderWidth = 0.5;
        itemBtn.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
        itemBtn.layer.shadowOffset = CGSizeMake(2,2);
        itemBtn.layer.shadowOpacity = 0.5;
        itemBtn.layer.shadowRadius = 2;
        
        itemBtn.tag = 100 + i;
        itemBtn.frame = CGRectMake(kScreenWidth - itemWidth - 15, 15 + i * (itemWidth + 15), itemWidth, itemWidth);
        [itemBtn lc_imageTitleVerticalAlignmentWithSpace:1];
        
        [self addSubview:itemBtn];
    }
}

#pragma mark ---------------event ---------------------/
- (void)itemAction:(UIButton *)button{
    if (!GetDataManager.isLogin) {
        LoginVC *vc = [[LoginVC alloc]init];
        JKNavigationController *loginNav = [[JKNavigationController alloc] initWithRootViewController:vc];
        [self.Controller presentViewController:loginNav animated:YES completion:nil];
        
        return;
    }
    
    NSInteger tag = button.tag - 100;
    switch (tag) {
        case 0:{
            MyRequestVC *vc = [[MyRequestVC alloc]init];
            [self.Controller.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            FindBreakRulesVC *vc = [[FindBreakRulesVC alloc]init];
            [self.Controller.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            GasStationVC *vc = [[GasStationVC alloc]init];
            [self.Controller.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            FuelCounterVC *vc = [[FuelCounterVC alloc]init];
            [self.Controller.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
    
    
}

- (void)userCenterAction:(UIButton *)button{
    
}

- (void)addAction:(UIButton *)button{
    NSInteger zoomLevel = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:zoomLevel + 1];
}

- (void)minusAction:(UIButton *)button{
    NSInteger zoomLevel = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:zoomLevel - 1];
}

- (void)showInfoView:(XJCluster *)cluster{
    if (self.type == CarportShortRentType) {
        self.itemView.hidden = NO;
        self.rentView.hidden = YES;
        self.itemView.shortModel = cluster.shortModel;
    }else{
        self.itemView.hidden = YES;
        self.rentView.hidden = NO;
        self.rentView.model = cluster.shortModel;
    }
}

- (void)dismissInfoView{
    self.itemView.hidden = YES;
    self.rentView.hidden = YES;
}

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

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"home_busy"];
    }
    return _imgView;
}

- (UIButton *)userCenterBtn{
    if (!_userCenterBtn) {
        _userCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userCenterBtn setImage:[UIImage imageNamed:@"home_location"] forState:UIControlStateNormal];
        [_userCenterBtn addTarget:self action:@selector(userCenterAction:) forControlEvents:UIControlEventTouchUpInside];
        [_userCenterBtn setEnlargeEdge:5];
    }
    return _userCenterBtn;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont fontWithName:CUSTOMFONTULTRABOLD size:22];
        [_addBtn setTitleColor:kColorDeepBlack forState:UIControlStateNormal];
        [_addBtn setBackgroundColor:kColorWhite];
        [_addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)minusBtn{
    if (!_minusBtn) {
        _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusBtn setTitle:@"-" forState:UIControlStateNormal];
        _minusBtn.titleLabel.font = [UIFont fontWithName:CUSTOMFONTULTRABOLD size:22];
        [_minusBtn setTitleColor:kColorDeepBlack forState:UIControlStateNormal];
        [_minusBtn setBackgroundColor:kColorWhite];
        [_minusBtn addTarget:self action:@selector(minusAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusBtn;
}

- (BMKLocationService *)service{
    if (!_service) {
        _service = [[BMKLocationService alloc]init];
        _service.desiredAccuracy =  kCLLocationAccuracyBest;
        _service.distanceFilter = 100;//大于100米
    }
    return _service;
}


- (BMKGeoCodeSearch *)geoCodeSearch{
    if (!_geoCodeSearch) {
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    }
    return _geoCodeSearch;
}


- (RobParkingView *)itemView{
    if (!_itemView) {
        _itemView = [[RobParkingView alloc]initWithFrame:CGRectMake(40, self.height - [RobParkingView getHeight] - 50, kScreenWidth - 40 * 2, [RobParkingView getHeight])];
        _itemView.hidden = YES;
    }
    return _itemView;
}

- (LongRentView *)rentView{
    if (!_rentView) {
        _rentView = [[LongRentView alloc]initWithFrame:CGRectMake(40, self.height - [LongRentView getHeight] - 50, kScreenWidth - 40 * 2, [LongRentView getHeight])];
        _rentView.hidden = YES;
    }
    return _rentView;
}

- (ParkingOrderView *)orderView{
    if (!_orderView) {
        _orderView = [[ParkingOrderView alloc]initWithFrame:CGRectMake(40, self.height - [ParkingOrderView getHeight] - 50, kScreenWidth - 40 * 2, [ParkingOrderView getHeight])];
        _orderView.hidden = YES;
    }
    return _orderView;
}

@end
