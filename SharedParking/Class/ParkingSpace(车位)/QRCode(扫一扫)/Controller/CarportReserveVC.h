//
//  CarportReserveVC.h
//  SharedParking
//
//  Created by galaxy on 2017/11/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "BaseViewController.h"

@interface CarportReserveVC : BaseViewController

- (instancetype)initWithParkingId:(NSString *)parkingId;

@property (nonatomic , copy) NSString *parkingId;

@end
