//
//  FuelModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelModel.h"

@implementation FuelModel

//添加加油记录
+ (void)addFuelRecordWithDateStr:(NSString *)dateStr mileage:(NSString *)mileage price:(NSString *)price  oilPrice:(NSString *)oilPrice oilMass:(NSString *)oilMass success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(dateStr, @"refuel_time");
    DicObjectSet(mileage, @"refuel_licheng");
    DicObjectSet(price, @"refuel_money");
    DicObjectSet(oilPrice, @"refuel_youjia");
    DicObjectSet(oilMass, @"refuel_youliang");

    [self postWithStatusModelResponsePath:@"refuel_add" params:ParamsDic onCompletion:success];
}

//加油记录列表
+ (void)fuelRecordListWithPage:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(@(page), @"page");
    [self postWithStatusRecordListModelResponsePath:@"user_refuel" params:nil onCompletion:success];
}



@end
