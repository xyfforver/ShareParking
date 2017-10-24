//
//  BaseViewController.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/5/18.
//  Copyright © 2017年 lingbao. All rights reserved.
//

// 自定义左右导航栏按钮大小
static CGFloat const sizeButton = 50.0;

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic, strong) NSMutableArray *networkOperations;
@end

@implementation BaseViewController

- (void)dealloc
{
    DLog(@"%@释放了",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    [self resignCurrentFirstResponder];
    
    if ([self isNavRoot]){
        self.hidesBottomBarWhenPushed = NO;
    }else{
        self.hidesBottomBarWhenPushed = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary* attrs =  @{ NSForegroundColorAttributeName:kColorBlack,
                              NSFontAttributeName: kFontSizeBold18,
                              };
    self.navigationController.navigationBar.titleTextAttributes = attrs;
    self.navigationController.navigationBar.barTintColor = kColorWhite;
    self.navigationController.navigationBar.translucent = NO;
    
    self.tabBarController.tabBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.view.layer.shouldRasterize = YES;
    self.view.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    self.view.backgroundColor = kColorWhite;
    
    [self hiddenNavBlackLine];
    
    /*设置默认返回按钮*/
    [self setNavBackItem];
    
}

// 当前视图是否是根视图
- (BOOL)isNavRoot
{
    return self.navigationController.viewControllers.firstObject == self;
}

- (void)resignCurrentFirstResponder
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow endEditing:YES];
}

- (void)setNavBackItem {
    //获取到导航控制器的子视图控制器的个数
    NSInteger count = self.navigationController.viewControllers.count;
    if (count > 1) {
        
        [self initNavBackButton];
    }
}

- (void)initNavBackButton{
    //返回按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    [backButton setEnlargeEdge:20];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backToSuperView
{
    if (self.navigationController.viewControllers.firstObject == self){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        if (self.presentedViewController){
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

//隐藏navigationBar底部黑线
- (void)hiddenNavBlackLine{
    
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if (kSystermVersion >= 10.0){
                //                //10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]]){
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }else{
                //NavigationBar底部的黑线是一个UIImageView上的UIImageView。
                if ([obj isKindOfClass:[UIImageView class]]) {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2) {
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=YES;
                        }
                    }
                }
            }
        }
    }
    
}

// 判断登录
- (void)loginVerifySuccess:(void (^)())success
{
    //登入
    if (!GetDataManager.isLogin) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未登录，请登录查看详情" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
//            LoginVC *login = [[LoginVC alloc] init];
//            login.completionBack = [success copy];
//            JKNavigationController *loginNav = [[JKNavigationController alloc] initWithRootViewController:login];
//            [self presentViewController:loginNav animated:YES completion:nil];
            
        }];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:sure];
        [alertVC addAction:cancle];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        if (success)
        {
            success();
        }
    }
}

// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                     action:(SEL)action
{
    UIButton *btn = [[self class] setRightButton:name image:imageName];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

+ (UIButton *)setRightButton:(NSString *)name image:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imageName && ![imageName isEqualToString:@""])
    {
        UIImage *image = [UIImage imageNamed:imageName]; // [UIImage imageWithName:imageName];
        [button setImage:image forState:UIControlStateNormal];
        
        NSString *images = [NSString stringWithFormat:@"%@_s", imageName];
        UIImage *imageSelected = [UIImage imageNamed:images]; // [UIImage imageWithName:[NSString stringWithFormat:@"%@_s",imageName]];
        if (imageSelected)
        {
            [button setImage:imageSelected forState:UIControlStateSelected];
        }
        
        button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }else
    {
        button.frame = CGRectMake(0, 0, sizeButton, sizeButton);
    }
    
    if (name && ![name isEqualToString:@""])
    {
        [button setTitle:name forState:UIControlStateNormal];
        button.titleLabel.font = kFontSizeBold17;
        [button setTitleColor:kColorBlack forState:UIControlStateNormal];
    }
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    
    return button;
}

#pragma mark- 网络操作的添加和释放

- (void)addNet:(id)net
{
    if (!_networkOperations)
    {
        _networkOperations = [[NSMutableArray alloc] init];
    }
    
    [_networkOperations addObject:net];
}

- (void)releaseNet
{
    for (NSURLSessionDataTask *task in _networkOperations)
    {
        if ([task isKindOfClass:[NSURLSessionDataTask class]] || [task isKindOfClass:[NSURLSessionDataTask class]])
        {
            [task cancel];
        }
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    [self.view endEditing:YES];
//}

@end
