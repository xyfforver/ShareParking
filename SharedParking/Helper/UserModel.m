//
//  UserModel.m
//  LotterySeller
//
//  Created by 徐佳琦 on 17/2/15.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "UserModel.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

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

//加密 md5和base64
+(NSString *)getMd5_32Bit_String:( NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSData * base64 = [GTMBase64 encodeBytes:digest length:16];
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    output=[output stringByReplacingOccurrencesOfString:@"=" withString:@""];
    return output;
}

@end
