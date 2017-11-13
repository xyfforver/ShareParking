//
//  CarportPayVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportPayVC.h"

@interface CarportPayVC ()
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *bgItemView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *priceLab;
@property (nonatomic , strong) UIButton *closeBtn;
@end

@implementation CarportPayVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];

}

- (void)initView{
    self.title = @"结算";
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.bgItemView];
    [self.view addSubview:self.titleLab];
    
    [self.view addSubview:self.priceLab];
    [self.view addSubview:self.closeBtn];
    
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    
    [self.bgItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bgView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.centerX.mas_equalTo(self.bgView.mas_centerX).offset(-50);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(55);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(100);
        make.width.mas_equalTo(185);
        make.height.mas_equalTo(40);
    }];
    
    self.priceLab.text = @"当前停车费：12元";
}

#pragma mark ---------------NetWork-------------------------/


#pragma mark ---------------Event-------------------------/
- (void)closeAnAccount:(UIButton *)button{
    
}

#pragma mark ---------------Lazy-------------------------/
- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"carport_bg"];
    }
    return _bgView;
}

- (UIImageView *)bgItemView{
    if (!_bgItemView) {
        _bgItemView = [[UIImageView alloc]init];
        _bgItemView.image = [UIImage imageNamed:@"carport_bgirem"];
    }
    return _bgItemView;
}


- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColor333333;
        _titleLab.text = @"计时：";
        _titleLab.textAlignment = NSTextAlignmentRight;
    }
    return _titleLab;
}


- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.backgroundColor = kColorWhite;
        _priceLab.font = kFontSizeBold18;
        _priceLab.textColor = kColor333333;
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"点击上锁" forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = kFontSizeBold18;
        [_closeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_closeBtn setBackgroundColor:kNavBarColor];
        [_closeBtn addTarget:self action:@selector(closeAnAccount:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.layer.cornerRadius = 20;
        _closeBtn.layer.masksToBounds = YES;
    }
    return _closeBtn;
}

@end
