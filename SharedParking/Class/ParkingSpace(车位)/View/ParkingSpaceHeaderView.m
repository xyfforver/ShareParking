//
//  ParkingSpaceHeaderView.m
//  SharedParking
//
//  Created by galaxy on 2017/10/27.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingSpaceHeaderView.h"
#import "SearchVC.h"
@interface ParkingSpaceHeaderView ()
@property (nonatomic , strong) UILabel *numberLab1;
@property (nonatomic , strong) UILabel *numberLab2;

@property (nonatomic , strong) UIButton *searchBtn;
@property (nonatomic , strong) UIView *lineView;
@end

@implementation ParkingSpaceHeaderView

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
    
    [self addSubview:self.cityLab];
    [self addSubview:self.numberLab1];
    [self addSubview:self.numberLab2];
    [self addSubview:self.searchBtn];
    [self addSubview:self.lineView];
    
    [self.cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.numberLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cityLab.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.numberLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.numberLab1.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.cityLab.text = @"杭州 今日限行";
    self.numberLab1.text = @"1";
    self.numberLab2.text = @"9";
}




#pragma mark ---------------event ---------------------/
- (void)searchAction:(UIButton *)button{
    SearchVC *vc = [[SearchVC alloc]init];
    [self.Controller.navigationController pushViewController:vc animated:YES];
}

#pragma mark -----------------Lazy---------------------/
- (UILabel *)cityLab{
    if (!_cityLab) {
        _cityLab = [[UILabel alloc]init];
        _cityLab.font = kFontSize13;
        _cityLab.textColor = kColorDeepBlack;
    }
    return _cityLab;
}

- (UILabel *)numberLab1{
    if (!_numberLab1) {
        _numberLab1 = [[UILabel alloc]init];
        _numberLab1.font = kFontSize13;
        _numberLab1.textColor = kColorWhite;
        _numberLab1.textAlignment = NSTextAlignmentCenter;
        _numberLab1.backgroundColor = kColor4292D3;
        _numberLab1.layer.cornerRadius = 3;
        _numberLab1.layer.masksToBounds = YES;
    }
    return _numberLab1;
}

- (UILabel *)numberLab2{
    if (!_numberLab2) {
        _numberLab2 = [[UILabel alloc]init];
        _numberLab2.font = kFontSize13;
        _numberLab2.textColor = kColorWhite;
        _numberLab2.textAlignment = NSTextAlignmentCenter;
        _numberLab2.backgroundColor = kColor4292D3;
        _numberLab2.layer.cornerRadius = 3;
        _numberLab2.layer.masksToBounds = YES;
    }
    return _numberLab2;
}

- (UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"home_searchGray"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _searchBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kColorC1C1C1;
    }
    return _lineView;
}
@end
