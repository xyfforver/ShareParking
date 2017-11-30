//
//  ParkingOrderTimeView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingOrderTimeView.h"
@interface ParkingOrderTimeView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UILabel *priceLab;
@end

@implementation ParkingOrderTimeView

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
    self.layer.cornerRadius = 2;
    self.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,2);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 2;
    
    [self addSubview:self.titleLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.priceLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(kMargin15);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.right.mas_equalTo(-kMargin15);
//        make.left.mas_equalTo(self.timeLab.mas_right);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.right.mas_equalTo(self.priceLab.mas_left).offset(-5);
    }];

    self.titleLab.text = @"停车时间：";
    self.timeLab.text = @"00：00";
    self.priceLab.text = @"收费：1元";
}

#pragma mark ---------------event ---------------------/

#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor6B6B6B;
    }
    return _titleLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize15;
        _timeLab.textColor = kColorDD9900;
//        _timeLab.backgroundColor = kBackGroundGrayColor;
    }
    return _timeLab;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.font = kFontSize15;
        _priceLab.textColor = kColor6B6B6B;
        _priceLab.textAlignment = NSTextAlignmentRight;
    }
    return _priceLab;
}
@end
