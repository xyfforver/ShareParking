//
//  CarportListModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/2.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportListModel.h"

@implementation CarportListModel

//停车场列表
+ (void)carportListWithCity:(NSString *)city type:(NSInteger)type page:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@(page) forKey:@"page"];
    [ParamsDic setObject:@(type) forKey:@"parking_type"];
    [ParamsDic setObject:@"30" forKey:@"lat"];
    [ParamsDic setObject:@"120" forKey:@"lng"];
    [ParamsDic setObject:city forKey:@"shi"];
    [self postWithStatusRecordListModelResponsePath:@"park_wordlist" params:ParamsDic onCompletion:success];
}

@end
