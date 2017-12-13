//
//  FuelCounterModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelCounterModel.h"

@implementation FuelCounterModel


+ (void)getAddFuelRecordWithSuccess:(NetCompletionBlock)success{
    [self postWithStatusModelResponsePath:@"refuel_calculation" params:nil onCompletion:success];
}


@end
