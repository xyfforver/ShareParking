//
//  CarportReserveModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportReserveModel.h"
#import "CarportShortItemModel.h"
@implementation CarportReserveModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"car_chepai":[CarportShortItemModel class]};
}

//停车场预订 详情
+ (void)carportReserveWithParkingId:(NSString *)parkingId success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(parkingId, @"parking_id");
    [self postWithStatusModelResponsePath:@"parking_click" params:ParamsDic onCompletion:success];
    
}

//预订
+ (void)reserveWithParkingId:(NSString *)parkingId carNumId:(NSString *)carNumId success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(parkingId, @"parking_id");
    DicObjectSet(carNumId, @"chepai_id");
    [self postWithStatusModelResponsePath:@"parking_reserve" params:ParamsDic onCompletion:success];
}

//预订成功
+ (void)reserveWithReserveId:(NSString *)reserveId success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(reserveId, @"reserve_id");
    [self postWithStatusModelResponsePath:@"reserve_success" params:ParamsDic onCompletion:success];
}

@end
