//
//  ParkingOrderView.h
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarportReserveModel"
@interface ParkingOrderView : UIView

@property (strong, nonatomic) CarportReserveModel *reserveModel;


+ (CGFloat)getHeight;
@end
