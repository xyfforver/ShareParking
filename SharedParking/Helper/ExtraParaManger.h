//
//  ExtraParaManger.h
//  EasyGo
//
//  Created by Apple on 2016/11/4.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GetExtraParaManger [ExtraParaManger shareExtraParaManger]

@interface ExtraParaManger : NSObject

@property (nonatomic, copy)NSString *appversion;
@property (nonatomic, copy)NSString *osversion;
@property (nonatomic, copy)NSString *clientId;

+ (instancetype)shareExtraParaManger;

@end
