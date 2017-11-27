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
@interface RootViewController ()<UIScrollViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self createQidongView];
    
}

- (void)createQidongView{
    if (![HelpTool unArchiverValue:@"started"])
    {
        [HelpTool archiverSetValue:@"started" key:@"started"];
        
        //当前版本
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *current = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        //2.保存当前版本
        [[NSUserDefaults standardUserDefaults] setValue:current forKey:kPreviousVersion];
        //3.版本状态为最新
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kGetLatestAppVersion];
        DLog(@"版本第一次安装");
        
        startScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)]; //版本记录
        startScroll.contentSize = CGSizeMake(4*self.view.frame.size.width, 80);
        startScroll.backgroundColor = [UIColor lightGrayColor];
        startScroll.pagingEnabled = YES;
        startScroll.showsHorizontalScrollIndicator = NO;
        startScroll.bounces = NO;
        startScroll.delegate = self;
        [self.view addSubview:startScroll];
        for (int i = 1; i<5; i++)
        {
            img =[[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*(i-1), 0, kScreenWidth, kScreenHeight)];
            img.image = [UIImage imageNamed:[NSString stringWithFormat:@"qidong%d",i]];
            img.userInteractionEnabled=YES;
            if(i==4){
                UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(initView)];
                singleRecognizer.numberOfTapsRequired = 1; // 单击
                [img addGestureRecognizer:singleRecognizer];
            }
            [startScroll addSubview:img];
        }
        
    }else{
#pragma mark - 进开屏页面,并搭建正常页面
        //        [self gotoFirstView];
        [self initView];
    }
    
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
    
    [self createTabBar];
}

-(void)createTabBar{
    
    if(startScroll){
        CGRect frame = startScroll.frame;
        frame.origin.y = kScreenHeight;
        startScroll.userInteractionEnabled = NO;
        [UIView animateWithDuration:0.6 animations:^{
            startScroll.frame = frame;
            startScroll.alpha = 0.0;
        } completion:^(BOOL finished) {
            [startScroll removeFromSuperview];
        }];
    }
    
    //设置标题属性
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kColor333333} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : kNavBarColor} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    NSArray *names = @[@"车位",@"发布",@"消息",@"我的"];
    NSArray *imageNormals = @[@"tab_parkingN",@"tab_releaseN",@"tab_messageN",@"tab_mineN"];
    NSArray *imageSeleteds = @[@"tab_parking",@"tab_release",@"tab_message",@"tab_mine"];
    
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
