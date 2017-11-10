//
//  MyReserveItemView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/10.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyReserveItemView.h"
@interface MyReserveItemView ()
@property (nonatomic , strong) UIView *infoBgView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *carNumLab;
@property (nonatomic , strong) UIButton *locationBtn;

@property (nonatomic , strong) UIView *btnBgView;
@property (nonatomic , strong) UIButton *cancelBtn;
@property (nonatomic , strong) UIButton *gpsBtn;
@property (nonatomic , strong) UIView *lineView;

@end

@implementation MyReserveItemView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    [self addSubview:self.infoBgView];
    [self.infoBgView addSubview:self.titleLab];
    [self.infoBgView addSubview:self.carNumLab];
    [self.infoBgView addSubview:self.locationBtn];
    
    [self addSubview:self.btnBgView];
    [self.btnBgView addSubview:self.cancelBtn];
    [self.btnBgView addSubview:self.lineView];
    [self.btnBgView addSubview:self.gpsBtn];
    
    
    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.bottom.mas_equalTo(-kMargin15);
        make.height.mas_equalTo(50);
    }];
    
    [self.infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.btnBgView);
        make.top.mas_equalTo(kMargin10);
        make.bottom.mas_equalTo(self.btnBgView.mas_top).offset(-5);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.btnBgView.mas_width).multipliedBy(0.5);
    }];
    
    [self.gpsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(self.cancelBtn);
        make.right.mas_equalTo(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kMargin15);
        make.left.mas_equalTo(self.cancelBtn.mas_right).offset(-1);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.btnBgView);
    }];

    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(30);
    }];
    
    [self.carNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(25);
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.carNumLab.mas_bottom).offset(20);
    }];
    [self.locationBtn lc_imageTitleHorizontalAlignmentWithSpace:10];
    
    self.titleLab.text = @"萧山地下停车场";
    self.carNumLab.text = @"车位号：A区01号";
    
}

#pragma mark ---------------event ---------------------/
- (void)cancelAction:(UIButton *)button{
    
}

- (void)gpsAction:(UIButton *)button{
    
}


#pragma mark -----------------Lazy---------------------/
- (UIView *)infoBgView{
    if (!_infoBgView) {
        _infoBgView = [[UIView alloc]init];
        _infoBgView.backgroundColor = kColorWhite;
        _infoBgView.layer.cornerRadius = 5;
        _infoBgView.layer.masksToBounds = YES;
    }
    return _infoBgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize18;
        _titleLab.textColor = kColorBlack;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)carNumLab{
    if (!_carNumLab) {
        _carNumLab = [[UILabel alloc]init];
        _carNumLab.font = kFontSize15;
        _carNumLab.textColor = kColor333333;
        _carNumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _carNumLab;
}

- (UIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setTitle:@"位置" forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = kFontSize15;
        [_locationBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_locationBtn setImage:[UIImage imageNamed:@"mine_location"] forState:UIControlStateNormal];
    }
    return _locationBtn;
}

- (UIView *)btnBgView{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = kColorWhite;
        _btnBgView.layer.cornerRadius = 5;
        _btnBgView.layer.masksToBounds = YES;
    }
    return _btnBgView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消预订" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = kFontSize15;
        [_cancelBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)gpsBtn{
    if (!_gpsBtn) {
        _gpsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gpsBtn setTitle:@"导航" forState:UIControlStateNormal];
        _gpsBtn.titleLabel.font = kFontSize15;
        [_gpsBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_gpsBtn addTarget:self action:@selector(gpsAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _gpsBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kColor6B6B6B;
    }
    return _lineView;
}

+ (CGFloat )getHeight{
    return 240;
}


@end
