//
//  AppDelegate.m
//  SharedParking
//
//  Created by galaxy on 2017/10/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+LibConfig.h"
#import "LoginReminderVC.h"

#import "GBWXPayManager.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#define WECHAT_APPID @"wx7311892fb056d1a3"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [GetDataManager autoLogin];//自动登录
    
    [HelpTool openLocation];
    
    LoginReminderVC *vc = [[LoginReminderVC alloc]init];
    self.window.rootViewController = vc;
    
    [self.window makeKeyAndVisible];
    
    if (IOS11){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    [self setupLibConfigWithOptions:launchOptions];
    
    [WXApi registerApp:WECHAT_APPID];//微信支付
    
    return YES;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //1.收到支付宝支付结果回调
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了,所以 pay 接 口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就是在这个方法 里面处理跟 callback 一样的逻辑】
            if (resultDic){
                NSString *resultStatus=[resultDic objectForKey:@"resultStatus"];
                if([resultStatus isEqualToString:@"9000"]){
                    [[NSNotificationCenter defaultCenter] postNotificationName:kZhifubaoPaysuccessNoti object:@"1"];
                }else{
                    //[WSProgressHUD showImage:nil status:[NSString stringWithFormat:@"%@", [resultDic objectForKey:@"memo"]]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kZhifubaoPaysuccessNoti object:@"1"];
                }
            }
        }];
        
        return YES;
    } else if ([url.host isEqualToString:@"platformapi"]){//2.支付宝快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if (resultDic){
                NSString *resultStatus=[resultDic objectForKey:@"resultStatus"];
                if([resultStatus isEqualToString:@"9000"]){
                    [[NSNotificationCenter defaultCenter] postNotificationName:kZhifubaoPaysuccessNoti object:@"1"];
                }
            }
        }];
        return YES;
    }
    else {//有盟三方登录
//        BOOL result = [self UMSocialHandleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
//        if (result == FALSE) {
            return  [WXApi handleOpenURL:url delegate:[GBWXPayManager sharedManager]];
//        }
//        return result;
    }
    return YES;
}
#pragma mark ---------------WXApi ---------------------/
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:[GBWXPayManager sharedManager]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
