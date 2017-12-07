//
//  LoginVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"

#import "BindingPlatesVC.h"
@interface LoginVC ()<UIScrollViewDelegate>

@property (nonatomic , strong) LoginView *loginView;
@property (nonatomic , strong) UIImageView *logoImgView;
@end

@implementation LoginVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)loadView
{
    [super loadView];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.view.backgroundColor = kColorWhite;
    
    [self initNavBackButton];
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.logoImgView];
}

#pragma mark ---------------NetWork-------------------------/
- (void)loginData:(NSString *)tel code:(NSString *)code{
    kSelfWeak;
    [UserModel loginWithPhoneNum:tel codeNum:code success:^(StatusModel *statusModel) {
        kSelfStrong;
        [WSProgressHUD showImage:nil status:statusModel.message];
        
        if (statusModel.flag == kFlagSuccess) {
            UserModel *userModel = statusModel.data;
            NSInteger isBinding = userModel.ischepai;
            
            [[NSUserDefaults standardUserDefaults] setObject:tel forKey:kLingBaoUser];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kAutoLogin];
            [[NSUserDefaults standardUserDefaults] synchronize];
            GetDataManager.isLogin = YES;
            
            if (isBinding) {
                // 成功回调
                [strongSelf loginSuccess];
            }else{
                BindingPlatesVC *vc = [[BindingPlatesVC alloc]init];
                vc.completionBack = ^{
                    [strongSelf loginSuccess];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
}

#pragma mark ---------------Event-------------------------/
- (void)loginSuccess{
    if (self.completionBack) {
        [self dismissViewControllerAnimated:YES completion:self.completionBack];
    } else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark ---------------Lazy-------------------------/
- (LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 660/750.0*kScreenWidth)];
        kSelfWeak;
        _loginView.loginBlock = ^(NSString *tel, NSString *code) {
            kSelfStrong;
            [strongSelf loginData:tel code:code];
        };
    }
    return _loginView;
}

- (UIImageView *)logoImgView{
    if (!_logoImgView) {
        _logoImgView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 105)/2.0, self.loginView.bottom + 80, 105, 135)];
        _logoImgView.image = [UIImage imageNamed:@"login_logo"];
    }
    return _logoImgView;
}

@end
