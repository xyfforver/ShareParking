//
//  MineHeaderView.m
//  SharedParking
//
//  Created by galaxy on 2017/10/25.
//  Copyright © 2017年 galaxy. All rights reserved.
//
#define kHeadWidth  80.0
#define kItemSpace 3.0
#import "MineHeaderView.h"

#import "BalanceVC.h"
#import "EditVC.h"
#import "CarNumberListVC.h"
@interface MineHeaderView()
@property (nonatomic , strong) UIImageView *bgImgView;
@property (nonatomic , strong) UIImageView *headImgView;
@property (nonatomic , strong) UIButton *nickNameBtn;//用户名
@property (nonatomic , strong) UILabel *balanceLab;//余额
@property (nonatomic , strong) UILabel *numberLab;//车牌
@property (nonatomic , strong) UIView *lineView;//线

@end
@implementation MineHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.backgroundColor = kBackGroundGrayColor;
    
    
    [self addSubview:self.bgImgView];
    [self addSubview:self.headImgView];
    [self addSubview:self.nickNameBtn];
    [self addSubview:self.balanceLab];
    [self addSubview:self.numberLab];
    [self addSubview:self.lineView];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(450.0/750.0*kScreenWidth);
        make.width.mas_equalTo(self.mas_width);
    }];
    
    [self.headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(kStatusBarAndNavigationBarHeight + 10);
        make.width.height.mas_equalTo(kHeadWidth);
    }];
    
    [self.nickNameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImgView.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    [_nickNameBtn lc_titleImageHorizontalAlignmentWithSpace:15];
    
    [self.balanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.bgImgView.mas_bottom);
        make.height.mas_equalTo(65);
        make.width.mas_equalTo(kScreenWidth / 2.0);
    }];
    
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.balanceLab.mas_right);
        make.top.mas_equalTo(self.balanceLab.mas_top);
        make.height.mas_equalTo(65);
        make.width.mas_equalTo(kScreenWidth / 2.0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.balanceLab);
        make.left.mas_equalTo(kScreenWidth/2.0);
    }];
    
    NSString *str = @"余额：12.00";
    NSMutableAttributedString *contentMuStr = [[NSMutableAttributedString alloc]initWithString:str];
    [contentMuStr addAttribute:NSForegroundColorAttributeName value:kColorDD9900 range:NSMakeRange(3, str.length - 3)];
    self.balanceLab.attributedText = contentMuStr;
    
    NSString *numberStr = @"车牌：浙A13456";
    NSMutableAttributedString *numberMuStr = [[NSMutableAttributedString alloc]initWithString:numberStr];
    [numberMuStr addAttribute:NSForegroundColorAttributeName value:kColorDD9900 range:NSMakeRange(3, numberStr.length - 3)];
    self.numberLab.attributedText = numberMuStr;
}

#pragma mark ---------------event ---------------------/
- (void)goToEdit{
//    if (GetDataManager.isLogin) {
        EditVC *vc = [[EditVC alloc]init];
        [self.Controller.navigationController pushViewController:vc animated:YES];
//    }else{
//        [self GoToLogin];
//    }
}

#pragma mark -----------------Lazy---------------------/
- (UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc]init];
        _bgImgView.backgroundColor = kNavBarColor;
    }
    return _bgImgView;
}

- (UIImageView *)headImgView{
    if (!_headImgView) {
        _headImgView = [[UIImageView alloc]init];
        _headImgView.userInteractionEnabled = YES;
        _headImgView.layer.cornerRadius = kHeadWidth / 2.0;
        _headImgView.layer.masksToBounds = YES;
        _headImgView.layer.borderColor = kColorWhite.CGColor;
        _headImgView.layer.borderWidth = kItemSpace;
        _headImgView.backgroundColor = kBackGroundGrayColor;
        _headImgView.userInteractionEnabled = YES;
        kSelfWeak;
        [_headImgView zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            kSelfStrong;
            [strongSelf goToEdit];
        }];
    }
    return _headImgView;
}

- (UIButton *)nickNameBtn{
    if (!_nickNameBtn) {
        _nickNameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nickNameBtn.titleLabel.font = kFontSizeBold20;
        [_nickNameBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_nickNameBtn setTitle:@"1873929338" forState:UIControlStateNormal];
        [_nickNameBtn setImage:[UIImage imageNamed:@"mine_edit"] forState:UIControlStateNormal];
        kSelfWeak;
        [_nickNameBtn zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            kSelfStrong;
            [strongSelf goToEdit];
        }];
    }
    return _nickNameBtn;
}

- (UILabel *)balanceLab{
    if (!_balanceLab) {
        _balanceLab = [[UILabel alloc]init];
        _balanceLab.font = kFontSize16;
        _balanceLab.textColor = kColorBlack;
        _balanceLab.textAlignment = NSTextAlignmentCenter;
        _balanceLab.text = @"余额：12.00";
        _balanceLab.backgroundColor = kColorWhite;
        
        [_balanceLab zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            BalanceVC *vc = [[BalanceVC alloc]init];
            [self.Controller.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _balanceLab;
}

- (UILabel *)numberLab{
    if (!_numberLab) {
        _numberLab = [[UILabel alloc]init];
        _numberLab.font = kFontSize16;
        _numberLab.textColor = kColorBlack;
        _numberLab.textAlignment = NSTextAlignmentCenter;
        _numberLab.text = @"车牌：浙A13456";
        _numberLab.backgroundColor = kColorWhite;
        
        [_numberLab zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            CarNumberListVC *vc = [[CarNumberListVC alloc]init];
            [self.Controller.navigationController pushViewController:vc animated:YES];
        }];
        
    }
    return _numberLab;
}
   

- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kColor6B6B6B;
    }
    return _lineView;
}


@end
