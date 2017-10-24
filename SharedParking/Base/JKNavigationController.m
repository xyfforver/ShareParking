//
//  JKNavigationController.m
//  EasyGo
//
//  Created by 徐佳琦 on 16/9/20.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import "JKNavigationController.h"
//#import "DebugVC.h"

@interface JKNavigationController ()

@end

@implementation JKNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event
//{
//    BOOL debugMode = [self debugMode];
//    BOOL isAdmin = [[DataManager sharedManager].userName isEqualToString:@"13023760432"];
//    
//    if (debugMode || isAdmin) {
//        UIViewController *vc = [UIViewController currentViewController];
//        if (![vc isKindOfClass:[DebugVC class]]) {
//            DebugVC *debugVC = [[DebugVC alloc] init];
//            [vc.navigationController pushViewController:debugVC animated:YES];
//        }
//    }
//}
//
//-(BOOL)shouldAutorotate{
//    return self.topViewController.shouldAutorotate;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return self.topViewController.supportedInterfaceOrientations;
//}
//
//- (BOOL)debugMode
//{
//    return isDebug;
//}

@end
