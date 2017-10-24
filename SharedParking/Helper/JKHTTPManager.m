//
//  JKHTTPManager.m
//  letou
//
//  Created by 徐佳琦 on 17/1/6.
//  Copyright © 2017年 letou. All rights reserved.
//

#import "JKHTTPManager.h"

@implementation JKHTTPManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 创建NSMutableSet对象
        NSMutableSet *newSet = [NSMutableSet set];
        // 添加我们需要的类型
        newSet.set = self.responseSerializer.acceptableContentTypes;
        [newSet addObjectsFromArray:@[@"application/json", @"text/json", @"text/javascript", @"text/html"]];
        
        // 重写给 acceptableContentTypes赋值
        self.responseSerializer.acceptableContentTypes = newSet;
    }
    return self;
}

+ (instancetype)manager {
    JKHTTPManager *mgr = [super manager];
    // 创建NSMutableSet对象
    NSMutableSet *newSet = [NSMutableSet set];
    // 添加我们需要的类型
    newSet.set = mgr.responseSerializer.acceptableContentTypes;
    [newSet addObjectsFromArray:@[@"application/json", @"text/json", @"text/javascript", @"text/html"]];
    
    // 重写给 acceptableContentTypes赋值
    mgr.responseSerializer.acceptableContentTypes = newSet;
    
    return mgr;
}
@end
