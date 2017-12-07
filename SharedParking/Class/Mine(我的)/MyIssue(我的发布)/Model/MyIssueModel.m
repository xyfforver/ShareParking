//
//  MyIssueModel.m
//  SharedParking
//
//  Created by galaxy on 2017/12/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyIssueModel.h"

@implementation MyIssueModel


//我的发布
+ (void)myIssueWithPage:(NSInteger )page success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(@(page), @"page");
    [self postWithStatusModelResponsePath:@"user_parking" params:ParamsDic onCompletion:success];
}

@end
