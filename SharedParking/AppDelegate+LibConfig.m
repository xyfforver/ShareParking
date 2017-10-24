//
//  AppDelegate+LibConfig.m
//  SharedParking
//
//  Created by galaxy on 2017/10/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "AppDelegate+LibConfig.h"

@implementation AppDelegate (LibConfig)
- (void)setupLibConfigWithOptions:(NSDictionary *)launchOptions{
    
    [self configIQKeyboardManager];//键盘

}

#pragma mark - Keyboard
- (void)configIQKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

@end
