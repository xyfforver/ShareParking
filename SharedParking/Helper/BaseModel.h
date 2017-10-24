//
//  BaseModel.h
//  EasyGo
//
//  Created by 徐佳琦 on 16/5/11.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDBHelper.h"

@class StatusModel;

typedef void (^NetCompletionBlock)(StatusModel *statusModel);

@interface BaseModel : NSObject

#pragma mark - DB

/// 登录帐号的数据库
+ (LKDBHelper *)getUserLKDBHelper;

/// 释放用户LKDB
+ (void)releaseLKDBHelp;

/// 默认的数据库 子类可以重写，默认已经登录用登录帐号数据库，没有则默认数据库
+ (LKDBHelper *)getUsingLKDBHelper;

/// 跟用户无关的数据库
+ (LKDBHelper *)getDefaultLKDBHelper;

/**
 *  @brief JSON映射模型,无data
 *
 *  @param keyValues JSON
 *  @param error     网络请求返回的error，根据此error判断超时或网络异常
 *
 *  @return Status对象
 */

+ (instancetype)statusModelWithKeyValues:(id)keyValues;

/**
 *  @brief JSON映射模型,data层对应着模型数组
 *
 *  @param keyValues JSON
 *  @param aclass    data数组中对应的Model Class
 *  @param error     网络请求返回的error，根据此error判断超时或网络异常
 *
 *  @return Status对象
 */
+ (instancetype)statusModelWithKeyValues:(id)keyValues class:(Class)aclass;

/**
 *  @brief JSON映射模型,当为列表时使用，data层对应totalCount,RecordList等。
 *
 *  @param keyValues       JSON
 *  @param recordListClass RecordList对应的Model Class
 *  @param error           网络请求返回的error，根据此error判断超时或网络异常
 *
 *  @return Status对象
 */
+ (instancetype)statusModelRecorListWithKeyValues:(id)keyValues recordListClass:(Class)recordListClass;

/**
 POST请求，回调返回转换好的模型

 @param path 接口路径
 @param params 参数
 @param completionBlock 转换好的模型
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)postWithStatusModelResponsePath:(NSString *)path
                                        params:(NSMutableDictionary *)params
                                  onCompletion:(NetCompletionBlock)completionBlock;

/**
 POST请求，回调返回转换好的模型
 
 @param path 接口路径
 @param params 参数
 @param completionBlock 转换好的模型
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)postWithStatusRecordListModelResponsePath:(NSString *)path
                                                             params:(NSMutableDictionary *)params
                                                       onCompletion:(NetCompletionBlock)completionBlock;

/**
 POST请求，回调返回JSON字典

 @param path 接口路径
 @param params 参数
 @param completionBlock JSON字典
 @return NSURLSessionDataTask
 */
+ (NSURLSessionDataTask *)postWithJSONResponsePath:(NSString *)path
                                        params:(NSMutableDictionary *)params
                                  onCompletion:(void (^)(NSDictionary *jsonDic))completionBlock;


/**
 <#Description#>

 @param host 域名
 @param path 接口路径
 @param params 参数
 @param completionBlock <#completionBlock description#>
 @return <#return value description#>
 */
+ (NSURLSessionDataTask *)postWithJSONResponseHost:(NSString *)host
                                          Path:(NSString *)path
                                        params:(NSMutableDictionary *)params
                                  onCompletion:(void (^)(NSDictionary *jsonDic))completionBlock;
@end
