//
//  CarportShortItemModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportShortItemModel.h"

@implementation CarportShortItemModel

- (void)setCar_chepai:(NSString *)car_chepai{
    _car_chepai = car_chepai;
    
    self.parking_number = car_chepai;
}

@end
