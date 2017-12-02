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

@property (copy, nonatomic) NSString *userid;//商户端用ID
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *cname;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *tel;
@property (copy, nonatomic) NSString *thindType;
@property (copy, nonatomic) NSString *openId;
@property (assign, nonatomic) BOOL isbinding;

#pragma mark - 定位位置信息
@property (nonatomic , copy) NSString *longitude;
@property (nonatomic , copy) NSString *latitude;
@property (strong, nonatomic) BMKReverseGeoCodeResult *geoCodeResult;
@property (copy, nonatomic) NSString *selectCity;
@property (copy, nonatomic) NSString *selectArea;

#pragma mark - 预订时间人数
@property (nonatomic , copy) NSDate *date;
@property (nonatomic , copy) NSString *dateStr;
@property (nonatomic , copy) NSString *weekStr;
@property (nonatomic , copy) NSString *timeStr;
@property (nonatomic , assign) NSInteger peopleNum;
#pragma mark -

+ (DataManager *)sharedManager;

- (void)loginSucceedWithModel:(UserModel *)userModel;


// 自动登录
- (void)autoLogin;

- (void)logOutSuccessBlock:(void (^)(void))success fail:(void(^)(void))fail;
@end

