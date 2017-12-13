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

//退出登录
+ (void)logoutSuccess:(NetCompletionBlock)success{
    [self postWithStatusModelResponsePath:@"logout" params:nil onCompletion:success];
}

//意见反馈
+ (void)feedbackWithContent:(NSString *)content success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(content, @"feedback_content");
    [self postWithStatusModelResponsePath:@"user_feedback" params:ParamsDic onCompletion:success];
}

//更新个人资料
+ (void)updateUserInfoWithNickname:(NSString *)nickname alipayNum:(NSString *)alipayNum headImg:(NSData *)headImg success:(NetCompletionBlock)success{
    CreateParamsDic;
    DicObjectSet(nickname, @"realname");
    DicObjectSet(alipayNum, @"alipay_account");
    
    DLog(@"\n<<-----------请求--------------------\n%@",ParamsDic);
    
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",LingBao_BASE_URL,@"usermeta_update"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:baseUrl parameters:ParamsDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (headImg) {
            //随机文件名
            NSString *fileName = [HelpTool uuidUniqueFileName];
            //获取文件后缀
            NSString *extension = [HelpTool contentTypeForImageData:headImg];
            NSString *headName = [fileName stringByAppendingPathExtension:extension];
            DLog(@"%@",headName);
            [formData appendPartWithFileData:headImg name:@"headimg" fileName:headName mimeType:extension];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //        DLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves|NSJSONReadingMutableContainers error:nil];
        
        DLog(@"\n<<-----------返回--------------------\n Url == %@\n data == %@\n------------------------------->>",baseUrl,json);
        StatusModel *statusModel = [StatusModel statusModelWithKeyValues:json];
        if (success) {
            success(statusModel);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"error===%@",error);
    }];
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
