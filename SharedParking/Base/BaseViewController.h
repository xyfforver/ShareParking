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

///扫一扫
- (void)openQRCode;

/// 判断登录
- (void)loginVerifySuccess:(void (^)(void))success;

- (void)addNet:(id)net;
- (void)releaseNet;
@end
