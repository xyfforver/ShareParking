//
//  UIView+UIViewController.m
//  微博
//
//  Created by huiwen on 15/10/16.
//  Copyright (c) 2015年 huiwen. All rights reserved.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)



-(UIViewController *)Controller{

    UIResponder *next = self.nextResponder;
    
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    }

    return nil;
}





@end
