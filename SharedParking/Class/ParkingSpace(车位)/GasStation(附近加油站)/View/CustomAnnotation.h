//
//  CustomAnnotation.h
//  SharedParking
//
//  Created by galaxy on 2017/10/31.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "GasStationModel.h"
typedef NS_ENUM(NSUInteger,CustomAnnotationType) {
    CustomAnnotationTypeGasStation= 1,
    CustomAnnotationTypeNearShopParking,
    CustomAnnotationTypeNearParking
};
@interface CustomAnnotation : BMKPointAnnotation
@property (nonatomic , assign) CustomAnnotationType customType;

@property (nonatomic , strong) GasStationModel *gasStationModel;
@end
