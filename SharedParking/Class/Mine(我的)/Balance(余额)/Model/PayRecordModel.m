//
//  PayRecordModel.m
//  yimaxingtianxia
//
//  Created by Galaxy on 2017/10/7.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "PayRecordModel.h"

@implementation PayRecordModel

//获取支付明细列表
+ (void)getPayRecordListWithAddTime:(NSString *)addTime type:(NSInteger)type page:(NSInteger)page success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(@(page), @"page");
    DicObjectSet(@(type), @"type");
    DicObjectSet(addTime, @"addtime");
    [self postWithStatusRecordListModelResponsePath:@"Details/detailsList" params:ParamsDic onCompletion:success];
    
}
@end
