//
//  DataManager.m
//  YueDian
//
//  Created by xiao on 15/3/6.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import "DataManager.h"
#import "UserModel.h"
#import "StatusModel.h"
//#import "FXKeychain.h"

NSString *const kLoginSuccessNotification = @"LoginSuccessNotification";
NSString *const kLogoutSuccessNotification = @"LogoutSuccessNotification";
NSString *const kUserModelUpdatedNotification = @"UserModelUpdatedNotification";

#define kUserKey @"yimaxingtianxia"
#define kUserIdKey @"yimaxingtianxiaUserId"



@implementation DataManager

+ (DataManager *)sharedManager
{
    static DataManager *sharedManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[DataManager alloc] init];
        assert(sharedManager != nil);
    });
    
    return sharedManager;
}
#pragma mark -  用户属性相关
- (UserModel *)userModel{
    if (!_userModel) {
        _userModel = [[UserModel alloc] init];
    }
    
    return _userModel;
}

- (NSString *)userid
{
    return [NSString isNull:self.userModel.userid]?nil:self.userModel.userid;
}

- (NSString *)cname
{
    return [NSString isNull:self.userModel.cname]?@"":self.userModel.cname;
}

- (NSString *)sex
{
    return [NSString isNull:self.userModel.sex]?@"":self.userModel.sex;
}

- (NSString *)token
{
    return [NSString isNull:self.userModel.token]?nil:self.userModel.token;
}

- (NSString *)icon
{
    return [NSString isNull:self.userModel.icon]?@"":self.userModel.icon;
}

- (NSString *)tel
{
    return [NSString isNull:self.userModel.tel]?@"":self.userModel.tel;
}

- (NSString *)thindType
{
    return [NSString isNull:self.userModel.thindType]?@"":self.userModel.thindType;
}

- (NSString *)openId
{
    return [NSString isNull:self.userModel.openId]?@"":self.userModel.openId;
}

- (BOOL)isbinding
{
    return self.userModel.isbinding ? self.userModel.isbinding:NO;
}

- (NSString *)longitude{
    return [NSString stringWithFormat:@"%f",self.geoCodeResult.location.longitude];
}

- (NSString *)latitude{
    return [NSString stringWithFormat:@"%f",self.geoCodeResult.location.latitude];
}

#pragma mark- 登录成功
- (void)loginSucceedWithModel:(UserModel *)userModel;
{
    self.userModel = userModel;
    self.token = userModel.token;
    self.cname = userModel.cname;
    self.icon = userModel.icon;
    self.tel = userModel.tel;
    self.isLogin = YES;
    //    [self configLibraryParams];
    
    [[NSUserDefaults standardUserDefaults] setObject:GetDataManager.tel forKey:kLingBaoUser];
    [[NSUserDefaults standardUserDefaults] setObject:GetDataManager.userid forKey:kUserIdKey];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAutoLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.userModel saveToDB];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
}

#pragma mark- 退出登录
- (void)logOutSuccessBlock:(void (^)(void))success fail:(void(^)(void))fail
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAutoLogin];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kUserIdKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    [UserModel bindRegistrationID:@"" success:^(StatusModel *statusModel) {
//
//    }];
    
    // 1 清除相关信息
    GetDataManager.isLogin = NO;
    GetDataManager.userid = nil;
    GetDataManager.userModel = nil;
    GetDataManager.token = nil;
    GetDataManager.cname = nil;
    GetDataManager.icon = nil;
    GetDataManager.tel = nil;
    
    //释放数据库资源
    [BaseModel releaseLKDBHelp];
    
    // 调用block
    if (success) {
        success();
    }
    
    // 3 消息通知退出登录
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:nil];
}

#pragma mark- 自动登录
- (void)autoLogin{
    BOOL autoLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:kAutoLogin] boolValue];
    
    if (autoLogin) {
        self.isLogin = YES;
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
    }
}

@end

