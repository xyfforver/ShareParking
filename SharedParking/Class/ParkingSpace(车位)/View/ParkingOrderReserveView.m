//
//  ParkingOrderReserveView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingOrderReserveView.h"
@interface ParkingOrderReserveView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *timeLab;
@end

@implementation ParkingOrderReserveView

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
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.equalTo(self.mas_width).multipliedBy(0.55);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.right.mas_equalTo(0);
    }];
    
    self.titleLab.text = @"剩余时间：";
    self.timeLab.text = @"00：00";
}

#pragma mark ---------------event ---------------------/

#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor6B6B6B;
        _titleLab.textAlignment = NSTextAlignmentRight;
    }
    return _titleLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize15;
        _timeLab.textColor = kColorDD9900;
    }
    return _timeLab;
}
@end
