//
//  ParkingSpaceTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/10/28.
//  Copyright © 2017年 galaxy. All rights reserved.
//
#define kImageWidth 50.0

#import "ParkingSpaceTBCell.h"

@interface ParkingSpaceTBCell ()
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *numberLab;
@property (nonatomic,strong) UILabel *typeLab;

@property (nonatomic,strong) UILabel *reserveLab;
@property (nonatomic,strong) UILabel *spaceLab;
@property (nonatomic,strong) UILabel *lockLab;
@end

@implementation ParkingSpaceTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)initView{
//    self.backgroundColor = kColorRandom;
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.locationLab];
    [self.contentView addSubview:self.numberLab];
    [self.contentView addSubview:self.typeLab];
    
    [self.contentView addSubview:self.reserveLab];
    [self.contentView addSubview:self.spaceLab];
    [self.contentView addSubview:self.lockLab];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
        make.width.height.mas_equalTo(kImageWidth);
    }];
    
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgView.mas_top).mas_offset(2);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(105);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numberLab.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.numberLab);
        make.width.mas_equalTo(60);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgView.mas_right).offset(10);
        make.top.mas_equalTo(self.imgView);
        make.right.mas_equalTo(self.numberLab.mas_left).offset(-5);
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(10);
        make.right.mas_equalTo(self.typeLab.mas_left).offset(-5);
    }];
    
    [self.reserveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.locationLab.mas_bottom).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    
    [self.spaceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.reserveLab.mas_right).offset(5);
        make.top.width.height.mas_equalTo(self.reserveLab);
    }];
    
    [self.lockLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.spaceLab.mas_right).offset(5);
        make.top.width.height.mas_equalTo(self.reserveLab);
    }];
    
    self.titleLab.text = @"商场停车场";
    self.locationLab.text = @"距您3km  开车约8分钟";
    self.numberLab.text = @"剩余车位 12/65";
    self.typeLab.text = @"错时";
    
    self.spaceLab.text = @"小区";
    self.lockLab.text = @"地锁";
}

#pragma mark ---------------lazy ---------------------/
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = kColorC1C1C1;
        _imgView.layer.cornerRadius = kImageWidth/2.0;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor333333;
    }
    return _titleLab;
}

- (UILabel *)locationLab{
    if (!_locationLab) {
        _locationLab = [[UILabel alloc]init];
        _locationLab.font = kFontSize13;
        _locationLab.textColor = kColor6B6B6B;
    }
    return _locationLab;
}

- (UILabel *)numberLab{
    if (!_numberLab) {
        _numberLab = [[UILabel alloc]init];
        _numberLab.font = kFontSize15;
        _numberLab.textColor = kColorDD9900;
        _numberLab.textAlignment = NSTextAlignmentRight;
    }
    return _numberLab;
}

- (UILabel *)typeLab{
    if (!_typeLab) {
        _typeLab = [[UILabel alloc]init];
        _typeLab.font = kFontSize15;
        _typeLab.textColor = kColor333333;
        _typeLab.textAlignment = NSTextAlignmentRight;
    }
    return _typeLab;
}
//
- (UILabel *)reserveLab{
    if (!_reserveLab) {
        _reserveLab = [[UILabel alloc]init];
        _reserveLab.font = kFontSizeBold12;
        _reserveLab.textColor = kColorWhite;
        _reserveLab.backgroundColor = kColorDeepBlack;
        _reserveLab.textAlignment = NSTextAlignmentCenter;
        
        _reserveLab.layer.masksToBounds = YES;
        _reserveLab.layer.cornerRadius = 10;
        _reserveLab.text = @"预订";
    }
    return _reserveLab;
}

- (UILabel *)spaceLab{
    if (!_spaceLab) {
        _spaceLab = [[UILabel alloc]init];
        _spaceLab.font = kFontSizeBold12;
        _spaceLab.textColor = kColorWhite;
        _spaceLab.backgroundColor = kColorDeepBlack;
        _spaceLab.textAlignment = NSTextAlignmentCenter;
        
        _spaceLab.layer.masksToBounds = YES;
        _spaceLab.layer.cornerRadius = 10;
    }
    return _spaceLab;
}

- (UILabel *)lockLab{
    if (!_lockLab) {
        _lockLab = [[UILabel alloc]init];
        _lockLab.font = kFontSizeBold12;
        _lockLab.textColor = kColorWhite;
        _lockLab.backgroundColor = kColorDeepBlack;
        _lockLab.textAlignment = NSTextAlignmentCenter;
        
        _lockLab.layer.masksToBounds = YES;
        _lockLab.layer.cornerRadius = 10;
    }
    return _lockLab;
}

@end
