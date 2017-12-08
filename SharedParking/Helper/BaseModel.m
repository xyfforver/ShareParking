//
//  BaseModel.m
//  EasyGo
//
//  Created by Jammy on 16/5/11.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import "BaseModel.h"
#import "StatusModel.h"
#import "JKHTTPManager.h"
#import "ExtraParaManger.h"
static NSString *const DBName = @"YiMaTong";

@implementation BaseModel

#pragma mark - DB
static LKDBHelper* userHelper;
static dispatch_once_t userOnceToken;
//+ (LKDBHelper *)getUserLKDBHelper
//{
//    NSString *dbName = GetDataManager.userid;
//    dispatch_once(&userOnceToken, ^{
//        userHelper = [[LKDBHelper alloc] initWithDBName:dbName];
//    });
//    [userHelper setDBName:dbName];
//    return userHelper;
//}
//
//+ (void)releaseLKDBHelp
//{
//    userOnceToken = 0;
//    userHelper = nil;
//}
//
//
//+ (LKDBHelper *)getUsingLKDBHelper
//{
//    LKDBHelper *helper;
//    if (GetDataManager.userid.length != 0)
//    {
//        helper = [self getUserLKDBHelper];
//    }
//    else
//    {
//        helper = [self getDefaultLKDBHelper];
//    }
//    return helper;
//}
//
//+(LKDBHelper *)getDefaultLKDBHelper
//{
//    static LKDBHelper* helper;
//    static dispatch_once_t onceToken;
//    NSString *dbName = @"JT_default";
//    dispatch_once(&onceToken, ^{
//        helper = [[LKDBHelper alloc]initWithDBName:dbName];
//    });
//    [helper setDBName:[NSString stringWithFormat:@"%@.db",dbName]];
//    return helper;
//}


#pragma mark - map

+ (instancetype)statusModelRecorListWithKeyValues:(id)keyValues recordListClass:(Class)recordListClass
{

    [StatusModel mj_setupNewValueFromOldValue:^id(id object, id oldValue, MJProperty *property) {
        if ([property.name isEqualToString:@"data"]) {
            if ([oldValue isKindOfClass:[NSArray class]]){
                return [recordListClass mj_objectArrayWithKeyValuesArray:oldValue];
            }
        }
        return oldValue;
    }];
    
    return [self statusModelWithKeyValues:keyValues];
}

+ (instancetype)statusModelWithKeyValues:(id)keyValues class:(Class)aclass
{
    [StatusModel mj_setupNewValueFromOldValue:^id(id object, id oldValue, MJProperty *property) {
        if ([property.name isEqualToString:@"data"]) {
            if ([oldValue isKindOfClass:[NSDictionary class]]) {
                return [aclass mj_objectWithKeyValues:oldValue];
            } else if ([oldValue isKindOfClass:[NSArray class]]){
                return [aclass mj_objectArrayWithKeyValuesArray:oldValue];
            } else if ([oldValue isKindOfClass:[NSString class]]) {
                return oldValue;
            }
        }
        return oldValue;
    }];
    
    return [self statusModelWithKeyValues:keyValues];
}

//+ (instancetype)statusModelWithResponseJson:(id)Json
//{
//    return [StatusModel mj_objectWithKeyValues:Json];
//}

+ (instancetype)statusModelWithKeyValues:(id)keyValues{
    return [StatusModel mj_objectWithKeyValues:keyValues];
}
#pragma mark - 网络请求
+ (NSURLSessionDataTask *)postWithStatusModelResponsePath:(NSString *)path
                                                   params:(NSMutableDictionary *)params
                                             onCompletion:(NetCompletionBlock)completionBlock
{
    return [self postWithJSONResponsePath:path params:params onCompletion:^(NSDictionary *jsonDic) {
        StatusModel *statusModel = [StatusModel statusModelWithKeyValues:jsonDic class:[self class]];
        if (completionBlock) {
            completionBlock(statusModel);
        }
    }];
}

+ (NSURLSessionDataTask *)postWithStatusRecordListModelResponsePath:(NSString *)path
                                                             params:(NSMutableDictionary *)params
                                                       onCompletion:(NetCompletionBlock)completionBlock
{
    return [self postWithJSONResponsePath:path params:params onCompletion:^(NSDictionary *jsonDic) {
        StatusModel *statusModel = [StatusModel statusModelRecorListWithKeyValues:jsonDic recordListClass:[self class]];
        if (completionBlock) {
            completionBlock(statusModel);
        }
    }];
}

+ (NSURLSessionDataTask *)postWithJSONResponsePath:(NSString *)path
                                            params:(NSMutableDictionary *)params
                                      onCompletion:(void (^)(NSDictionary *jsonDic))completionBlock
{
    return [self postWithJSONResponseHost:LingBao_BASE_URL Path:path params:params onCompletion:completionBlock];
}

+ (NSURLSessionDataTask *)postWithJSONResponseHost:(NSString *)host
                                              Path:(NSString *)path
                                            params:(NSMutableDictionary *)params
                                      onCompletion:(void (^)(NSDictionary *jsonDic))completionBlock
{
    JKHTTPManager *manager = [[JKHTTPManager alloc] initWithBaseURL:[NSURL URLWithString:host]];
    
    NSDictionary *mutableParams = [NSMutableDictionary dictionaryWithDictionary:params];
    //    [mutableParams setValue:@"1" forKey:@"platformtype"];
    //    [mutableParams setValue:GetExtraParaManger.appversion forKey:@"appversion"];
    //    [mutableParams setValue:GetDataManager.userid forKey:@"userid"];
    //    [mutableParams setValue:GetDataManager.token forKey:@"token"];
    //    [mutableParams setValue:GetExtraParaManger.clientId forKey:@"clientId"];

    //    [mutableParams setValue:GetExtraParaManger.osversion forKey:@"osversion"];
    //    [mutableParams setValue:GetExtraParaManger.machinemodel forKey:@"machinemodel"];
    DLog(@"\n<<-----------请求-------------------\n Url == %@%@\n Params == %@\n DicStyle == %@\n------------------------------->>", host, path, [mutableParams jsonEncodedKeyValueString], mutableParams);
    
    NSURLSessionDataTask *task = [manager POST:path
                                    parameters:mutableParams
                                      progress:^(NSProgress * _Nonnull uploadProgress) {
                                          
                                      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                          
                                          DLog(@"\n<<-----------返回--------------------\n Url == %@%@\n Res == %@\n DicStyle == %@\n------------------------------->>", host, path, [responseObject jsonEncodedKeyValueString], responseObject);
                                          
                                          if (completionBlock)
                                          {
                                              completionBlock(responseObject);
                                          }
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          NSDictionary *dic = [self getErrorDictionary:error];
                                          DLog(@"%@", error);
                                          [BaseModel textDemo];
                                          if (completionBlock)
                                          {
                                              completionBlock(dic);
                                          }
                                      }];
    return task;
}


+ (NSDictionary *)getErrorDictionary:(NSError *)error
{
    //判断超时的情况
    BOOL isTimeout = [[error.userInfo objectForKey:@"NSLocalizedDescription"] rangeOfString:@"超时"].location != NSNotFound;
    if (isTimeout) {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithInteger:kFlagNetTimeOutFlag], @"code",
                @"网络异常，请检查网络",@"message",
                nil];
    } else {
        return [NSDictionary dictionaryWithObjectsAndKeys:
                [NSNumber numberWithInteger:kFlagNetDisconnectFlag], @"code",
                @"网络异常，请检查网络",@"message",
                nil];
    }
}

+ (void)textDemo{
    NSURL *url = [NSURL URLWithString:@"http://park.1mxtx.com/index/app/park_xq"];
    //2.构建http请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    [request setHTTPMethod:@"POST"];
    //设置请求的超时时间
    [request setTimeoutInterval:60];
    
    
    NSHTTPURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:nil];
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
@end

