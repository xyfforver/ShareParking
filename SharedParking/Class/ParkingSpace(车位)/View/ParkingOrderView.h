//
//  ParkingOrderView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarportReserveModel.h"
#import "ParkingRecordModel.h"
@interface ParkingOrderView : UIView

@property (strong, nonatomic) CarportReserveModel *reserveModel;
@property (strong, nonatomic) ParkingRecordModel *parkRecordModel;
@property (assign, nonatomic) CGFloat price;
@property (nonatomic , copy) void(^loadBlock)(void);

+ (CGFloat)getHeight;
@end
