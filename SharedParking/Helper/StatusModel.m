//
//  StatusModel.m
//  EasyGo
//
//  Created by Jammy on 16/5/11.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import "StatusModel.h"

/// 加载成功
NSInteger const kFlagSuccess = 200;

/// 加载失败
NSInteger const kFlagFailure = 401;

//网络超时
NSInteger const kFlagNetTimeOutFlag = -250;

//网络异常
NSInteger const kFlagNetDisconnectFlag = -404;

//评论重复
NSInteger const kFlagCommentRepeatFlag = 40040001;

/// 第一页
NSInteger const  kPageFirst = 1;

/// 分页大小（即每页数量）
NSInteger const  kPageSize = 10;

@implementation StatusModel
- (NSInteger)flag
{
    NSInteger flag = kFlagFailure;
    if ([self.code isEqualToString:@"200"] || [self.code isEqualToString:@"查询成功"]) {
        flag = kFlagSuccess;
    } else {
        flag = [self.code integerValue];
    }
    return flag;
}

@end

