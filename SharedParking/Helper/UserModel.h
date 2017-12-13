//
//  UserModel.h
//  LotterySeller
//
//  Created by 徐佳琦 on 17/2/15.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel
@property (copy, nonatomic) NSString *headimg;
@property (copy, nonatomic) NSString *user_mobile;
@property (copy, nonatomic) NSString *car_chepai;
@property (copy, nonatomic) NSString *realname;
@property (assign, nonatomic) CGFloat user_money;
@property (copy, nonatomic) NSString *alipay_account;


@property (copy, nonatomic) NSString *tel;
@property (copy, nonatomic) NSString *thindType;
@property (copy, nonatomic) NSString *openId;
@property (copy, nonatomic) NSString *client;//注册人数
@property (assign, nonatomic) BOOL old;//0 刚注册 1 老用户

@property (assign, nonatomic) BOOL ischepai;

//登录
+ (void)loginWithPhoneNum:(NSString *)phoneNum codeNum:(NSString *)codeNum success:(NetCompletionBlock)success;
//获取验证码
+ (void)getCodeWithPhoneNum:(NSString *)phoneNum success:(NetCompletionBlock)success;
//个人中心
+ (void)getMineDataSuccess:(NetCompletionBlock)success;
//退出登录
+ (void)logoutSuccess:(NetCompletionBlock)success;
//意见反馈
+ (void)feedbackWithContent:(NSString *)content success:(NetCompletionBlock)success;
//更新个人资料
+ (void)updateUserInfoWithNickname:(NSString *)nickname alipayNum:(NSString *)alipayNum headImg:(NSData *)headImg success:(NetCompletionBlock)success;
//修改手机号
+ (void)changeTelWithPhoneNum:(NSString *)phoneNum codeNum:(NSString *)codeNum success:(NetCompletionBlock)success;


+ (void)loginWithAccount:(NSString *)account password:(NSString *)password success:(NetCompletionBlock)success;
+ (void)userLogoutWithSuccess:(NetCompletionBlock)success;

+ (void)bindAlipay:(NSString *)alipay success:(NetCompletionBlock)success;


@end
