//
//  CarportLongListModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/4.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportLongListModel.h"

@implementation CarportLongListModel

- (void)setPark_jwd:(NSString *)park_jwd{
    _park_jwd = park_jwd;
    
    if ([park_jwd containsString:@","]) {
        NSArray *array = [park_jwd componentsSeparatedByString:@","];
        self.latitude = [[array lastObject] floatValue];
        self.longitude = [[array firstObject] floatValue];
    }
}

//停车场长租列表
+ (void)carportLongListWithPage:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@(page) forKey:@"page"];
    [ParamsDic setObject:@"1" forKey:@"parking_type"];
    [ParamsDic setObject:GetDataManager.latitude forKey:@"lat"];
    [ParamsDic setObject:GetDataManager.longitude forKey:@"lng"];
    [ParamsDic setObject:GetDataManager.selectCity forKey:@"shi"];
    [self postWithStatusRecordListModelResponsePath:@"park_wordlist" params:ParamsDic onCompletion:success];
}


@end
