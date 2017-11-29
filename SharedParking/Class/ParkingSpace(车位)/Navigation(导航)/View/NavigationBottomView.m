//
//  NavigationBottomView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/29.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "NavigationBottomView.h"
@interface NavigationBottomView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *infoLab;
@property (nonatomic , strong) UIButton *goBtn;
@end

@implementation NavigationBottomView

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
    [self addSubview:self.titleLab];
    [self addSubview:self.infoLab];
    [self addSubview:self.goBtn];
    
    [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(107);
        make.height.mas_equalTo(40);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(self.goBtn.mas_left).offset(-5);
        make.top.mas_equalTo(kMargin15);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
    }];
    
    self.titleLab.text = @"8分钟 3km";
    self.infoLab.text = @"红绿灯5个";
}

#pragma mark ---------------event ---------------------/
- (void)goAction:(UIButton *)button{
    
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
        _infoLab.font = kFontSize15;
        _infoLab.textColor = kColor6B6B6B;
    }
    return _infoLab;
}

- (UIButton *)goBtn{
    if (!_goBtn) {
        _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goBtn setTitle:@"去这里" forState:UIControlStateNormal];
        _goBtn.titleLabel.font = kFontSizeBold15;
        [_goBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_goBtn setBackgroundColor:kNavBarColor];
        [_goBtn addTarget:self action:@selector(goAction:) forControlEvents:UIControlEventTouchUpInside];
        _goBtn.layer.cornerRadius = 5;
        _goBtn.layer.masksToBounds = YES;
    }
    return _goBtn;
}
@end
