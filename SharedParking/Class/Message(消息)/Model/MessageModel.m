//
//  MessageModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/8.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel



//我的消息
+ (void)myMessageWithPage:(NSInteger )page success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(@(page), @"page");
    [self postWithStatusModelResponsePath:@"user_message" params:ParamsDic onCompletion:success];
}

//系统消息
+ (void)systemMessageWithPage:(NSInteger )page success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(@(page), @"page");
    [self postWithStatusModelResponsePath:@"system_message" params:ParamsDic onCompletion:success];
}

@end
