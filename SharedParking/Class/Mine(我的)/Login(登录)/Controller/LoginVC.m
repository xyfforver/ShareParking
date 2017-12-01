//
//  LoginVC.m
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "LoginVC.h"
#import "LoginView.h"
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
    
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.logoImgView];
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/


#pragma mark ---------------Lazy-------------------------/
- (LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LoginView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 660/750.0*kScreenWidth)];
        
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
