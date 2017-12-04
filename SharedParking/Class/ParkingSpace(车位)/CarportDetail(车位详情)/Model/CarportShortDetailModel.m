//
//  CarportShortDetailModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/4.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportShortDetailModel.h"

@implementation CarportShortDetailModel


//停车场详情
+ (void)carportShortDetailWithCarPortId:(NSString *)carPortId type:(NSInteger)type success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:carPortId forKey:@"id"];
    [ParamsDic setObject:@(type) forKey:@"parking_type"];
    [ParamsDic setObject:@"30" forKey:@"lat"];
    [ParamsDic setObject:@"120" forKey:@"lng"];
    [self postWithStatusModelResponsePath:@"park_xq" params:ParamsDic onCompletion:success];
}






@end
