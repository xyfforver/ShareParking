//
//  ReleaseModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/11.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ReleaseModel.h"

@implementation ReleaseModel
//错时车位发布
+ (void)releaseShortWithParkId:(NSString *)parkId parkNum:(NSString *)parkNum carType:(NSInteger)carType object:(NSInteger)object remark:(NSString *)remark carImg:(NSString *)carImg carportImg:(NSString *)carport success:(NetCompletionBlock)success{
    
}

//停车场列表
+ (void)releaseShortWithSearchStr:(NSString *)searchStr page:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    [ParamsDic setObject:@(page) forKey:@"page"];
    [ParamsDic setObject:searchStr forKey:@"park_title"];
    [self postWithStatusRecordListModelResponsePath:@"select_park" params:ParamsDic onCompletion:success];
}
@end
