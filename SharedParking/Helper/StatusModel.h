//
//  StatusModel.h
//  EasyGo
//
//  Created by Jammy on 16/5/11.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import "BaseModel.h"

/// 加载成功
extern NSInteger  const kFlagSuccess;

/// 加载失败
extern NSInteger  const kFlagFailure;

//网络超时
extern NSInteger  const kFlagNetTimeOutFlag;

//网络异常
extern NSInteger  const kFlagNetDisconnectFlag;

//评论重复
extern NSInteger  const kFlagCommentRepeatFlag;

/// 第一页
extern NSInteger  const kPageFirst;

/// 分页大小（即每页数量）
extern NSInteger  const kPageSize;

/// NSMutableDictionary，用于设置网络请求参数
#define CreateParamsDic NSMutableDictionary *ParamsDic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key) {if (obj) {[ParamsDic setObject:obj forKey:key];}}
#define DicValueSet(value,key) {if (value) {[ParamsDic setObject:value forKey:key];}}

// 假数据
#define FalseData(jsonString) success([self statusModelFromJSONObject:[NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil]])


@interface StatusModel : BaseModel

@property (assign, nonatomic, readonly) NSInteger flag;

/// 状态码，成功或失败
@property (nonatomic, copy) NSString *code;
/// 状态信息，提示语
@property (nonatomic, copy) NSString *message;

//@property (copy, nonatomic) NSString *sysDateTime;

/// 结果 对应的Model
@property (nonatomic, strong) id data;

//createTime : 查询时间（每次查询改变）
//creationTime : 表插入时间（固定时间）
@end

