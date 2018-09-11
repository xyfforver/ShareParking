//
//  ParkingRecordModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingRecordModel.h"

@implementation ParkingRecordModel


//停车记录
+ (void)parkingRecordWithPage:(NSInteger )page success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(@(page), @"page");
    [self postWithStatusModelResponsePath:@"user_order" params:ParamsDic onCompletion:success];
}

//车位订单详情
+ (void)orderInfoWithOrderId:(NSString *)orderId success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(orderId, @"order_id");
    [self postWithStatusModelResponsePath:@"parking_openlocktime" params:ParamsDic onCompletion:success];
}

//上锁
+ (void)lockWithOrderId:(NSString *)orderId payType:(NSString *)payType price:(NSString *)price zeroType:(NSString *)zerotype success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(orderId, @"order_id");
    DicObjectSet(payType, @"order_paytype");
    DicObjectSet(price, @"order_fee");
    DicObjectSet(zerotype, @"zero_type")
    [self postWithStatusModelResponsePath:@"parking_closelock" params:ParamsDic onCompletion:success];
}

//停车费用
+ (void)parkingPayWithOrderId:(NSString * )orderid success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(orderid, @"order_id");
    [self postWithStatusModelResponsePath:@"app_rule" params:ParamsDic onCompletion:success];
}


@end
