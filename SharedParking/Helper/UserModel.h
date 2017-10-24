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

@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *headImgUrl;
@property (copy, nonatomic) NSString *banlance;
@property (copy, nonatomic) NSString *mobilephone;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *realName;
@property (copy, nonatomic) NSString *unReadMsgCount;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *email;

+ (void)loginWithAccount:(NSString *)account password:(NSString *)password success:(NetCompletionBlock)success;
+ (void)userLogoutWithSuccess:(NetCompletionBlock)success;

+ (void)bindAlipay:(NSString *)alipay success:(NetCompletionBlock)success;


@end
