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
@end
