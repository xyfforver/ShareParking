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

- (NSString *)longitude{
    return [NSString stringWithFormat:@"%f",self.geoCodeResult.location.longitude];
}

- (NSString *)latitude{
    return [NSString stringWithFormat:@"%f",self.geoCodeResult.location.latitude];
}

#pragma mark -  用户属性相关
- (UserModel *)userModel{
    if (!_userModel) {
        _userModel = [[UserModel alloc] init];
    }
    
    return _userModel;
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

