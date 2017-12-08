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

#import "CarportShortListModel.h"
#import "CustomAnnotation.h"
@interface ParkingSpaceMapView ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIButton *userCenterBtn;
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *minusBtn;

@end

@implementation ParkingSpaceMapView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    
    for (int i = 0; i < dataArr.count; i++) {
        CarportShortListModel *mapModel = dataArr[i];

        CLLocationCoordinate2D coor;
        
        coor.latitude = mapModel.latitude;
        coor.longitude = mapModel.longitude;
        DLog(@"%f-----%f",mapModel.latitude,mapModel.longitude);
        CustomAnnotation *point = [[CustomAnnotation alloc]init];
        point.coordinate = coor;
        point.title = mapModel.park_title;
        [self.mapView addAnnotation:point];
    }
}


#pragma mark --------------- Map Delegate ---------------------/
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[CustomAnnotation class]]){
        CustomAnnotation *anno = (CustomAnnotation *)annotation;
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        BMKAnnotationView *annotationView = (BMKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil){
            annotationView = [[BMKAnnotationView alloc] initWithAnnotation:anno reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.image = [UIImage createImageWithColor:kColorRandom];
        annotationView.frame = CGRectMake(0, 0, 100, 100);
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.annotation = anno;
        
        return annotationView;
    }
    
    return nil;
    
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{

}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{

}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    
    GetDataManager.selectCity = @"杭州市";
    
    [self addSubview:self.mapView];
    [self addSubview:self.imgView];
    [self addSubview:self.userCenterBtn];
    [self addSubview:self.addBtn];
    [self addSubview:self.minusBtn];
    
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

//        if (![GetDataManager.geoCodeResult.addressDetail.streetName isEqualToString:result.addressDetail.streetName]) {
        
            NSString *lngNow = [NSString stringWithFormat:@"%.3f",result.location.longitude];
            NSString *lngLast = [NSString stringWithFormat:@"%.3f",[GetDataManager.longitude floatValue]];
            
            NSString *latNow = [NSString stringWithFormat:@"%.3f",result.location.latitude];
            NSString *latLast = [NSString stringWithFormat:@"%.3f",[GetDataManager.latitude floatValue]];

            if (![lngNow isEqualToString:lngLast] || ![latNow isEqualToString:latLast]) {
                GetDataManager.selectCity = [NSString isNull:result.addressDetail.city] ?
                GetDataManager.selectCity : result.addressDetail.city;

                
                GetDataManager.geoCodeResult = result;
                DLog(@"%@------%@------%@",GetDataManager.latitude,GetDataManager.longitude,GetDataManager.selectCity);
                
                if (self.loadBlock) {
                    self.loadBlock();
                }
            }
//        }
        
    }else if (error == BMK_SEARCH_PERMISSION_UNFINISHED){
        
    }
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
    }
    return _service;
}


- (BMKGeoCodeSearch *)geoCodeSearch{
    if (!_geoCodeSearch) {
        _geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
    }
    return _geoCodeSearch;
}

@end
