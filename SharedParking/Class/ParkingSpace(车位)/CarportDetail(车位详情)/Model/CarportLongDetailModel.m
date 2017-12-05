//
//  CarportLongDetailModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/5.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportLongDetailModel.h"

@implementation CarportLongDetailModel

//停车场详情
+ (void)carportLongDetailWithCarPortId:(NSString *)carPortId success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:carPortId forKey:@"id"];
    [ParamsDic setObject:@"1" forKey:@"parking_type"];
    [ParamsDic setObject:@"30" forKey:@"lat"];
    [ParamsDic setObject:@"120" forKey:@"lng"];
    [self postWithStatusModelResponsePath:@"park_xq" params:ParamsDic onCompletion:success];
}

@end
