//
//  ExtraParaManger.m
//  EasyGo
//
//  Created by Apple on 2016/11/4.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import "ExtraParaManger.h"
#import "KeychainIDFA.h"

@implementation ExtraParaManger

+ (instancetype)shareExtraParaManger {
    static ExtraParaManger *shareExtraParaManger;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareExtraParaManger = [[ExtraParaManger alloc] init];
        assert(shareExtraParaManger != nil);
    });
    
    return shareExtraParaManger;
}

- (NSString *)appversion {
    if (_appversion==nil) {
        _appversion = GetAppBundleVersion;
    }
    return _appversion;
}

- (NSString *)osversion {
    if (_osversion==nil) {
        _osversion = [NSString stringWithFormat:@"%.1f",kSystermVersion];
    }
    return _osversion;
}

- (NSString *)clientId {
    if (_clientId==nil) {
        _clientId = GetKeychainIDFA.deviceId;
    }
    return _clientId;
}


//[mutableParams setValue:GetAppBundleVersion forKey:@"appversion"];
//[mutableParams setValue:[NSString stringWithFormat:@"%.1f",kSystermVersion] forKey:@"osversion"];
//[mutableParams setValue:[HelpTool deviceVersion] forKey:@"machinemodel"];

//[mutableParams setValue:GetKeychainIDFA.deviceId forKey:@"clientId"];

@end
