//
//  AppDelegate+LibConfig.m
//  SharedParking
//
//  Created by galaxy on 2017/10/24.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "AppDelegate+LibConfig.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@implementation AppDelegate (LibConfig)
- (void)setupLibConfigWithOptions:(NSDictionary *)launchOptions{
    
    [self configIQKeyboardManager];//键盘
    
    [self createBaiduMap];

}

#pragma mark - Keyboard
- (void)configIQKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

#pragma mark ---------------百度地图 ---------------------/
- (void)createBaiduMap{
    //百度地图授权
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:BMKMapAK generalDelegate:nil];
    if (!ret) {
        DLog(@"BMKMapManager start fail");
    }
    
    [BMKMapManager logEnable:NO module:BMKMapModuleTile];
}


@end
