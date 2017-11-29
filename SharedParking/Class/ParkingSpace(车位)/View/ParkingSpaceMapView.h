//
//  ParkingSpaceMapView.h
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkingSpaceMapView : UIView
@property (nonatomic , strong) BMKMapView *mapView;
@property (nonatomic,strong) BMKLocationService *service;//定位服务

- (void)setUpMapDelegate;
@end
