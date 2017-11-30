//
//  BalanceVC.m
//  yimaxingtianxia
//
//  Created by galaxy on 2017/9/7.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "BalanceVC.h"
#import "PayRecordVC.h"
#import "RechargeVC.h"
@interface BalanceVC ()
@property (nonatomic , strong) UIButton *iconBtn;
@property (nonatomic , strong) UILabel *priceLab;
@property (nonatomic , strong) UIButton *rechangeBtn;
@property (nonatomic , strong) UIButton *withdrawBtn;
@end

@implementation BalanceVC

#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{
    self.title = @"余额";
    
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:@"明细" imageName:nil target:self action:@selector(payRecordAction)];
    
    [self.view addSubview:self.iconBtn];
    [self.iconBtn addSubview:self.priceLab];
    [self.view addSubview:self.rechangeBtn];
    [self.view addSubview:self.withdrawBtn];
    
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.iconBtn);
        make.centerY.mas_equalTo(self.iconBtn.mas_centerY).offset(-5);
        
    }];
    
    [self.rechangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconBtn.mas_bottom).offset(50);
        make.left.mas_equalTo(90);
        make.right.mas_equalTo(-90);
        make.height.mas_equalTo(40);
    }];
    
    [self.withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rechangeBtn.mas_bottom).offset(18);
        make.left.right.height.mas_equalTo(self.rechangeBtn);
    }];
    
    self.priceLab.text = @"￥1234.00";
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{

}

#pragma mark ---------------Event-------------------------/
- (void)payRecordAction{
    PayRecordVC *vc = [[PayRecordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ---------------Lazy-------------------------/
- (UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconBtn setImage:[UIImage imageNamed:@"wallet_icon"] forState:UIControlStateNormal];
        _iconBtn.userInteractionEnabled = NO;
        
    }
    return _iconBtn;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.font = [UIFont fontWithName:CUSTOMFONTULTRABOLD size:24];
        _priceLab.textColor = kColorBlack;
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}

- (UIButton *)rechangeBtn{
    if (!_rechangeBtn) {
        _rechangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechangeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_rechangeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        _rechangeBtn.titleLabel.font = kFontSizeBold15;
        _rechangeBtn.backgroundColor = kNavBarColor;
        _rechangeBtn.layer.cornerRadius = 20;
        _rechangeBtn.layer.masksToBounds = YES;
        kSelfWeak;
        [_rechangeBtn zzh_clickActionBlock:^(UIButton *button) {
            kSelfStrong;
            RechargeVC *vc = [[RechargeVC alloc]init];
            vc.rechangeBlock = ^{
                [strongSelf loadData];
            };
            [strongSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _rechangeBtn;
}

- (UIButton *)withdrawBtn{
    if (!_withdrawBtn) {
        _withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        _withdrawBtn.titleLabel.font = kFontSizeBold15;
        _withdrawBtn.backgroundColor = kColorWhite;
        _withdrawBtn.layer.cornerRadius = 20;
        _withdrawBtn.layer.masksToBounds = YES;
        _withdrawBtn.layer.borderWidth = 1.0;
        _withdrawBtn.layer.borderColor = UIColorHex(0xD2D2D2).CGColor;
    }
    return _withdrawBtn;
}




@end
