//
//  CarportDetailModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/4.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportDetailModel.h"

@implementation CarportDetailModel


//停车场详情
+ (void)carportDetailWithCarPortId:(NSString *)carPortId type:(NSInteger)type success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:carPortId forKey:@"id"];
    [ParamsDic setObject:@(type) forKey:@"parking_type"];
    [self postWithStatusModelResponsePath:@"park_xq" params:ParamsDic onCompletion:success];
}






@end
