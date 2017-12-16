//
//  CarportShortListModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/2.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportShortListModel.h"

@implementation CarportShortListModel


- (void)setPark_jwd:(NSString *)park_jwd{
    _park_jwd = park_jwd;
    
    if ([park_jwd containsString:@","]) {
        NSArray *array = [park_jwd componentsSeparatedByString:@","];
        self.latitude = [[array lastObject] floatValue];
        self.longitude = [[array firstObject] floatValue];
    }
}

- (void)setParking_fee:(CGFloat)parking_fee{
    _park_fee = parking_fee;
    
    _parking_fee = parking_fee;
}




//停车场错时列表
+ (void)carportShortListWithPage:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@(page) forKey:@"page"];
    [ParamsDic setObject:@"0" forKey:@"parking_type"];
    [ParamsDic setObject:GetDataManager.latitude forKey:@"lat"];
    [ParamsDic setObject:GetDataManager.longitude forKey:@"lng"];
    [ParamsDic setObject:GetDataManager.selectCity forKey:@"shi"];
    [self postWithStatusRecordListModelResponsePath:@"park_wordlist" params:ParamsDic onCompletion:success];
}

//停车场错时 地图
+ (void)carportShortListWithLatitude:(CGFloat )latitude longitude:(CGFloat)longitude success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@"0" forKey:@"parking_type"];
    [ParamsDic setObject:@(latitude) forKey:@"lat"];
    [ParamsDic setObject:@(longitude) forKey:@"lng"];
    [ParamsDic setObject:GetDataManager.selectCity forKey:@"shi"];
    [self postWithStatusRecordListModelResponsePath:@"park_maplist" params:ParamsDic onCompletion:success];
}

//停车场长租 地图
+ (void)carportLongListWithLatitude:(CGFloat )latitude longitude:(CGFloat)longitude success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@"1" forKey:@"parking_type"];
    [ParamsDic setObject:@(latitude) forKey:@"lat"];
    [ParamsDic setObject:@(longitude) forKey:@"lng"];
    [ParamsDic setObject:GetDataManager.selectCity forKey:@"shi"];
    [self postWithStatusRecordListModelResponsePath:@"park_maplist" params:ParamsDic onCompletion:success];
}


//搜索
+ (void)searchWithTitle:(NSString *)title success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(title, @"park_title");
    
    [self postWithStatusRecordListModelResponsePath:@"park_search" params:ParamsDic onCompletion:success];
}

@end
