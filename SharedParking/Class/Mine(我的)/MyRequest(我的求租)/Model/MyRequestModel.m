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

//更新我的求租信息
+ (void)UpdateMyRequestInfoWithId:(NSString *)helpId address:(NSString *)address range:(NSString *)range price:(NSString *)price success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(helpId, @"help_id");
    DicObjectSet(address, @"help_address");
    DicObjectSet(range, @"help_fanwei");
    DicObjectSet(@"1", @"help_type");
    DicObjectSet(price, @"help_money");
    [self postWithStatusModelResponsePath:@"user_helpupdate" params:ParamsDic onCompletion:success];
}

//发布我的求租信息
+ (void)issueMyRequestInfoWithAddress:(NSString *)address range:(NSString *)range price:(NSString *)price success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(address, @"help_address");
    DicObjectSet(range, @"help_fanwei");
    DicObjectSet(@"1", @"help_type");
    DicObjectSet(price, @"help_money");
    [self postWithStatusModelResponsePath:@"user_helpadd" params:ParamsDic onCompletion:success];
    
}

@end
