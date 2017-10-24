//
//  RootViewController.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/18.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "RootViewController.h"
#import "BaseViewController.h"
#import "JKNavigationController.h"

#import "ParkingSpaceVC.h"
#import "ReleaseVC.h"
#import "MessageVC.h"
#import "MineVC.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initView];
    
    [self createTabBar];
}

- (void)initView{
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    ParkingSpaceVC *vc1 = [[ParkingSpaceVC alloc]init];
    JKNavigationController *navi1 = [[JKNavigationController alloc] initWithRootViewController:vc1];
    [viewControllers addObject:navi1];
    
    ReleaseVC *vc2 = [[ReleaseVC alloc]init];
    JKNavigationController *navi2 = [[JKNavigationController alloc] initWithRootViewController:vc2];
    [viewControllers addObject:navi2];
    
    MessageVC *vc3 = [[MessageVC alloc]init];
    JKNavigationController *navi3 = [[JKNavigationController alloc] initWithRootViewController:vc3];
    [viewControllers addObject:navi3];
    
    MineVC *vc4 = [[MineVC alloc]init];
    JKNavigationController *navi4 = [[JKNavigationController alloc] initWithRootViewController:vc4];
    [viewControllers addObject:navi4];
    
    self.viewControllers = viewControllers;
}


-(void)createTabBar{
    
    //设置标题属性
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:243/255.0 green:92/255.0 blue:94/255.0 alpha:1]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    NSArray *names = @[@"车位",@"发布",@"消息",@"我的"];
    NSArray *imageNormals = @[@"tab_home_gray",@"tab_discover_gray",@"tab_shoppingcar_gray",@"tab_user_gray"];
    NSArray *imageSeleteds = @[@"tab_home_red",@"tab_discover_red",@"tab_shoppingcar_red",@"tab_user_red"];
    
    for (int i = 0 ; i<names.count ; i++) {
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        item.image = [UIImage imageNamed:imageNormals[i]];
        item.selectedImage = [[UIImage imageNamed:imageSeleteds[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = names[i];
    }
}


//- (void)setSelectedIndex:(NSUInteger)selectedIndex
//{
//    [self setSelectedTabRootState:selectedIndex];
//    [super setSelectedIndex:selectedIndex];
//    self.selectedIndex = selectedIndex;
//}

- (void)setSelectedTabRootState:(NSUInteger)selectedIndex
{
    UINavigationController *navVC = self.viewControllers[selectedIndex];
    if (navVC.presentedViewController) {
        if ([navVC.topViewController presentedViewController]) {
            [navVC.topViewController dismissViewControllerAnimated:NO completion:nil];
        }
    }
    if ([navVC.viewControllers count] > 1) {
        if (super.selectedIndex == selectedIndex) {
            [navVC popToRootViewControllerAnimated:YES];
        } else {
            [navVC popToRootViewControllerAnimated:NO];
        }
    }
}
- (BOOL)shouldAutorotate{
    return self.selectedViewController.shouldAutorotate;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}


@end
