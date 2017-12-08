//
//  MyRequestModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/8.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyRequestModel.h"

@implementation MyRequestModel


//我的求租信息
+ (void)myRequestInfoWithId:(NSString *)requestId success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(requestId, @"help_id");
    [self postWithStatusModelResponsePath:@"user_helpedit" params:ParamsDic onCompletion:success];
}

//删除我的发布
+ (void)deleteMyRequestWithId:(NSString *)requestId success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(requestId, @"help_id");
    [self postWithStatusModelResponsePath:@"user_helpdel" params:ParamsDic onCompletion:success];
}
@end
