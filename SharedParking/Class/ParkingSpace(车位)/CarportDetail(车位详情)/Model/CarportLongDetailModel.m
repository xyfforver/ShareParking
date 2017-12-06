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
+ (void)carportLongDetailWithCarportId:(NSString *)carportId success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:carportId forKey:@"id"];
    [ParamsDic setObject:@"1" forKey:@"parking_type"];
    [ParamsDic setObject:GetDataManager.latitude forKey:@"lat"];
    [ParamsDic setObject:GetDataManager.longitude forKey:@"lng"];
    [self postWithStatusModelResponsePath:@"park_xq" params:ParamsDic onCompletion:success];
}

+ (void)browseWithCarportId:(NSString *)carportId success:(NetCompletionBlock)success{
    
    CreateParamsDic;
    DicObjectSet(carportId, @"parking_id");
    [self postWithStatusModelResponsePath:@"parking_views" params:ParamsDic onCompletion:success];
}
@end
