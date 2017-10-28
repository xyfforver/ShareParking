//
//  ParkingSpaceMapView.h
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
@interface ParkingSpaceMapView : UIView
@property (nonatomic , strong) BMKMapView *mapView;
@property (nonatomic,strong) BMKLocationService *service;//定位服务

- (void)setUpMapDelegate;
@end
