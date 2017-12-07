//
//  MyReserveModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyReserveModel.h"

@implementation MyReserveModel


- (void)setPark_jwd:(NSString *)park_jwd{
    _park_jwd = park_jwd;
    
    if ([park_jwd containsString:@","]) {
        NSArray *array = [park_jwd componentsSeparatedByString:@","];
        self.latitude = [[array lastObject] floatValue];
        self.longitude = [[array firstObject] floatValue];
    }
}


//我的预订
+ (void)myReserveWithPage:(NSInteger )page success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(@(page), @"page");
    [self postWithStatusModelResponsePath:@"user_reserve" params:ParamsDic onCompletion:success];
}

//取消预订
+ (void)cancelReserveWithId:(NSString *)reserveId success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(reserveId, @"reserve_id");
    [self postWithStatusModelResponsePath:@"cancel_reserve" params:ParamsDic onCompletion:success];
}
@end
