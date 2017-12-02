//
//  UserModel.h
//  LotterySeller
//
//  Created by 徐佳琦 on 17/2/15.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *userid;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *cname;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *tel;
@property (copy, nonatomic) NSString *thindType;
@property (copy, nonatomic) NSString *openId;
@property (copy, nonatomic) NSString *client;//注册人数
@property (assign, nonatomic) BOOL old;//0 刚注册 1 老用户

@property (assign, nonatomic) BOOL isbinding;

//登录
+ (void)loginWithPhoneNum:(NSString *)phoneNum codeNum:(NSString *)codeNum success:(NetCompletionBlock)success;
//获取验证码
+ (void)getCodeWithPhoneNum:(NSString *)phoneNum success:(NetCompletionBlock)success;
//个人中心
+ (void)getMineDataSuccess:(NetCompletionBlock)success;
//退出登录
+ (void)logoutSuccess:(NetCompletionBlock)success;

+ (void)loginWithAccount:(NSString *)account password:(NSString *)password success:(NetCompletionBlock)success;
+ (void)userLogoutWithSuccess:(NetCompletionBlock)success;

+ (void)bindAlipay:(NSString *)alipay success:(NetCompletionBlock)success;


@end
