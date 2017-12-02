//
//  UserModel.m
//  LotterySeller
//
//  Created by 徐佳琦 on 17/2/15.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "UserModel.h"
#import <CommonCrypto/CommonDigest.h>


@implementation UserModel

//+ (LKDBHelper *)getUsingLKDBHelper
//{
//    return [super getDefaultLKDBHelper];
//}
//
//+ (NSString *)getPrimaryKey
//{
//    return @"id";
//}
//登录
+ (void)loginWithPhoneNum:(NSString *)phoneNum codeNum:(NSString *)codeNum success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(phoneNum, @"user_mobile");
    DicObjectSet(codeNum, @"yzm");
    [self postWithStatusModelResponsePath:@"login" params:ParamsDic onCompletion:success];
}

//获取验证码
+ (void)getCodeWithPhoneNum:(NSString *)phoneNum success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(phoneNum, @"user_mobile");
    [self postWithJSONResponsePath:@"sendsms_login" params:ParamsDic onCompletion:^(NSDictionary *jsonDic) {
        StatusModel *statusModel = [StatusModel statusModelWithKeyValues:jsonDic];
        if (success) {
            success(statusModel);
        }
    }];
}

//个人中心
+ (void)getMineDataSuccess:(NetCompletionBlock)success{
    [self postWithStatusModelResponsePath:@"usermeta" params:nil onCompletion:success];
}


+ (void)loginWithAccount:(NSString *)account password:(NSString *)password success:(NetCompletionBlock)success
{
    CreateParamsDic;
    DicObjectSet(account, @"mobilephone");
    DicObjectSet(password, @"password");
    [self postWithStatusModelResponsePath:@"partnerLogin/partnerlogin.do" params:ParamsDic onCompletion:success];
}

+ (void)userLogoutWithSuccess:(NetCompletionBlock)success{
    CreateParamsDic;
    [self postWithJSONResponsePath:@"login/userlogout.do" params:ParamsDic onCompletion:^(NSDictionary *jsonDic) {
        StatusModel *statusModel = [StatusModel statusModelWithKeyValues:jsonDic];
        
        if (success) {
            success(statusModel);
        }
        
    }];
}


+ (void)bindAlipay:(NSString *)alipay success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(alipay, @"bankaccountno");
    
    [self postWithJSONResponsePath:@"account/addapily.do" params:ParamsDic onCompletion:^(NSDictionary *jsonDic) {
        StatusModel *statusModel = [StatusModel statusModelWithKeyValues:jsonDic];
        
        if (success) {
            success(statusModel);
        }
    }];
}


@end
