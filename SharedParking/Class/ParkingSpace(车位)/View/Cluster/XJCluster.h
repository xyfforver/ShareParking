//
//  XJCluster.h
//  BMKMapClusterView
//
//  Created by 蒋诗颖 on 2017/5/3.
//  Copyright © 2017年 BaiduMap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CarportShortListModel.h"
@interface XJCluster : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign)NSInteger kongxiandu;
@property (nonatomic, assign)CLLocationCoordinate2D pt;

@property (nonatomic,strong) CarportShortListModel *shortModel;
@end
