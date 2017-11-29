//
//  RobParkingView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "RobParkingView.h"
@interface RobParkingView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *countLab;
@property (nonatomic , strong) UILabel *infoLab;
@property (nonatomic , strong) UIButton *robBtn;
@end

@implementation RobParkingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.backgroundColor = kColorWhite;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.titleLab];
    [self addSubview:self.countLab];
    [self addSubview:self.infoLab];
    [self addSubview:self.robBtn];
    
    [self.robBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(kMargin15);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
        make.right.mas_equalTo(-kMargin15);
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-kMargin15);
        make.left.mas_equalTo(self.titleLab.mas_right);
    }];
    
    self.titleLab.text = @"商场停车场";
    self.infoLab.text = @"距您3km 开车约8分钟";
    self.countLab.text = @"剩余车位12/65";
}

#pragma mark ---------------event ---------------------/
- (void)robParkingAction:(UIButton *)button{
    
}

#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColor333333;
    }
    return _titleLab;
}

- (UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = kFontSize14;
        _infoLab.textColor = kColor6B6B6B;
    }
    return _infoLab;
}

- (UILabel *)countLab{
    if (!_countLab) {
        _countLab = [[UILabel alloc]init];
        _countLab.font = kFontSize15;
        _countLab.textColor = kColorDD9900;
        _countLab.textAlignment = NSTextAlignmentRight;
//        _countLab.backgroundColor = kColorBlue;
    }
    return _countLab;
}

- (UIButton *)robBtn{
    if (!_robBtn) {
        _robBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_robBtn setTitle:@"抢车位" forState:UIControlStateNormal];
        _robBtn.titleLabel.font = kFontSizeBold15;
        [_robBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_robBtn setBackgroundColor:kNavBarColor];
        [_robBtn addTarget:self action:@selector(robParkingAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _robBtn;
}


+ (CGFloat)getHeight{
    return 120;
}
@end
