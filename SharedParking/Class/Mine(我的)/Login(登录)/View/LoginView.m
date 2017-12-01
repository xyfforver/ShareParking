//
//  LoginView.m
//  SharedParking
//
//  Created by galaxy on 2017/12/1.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "LoginView.h"
#import "LeftImageTextField.h"
#import "JKCountDownButton.h"

#import "BindingPlatesVC.h"
@interface LoginView ()<UITextFieldDelegate>
@property (nonatomic , strong) UIImageView *imgView;
@property (nonatomic , strong) LeftImageTextField *telField;
@property (nonatomic , strong) LeftImageTextField *codeField;
@property (nonatomic , strong) JKCountDownButton *getCodeBtn;
@property (nonatomic , strong) UIButton *loginBtn;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    [self addSubview:self.imgView];
    [self addSubview:self.telField];
    [self addSubview:self.codeField];
    [self addSubview:self.getCodeBtn];
    [self addSubview:self.loginBtn];
    
    
    
    
    
    
}

#pragma mark ---------------event ---------------------/
- (void)getCodeNum{
    
}

- (void)loginAction:(UIButton *)button{
    BindingPlatesVC *vc = [[BindingPlatesVC alloc]init];
    [self.Controller.navigationController pushViewController:vc animated:YES];
}

#pragma mark -----------------Lazy---------------------/

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"login_bg"];
        _imgView.userInteractionEnabled = YES;
        _imgView.frame = CGRectMake(0, 0, self.width, self.height);
    }
    return _imgView;
}

- (LeftImageTextField *)telField{
    if (!_telField) {
        _telField = [[LeftImageTextField alloc] init];
        _telField.font = kFontSize14;
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"您的手机号" attributes: @{NSForegroundColorAttributeName:kColor6B6B6B,
                                            NSFontAttributeName:_telField.font}];
        _telField.attributedPlaceholder = attrString;
        _telField.keyboardType = UIKeyboardTypeASCIICapable;
        _telField.leftImageView.image = [UIImage imageNamed:@"login_tel"];
        _telField.delegate = self;
        _telField.rightViewMode = UITextFieldViewModeWhileEditing;
//        NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:kJuTaoUser];
//        _telField.text = phone;
        _telField.backgroundColor = RGB(255, 255, 255, 0.6);
        _telField.textColor = kColor333333;
        _telField.layer.cornerRadius = 20;
        _telField.frame = CGRectMake(50, 90, self.width - 100, 40);
    }
    return _telField;
}

- (LeftImageTextField *)codeField{
    if (!_codeField) {
        _codeField = [[LeftImageTextField alloc] init];
        _codeField.font = kFontSize14;
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes: @{NSForegroundColorAttributeName:kColor6B6B6B,
                             NSFontAttributeName:_codeField.font}];
        _codeField.attributedPlaceholder = attrString;
        _codeField.keyboardType = UIKeyboardTypeDefault;
        _codeField.secureTextEntry = YES;
        _codeField.leftImageView.image = [UIImage imageNamed:@"login_code"];
        _codeField.delegate = self;
        _codeField.returnKeyType = UIReturnKeyDone;
        _codeField.backgroundColor = RGB(255, 255, 255, 0.6);
        _codeField.textColor = kColor333333;
        _codeField.layer.cornerRadius = 20;
        _codeField.frame = CGRectMake(self.telField.left, self.telField.bottom + kMargin15, self.telField.width/2.0 + 15, 40);
    }
    return _codeField;
}

- (JKCountDownButton *)getCodeBtn{
    if (!_getCodeBtn) {
        _getCodeBtn = [[JKCountDownButton alloc]init];
        _getCodeBtn.normalTitle = @"获取验证码";
        [_getCodeBtn setTitleColor:kColor6B6B6B forState:UIControlStateNormal];
        _getCodeBtn.time = 60;
        [_getCodeBtn addTarget:self action:@selector(getCodeNum) forControlEvents:UIControlEventTouchUpInside];
        _getCodeBtn.layer.cornerRadius = 20;
        _getCodeBtn.titleLabel.font = kFontSize14;
        _getCodeBtn.backgroundColor = RGB(255, 255, 255, 0.6);
        _getCodeBtn.frame = CGRectMake(self.codeField.right + 5, self.codeField.top, self.telField.right - self.codeField.right - 5, 40);
    }
    return _getCodeBtn;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = kFontSize15;
        [_loginBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:kNavBarColor];
        [_loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.frame = CGRectMake(self.telField.left, self.imgView.height - 40 - 50, self.telField.width, 40);
        _loginBtn.layer.cornerRadius = 20;
    }
    return _loginBtn;
}
@end
