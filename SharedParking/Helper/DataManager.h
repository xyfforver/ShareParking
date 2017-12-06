//
//  DataManager.h
//  YueDian
//
//  Created by xiao on 15/3/6.
//  Copyright (c) 2015年 xiao. All rights reserved.
//

#import "BaseModel.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
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


#pragma mark - 定位位置信息
@property (nonatomic , copy) NSString *longitude;
@property (nonatomic , copy) NSString *latitude;
@property (strong, nonatomic) BMKReverseGeoCodeResult *geoCodeResult;
@property (copy, nonatomic) NSString *selectCity;


#pragma mark -

+ (DataManager *)sharedManager;


// 自动登录
- (void)autoLogin;


@end

