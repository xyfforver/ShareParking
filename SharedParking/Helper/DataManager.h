//
//  DataManager.h
//  YueDian
//
//  Created by xiao on 15/3/6.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import "BaseModel.h"
@class UserModel;

FOUNDATION_EXPORT NSString *const kLoginSuccessNotification;
FOUNDATION_EXPORT NSString *const kLogoutSuccessNotification;
FOUNDATION_EXPORT NSString *const kUserModelUpdatedNotification;
FOUNDATION_EXPORT NSString *const kUserModelBalanceChangedNotification;

@interface DataManager : BaseModel

// 登录所用的账号
@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, assign) BOOL isLogin;

#pragma mark -  用户属性相关
@property (copy, nonatomic) NSString *account;
@property (copy, nonatomic) NSString *password;

@property (copy, nonatomic) NSString *id;//商户端用ID
@property (copy, nonatomic) NSString *mobilephone;
@property (copy, nonatomic) NSString *token;
#pragma mark -

+ (DataManager *)sharedManager;

- (void)loginSucceedWithModel:(UserModel *)userModel;


// 自动登录
- (void)autoLogin;

- (void)updateUserInfoSuccessBlock:(void (^)(void))success fail:(void (^)(void))fail;

- (void)logOutSuccessBlock:(void (^)(void))success fail:(void(^)(void))fail;
@end
