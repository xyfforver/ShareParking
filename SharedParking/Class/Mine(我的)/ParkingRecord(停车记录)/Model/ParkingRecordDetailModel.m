//
//  ParkingRecordDetailModel.m
//  SharedParking
//
//  Created by 尉超 on 2018/1/20.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import "ParkingRecordDetailModel.h"

@implementation ParkingRecordDetailModel


//订单详情
+ (void)parkingorderInfoWithOrderId:(NSString *)orderId success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(orderId, @"order_id");
    [self postWithStatusModelResponsePath:@"order_xq" params:ParamsDic onCompletion:success];
}
@end
