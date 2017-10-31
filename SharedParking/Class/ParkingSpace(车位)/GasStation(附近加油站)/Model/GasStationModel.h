//
//  GasStationModel.h
//  SharedParking
//
//  Created by galaxy on 2017/10/31.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseModel.h"

@interface GasStationModel : BaseModel
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,assign) double distance;
@property (nonatomic,assign) CGFloat latitude;
@property (nonatomic,assign) CGFloat longitude;
@end
