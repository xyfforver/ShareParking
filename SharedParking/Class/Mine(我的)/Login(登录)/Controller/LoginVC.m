//
//  LoginVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"

#import "CarNumberAddVC.h"
@interface LoginVC ()<UIScrollViewDelegate>

@property (nonatomic , strong) LoginView *loginView;
@property (nonatomic , strong) UIImageView *logoImgView;
@end

@implementation LoginVC

#pragma mark ---------------LifeCycle-------------------------/
- (instancetype)initWithType:(NSInteger)type completionBack:(dispatch_block_t)completionBack{
    self = [super init];
    if (self) {
        self.type = type;
        self.completionBack = [completionBack copy];
    }
    return self;
}

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
                CarNumberAddVC *vc = [[CarNumberAddVC alloc]initWithType:0];
                vc.loadBlock = ^{
                    [strongSelf loginSuccess];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
}

- (void)changeTelData:(NSString *)tel code:(NSString *)code{
    [UserModel changeTelWithPhoneNum:tel codeNum:code success:^(StatusModel *statusModel) {
       
        [WSProgressHUD showImage:nil status:statusModel.message];
        
        kSelfWeak;
        if (statusModel.flag == kFlagSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:tel forKey:kLingBaoUser];
            [[NSUserDefaults standardUserDefaults] synchronize];
            kSelfStrong;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [strongSelf backToSuperView];
            });
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
        _loginView.type = self.type;
        kSelfWeak;
        _loginView.loginBlock = ^(NSString *tel, NSString *code) {
            kSelfStrong;
            if (strongSelf.type == 1) {
                [strongSelf changeTelData:tel code:code];
            }else{
                [strongSelf loginData:tel code:code];
            }
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
