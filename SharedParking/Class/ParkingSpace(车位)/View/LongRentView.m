//
//  LongRentView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "LongRentView.h"
@interface LongRentView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UILabel *infoLab;

@property (nonatomic , strong) UIButton *telBtn;
@property (nonatomic , strong) UIButton *infoBtn;
@property (nonatomic , strong) UIView *lineView;
@end

@implementation LongRentView

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
    [self addSubview:self.timeLab];
    [self addSubview:self.infoLab];
    [self addSubview:self.telBtn];
    [self addSubview:self.infoBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(kMargin15);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
        make.right.mas_equalTo(-kMargin15);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.titleLab.mas_bottom);
        make.left.mas_equalTo(self.titleLab.mas_right).offset(10);
    }];
    
    [self.telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(self.width/2.0);
    }];
    
    [self.infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(0);
        make.height.width.mas_equalTo(self.telBtn);
    }];
    
    self.titleLab.text = @"商场停车场";
    self.infoLab.text = @"距您3km 开车约8分钟";
    self.timeLab.text = @"1天前";
}

#pragma mark ---------------event ---------------------/
- (void)robParkingAction:(UIButton *)button{
    
}

- (void)infoAction:(UIButton *)button{
    
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

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize15;
        _timeLab.textColor = kColor6B6B6B;
        //        _countLab.backgroundColor = kColorBlue;
    }
    return _timeLab;
}

- (UIButton *)telBtn{
    if (!_telBtn) {
        _telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_telBtn setTitle:@"电话联系" forState:UIControlStateNormal];
        _telBtn.titleLabel.font = kFontSizeBold15;
        [_telBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_telBtn setBackgroundColor:kNavBarColor];
        [_telBtn addTarget:self action:@selector(robParkingAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _telBtn;
}

- (UIButton *)infoBtn{
    if (!_infoBtn) {
        _infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_infoBtn setTitle:@"详情" forState:UIControlStateNormal];
        _infoBtn.titleLabel.font = kFontSizeBold15;
        [_infoBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_infoBtn setBackgroundColor:kNavBarColor];
        [_infoBtn addTarget:self action:@selector(infoAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _infoBtn;
}


+ (CGFloat)getHeight{
    return 120;
}
@end
