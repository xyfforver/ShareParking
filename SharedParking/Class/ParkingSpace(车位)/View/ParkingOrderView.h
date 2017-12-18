//
//  ParkingOrderView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarportReserveModel.h"
@interface ParkingOrderView : UIView

@property (strong, nonatomic) CarportReserveModel *reserveModel;

@property (nonatomic , copy) void(^loadBlock)(void);

+ (CGFloat)getHeight;
@end
