//
//  UIViewController+Dealloc.m
//  EasyGo
//
//  Created by 徐佳琦 on 16/4/19.
//  Copyright © 2016年 Ju. All rights reserved.
//

#import "UIViewController+Dealloc.h"

#import <objc/runtime.h>

@implementation UIViewController (dealloc)

#pragma mark - 当类第一次加载到内存的时候会调用这个方法，它要比main.m方法先执行

+(void)load{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    
    Method method2 = class_getInstanceMethod([self class], @selector(lca_dealloc));
    
    method_exchangeImplementations(method1, method2);
    
}

#pragma mark - 自定义的dealloc方法

- (void)lca_dealloc{
    
    DLog(@"---------------%@已被销毁！！！---------------", NSStringFromClass(self.class));
    
    //执行系统的dealloc方法，不会发生死循环，因为它会执行系统的dealloc方法
    
    //我们可能会在系统的dealloc方法中执行一些释放操作，所以在自定义的dealloc方法中也要执行系统的
    
    [self lca_dealloc];
    
}

@end
