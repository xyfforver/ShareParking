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

NSString *const kLoginSuccessNotification = @"LoginSuccessNotification";
NSString *const kLogoutSuccessNotification = @"LogoutSuccessNotification";
NSString *const kUserModelUpdatedNotification = @"UserModelUpdatedNotification";

#define kUserKey @"qiqileSeller"
#define kAutoLogin @"aotuLogin"

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

#pragma mark- 登录成功
- (void)loginSucceedWithModel:(UserModel *)userModel;
{
    self.userModel = userModel;
    self.token = userModel.token;
    self.isLogin = YES;
//    [self configLibraryParams];
    
    NSString *account = GetDataManager.account;

    [[NSUserDefaults standardUserDefaults] setObject:account forKey:kUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAutoLogin];
    
    [self.userModel saveToDB];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
}

#pragma mark- 退出登录
- (void)logOutSuccessBlock:(void (^)(void))success fail:(void(^)(void))fail
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kAutoLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 1 清除相关信息
    GetDataManager.isLogin = NO;
    GetDataManager.id = nil;
    GetDataManager.userModel = nil;
    GetDataManager.token = nil;
    
    //释放数据库资源
    [BaseModel releaseLKDBHelp];
}

#pragma mark- 更新用户信息
- (void)updateUserInfoSuccessBlock:(void (^)(void))success fail:(void (^)(void))fail
{
//    kSelfWeak;
//    [[UserHttpManager sharedUserHttpManager] modifyUserInfo:@{@"token":self.token} block:^(NSDictionary *json_dic, NSError *error) {
//        kSelfStrong;
//        StatusModel *statusModel = [StatusModel statusModelWithKeyValues:json_dic class:[UserModel class] error:error];
//        if (statusModel.flag == kFlagSuccess) {
//            UserModel *uModel = statusModel.data;
//            if (uModel) {
//                // 设置新model token赋值
//                uModel.token = strongSelf.userModel.token;
//                strongSelf.userModel = uModel;
//            }
//            
//            // 调用block
//            if (success) {
//                success();
//            }
//
//        } else {
//            if (fail) {
//                fail();
//            }
//        }
//        
//        // 通知其他页面刷新:不管是否更新成功，都应该发出这个通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:kUserModelUpdatedNotification object:nil];
//    }];
}

#pragma mark- 自动登录
- (void)autoLogin
{
    BOOL autoLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:kAutoLogin] boolValue];
    if (autoLogin) {
        NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:kUserKey];
        
        [UserModel loginWithAccount:account password:nil success:^(StatusModel *statusModel) {
            if (statusModel.flag == kFlagSuccess) {
                UserModel *userModel = statusModel.data;
                self.account = account;
                self.id = userModel.id;
                [self loginSucceedWithModel:userModel];
            } else {
                
            }
        }];
    }
}

@end
