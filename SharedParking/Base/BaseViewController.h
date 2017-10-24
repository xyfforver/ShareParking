//
//  BaseViewController.h
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/18.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/// 设置导航栏样式
//+ (void)setNavigationStyle:(UINavigationController *)nav;

/// 设置导航栏左按钮;
//- (UIBarButtonItem *)barBackButton;

//+ (UIBarButtonItem *)leftBarButtonWithName:(NSString *)name
//                                 imageName:(NSString *)imageName
//                                    target:(id)target
//                                    action:(SEL)action;
/// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                     action:(SEL)action;
- (void)initNavBackButton;


/// 返回上层视图方法
- (void)backToSuperView;

/// 点击空白处键盘收回
//- (void)textFieldReturn;

#pragma mark - 网络

/// 开始加载
//-(void)loadingDataStart;

/// 加载成功
//-(void)loadingDataSuccess;

/// 加载失败
//-(void)loadingDataFail;

/// 没有内容
//-(void)loadingDataBlank;

/// 刷新代理方法
//-(void)reflashClick;

/// 判断登录
- (void)loginVerifySuccess:(void (^)())success;

- (void)addNet:(id)net;
- (void)releaseNet;
@end
