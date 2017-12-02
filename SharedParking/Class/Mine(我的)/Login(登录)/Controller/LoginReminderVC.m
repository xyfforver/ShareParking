//
//  LoginReminderVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "LoginReminderVC.h"
#import "RootViewController.h"
#import "LoginVC.h"
@interface LoginReminderVC ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIImageView *logoImgView;
@property (nonatomic , strong) UIButton *visitorBtn;
@property (nonatomic , strong) UIButton *loginBtn;
@property (nonatomic , strong) UILabel *nameLab;
@end

@implementation LoginReminderVC

#pragma mark ---------------LifeCycle-------------------------/
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
                UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(isLogin)];
                singleRecognizer.numberOfTapsRequired = 1; // 单击
                [img addGestureRecognizer:singleRecognizer];
            }
            [startScroll addSubview:img];
        }
        
    }else{
#pragma mark - 进开屏页面,并搭建正常页面
        [self isLogin];
    }
    
}

- (void)isLogin{
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
    
    if (GetDataManager.isLogin) {
        [self visitorAction];
    }else{
        [self initView];
    }
}

- (void)initView{

    self.view.backgroundColor = kColorWhite;
    
    [self.view addSubview:self.logoImgView];
    [self.view addSubview:self.visitorBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.nameLab];
    
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/
- (void)visitorAction{
    RootViewController *vc = [[RootViewController alloc] init];
    UIApplication.sharedApplication.delegate.window.rootViewController = vc;
}

- (void)loginAction:(UIButton *)button{
    LoginVC *vc = [[LoginVC alloc]init];
    kSelfWeak;
    vc.completionBack = ^{
        kSelfStrong;
        [strongSelf visitorAction];
    };
    JKNavigationController *loginNav = [[JKNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:loginNav animated:YES completion:nil];
}

#pragma mark ---------------Lazy-------------------------/
- (UIImageView *)logoImgView{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc]init];
        _logoImgView.image = [UIImage imageNamed:@"login_logo"];
        _logoImgView.frame = CGRectMake((kScreenWidth - 150)/2.0, 90 + kTabbarSafeBottomMargin, 150, 200);
    }
    return _logoImgView;
}

- (UIButton *)visitorBtn{
    if (!_visitorBtn) {
        _visitorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_visitorBtn setTitle:@"游客" forState:UIControlStateNormal];
        _visitorBtn.titleLabel.font = kFontSize15;
        [_visitorBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_visitorBtn setImage:[UIImage imageNamed:@"login_visitor"] forState:UIControlStateNormal];
        [_visitorBtn addTarget:self action:@selector(visitorAction) forControlEvents:UIControlEventTouchUpInside];
        _visitorBtn.frame = CGRectMake((kScreenWidth - 100 * 2 - 70)/2.0, self.logoImgView.bottom + 100, 100, 120);
        [_visitorBtn lc_imageTitleVerticalAlignmentWithSpace:20];
    }
    return _visitorBtn;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = kFontSize15;
        [_loginBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_loginBtn setImage:[UIImage imageNamed:@"login_go"] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.frame = CGRectMake(self.visitorBtn.right + 70, self.visitorBtn.top, self.visitorBtn.width, self.visitorBtn.height);
        [_loginBtn lc_imageTitleVerticalAlignmentWithSpace:20];
    }
    return _loginBtn;
}

- (UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.font = kFontSize14;
        _nameLab.textColor = UIColorHex(0x3AC8D7);
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.frame = CGRectMake(kMargin15, kScreenHeight - kTabbarSafeBottomMargin - 30, kScreenWidth - 2 * kMargin15, 20);
        _nameLab.text = @"杭州一码通网络科技有限公司";
    }
    return _nameLab;
}
@end
