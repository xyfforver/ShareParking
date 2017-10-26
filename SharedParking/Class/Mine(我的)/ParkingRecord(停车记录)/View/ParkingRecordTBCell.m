//
//  ParkingRecordTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/10/26.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingRecordTBCell.h"
@interface ParkingRecordTBCell ()
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *numberLab;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UILabel *priceLab;
@end

@implementation ParkingRecordTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView{
    self.backgroundColor = kBackGroundGrayColor;
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.numberLab];
    [self.bgView addSubview:self.timeLab];
    [self.bgView addSubview:self.priceLab];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.bottom.mas_equalTo(-10);
        make.top.mas_equalTo(0);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(25);
    }];
    
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.numberLab.mas_bottom).offset(5);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(self.bgView.mas_centerY);
    }];
    
    self.titleLab.text = @"萧山地下停车场";
    self.numberLab.text = @"车位号：12";
    self.timeLab.text = @"2017-09-09 16：10-17：00";
    self.priceLab.text = @"1元";
}

#pragma mark ---------------lazy ---------------------/
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kColorWhite;
        _bgView.layer.cornerRadius = 3;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize18;
        _titleLab.textColor = kColor333333;
    }
    return _titleLab;
}

- (UILabel *)numberLab{
    if (!_numberLab) {
        _numberLab = [[UILabel alloc]init];
        _numberLab.font = kFontSize15;
        _numberLab.textColor = kColor6B6B6B;
    }
    return _numberLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize13;
        _timeLab.textColor = kColorC1C1C1;
    }
    return _timeLab;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.font = kFontSizeBold18;
        _priceLab.textColor = kColor333333;
    }
    return _priceLab;
}

@end
