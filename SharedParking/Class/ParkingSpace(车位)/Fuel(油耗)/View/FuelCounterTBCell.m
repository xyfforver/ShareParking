//
//  FuelCounterTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "FuelCounterTBCell.h"
@interface FuelCounterTBCell ()
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UILabel *allPriceLab;
@property (nonatomic , strong) UILabel *allAmountLab;
@property (nonatomic , strong) UILabel *priceLab;
@property (nonatomic , strong) UILabel *amountLab;
@end

@implementation FuelCounterTBCell

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
    [self.bgView addSubview:self.timeLab];
    [self.bgView addSubview:self.allPriceLab];
    [self.bgView addSubview:self.allAmountLab];
    [self.bgView addSubview:self.priceLab];
    [self.bgView addSubview:self.amountLab];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(1);
        make.bottom.mas_equalTo(-1);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(kMargin10);
    }];
    
    CGFloat itemWidth = (kScreenWidth - kMargin15 * 5)/2.0;
    
    [self.allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLab);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(kMargin10);
        make.width.mas_equalTo(itemWidth);
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.timeLab);
        make.top.mas_equalTo(self.allPriceLab.mas_bottom).offset(kMargin10);
    }];
    
    [self.allAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin15);
        make.width.top.mas_equalTo(self.allPriceLab);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin15);
        make.width.mas_equalTo(itemWidth);
        make.top.mas_equalTo(self.amountLab);
    }];
    
    
    self.timeLab.text = @"2017-10-21";
    self.allPriceLab.text = @"金额：200（元）";
    self.allAmountLab.text = @"里程：200（公里）";
    self.amountLab.text = @"每百公里：1（升）";
    self.priceLab.text = @"每公里：1.2（元）";
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

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize18;
        _timeLab.textColor = kColor6B6B6B;
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}

- (UILabel *)allPriceLab{
    if (!_allPriceLab) {
        _allPriceLab = [[UILabel alloc]init];
        _allPriceLab.font = kFontSize15;
        _allPriceLab.textColor = kColor6B6B6B;
    }
    return _allPriceLab;
}

- (UILabel *)allAmountLab{
    if (!_allAmountLab) {
        _allAmountLab = [[UILabel alloc]init];
        _allAmountLab.font = kFontSize15;
        _allAmountLab.textColor = kColor6B6B6B;
    }
    return _allAmountLab;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.font = kFontSize15;
        _priceLab.textColor = kColor6B6B6B;
    }
    return _priceLab;
}

- (UILabel *)amountLab{
    if (!_amountLab) {
        _amountLab = [[UILabel alloc]init];
        _amountLab.font = kFontSize15;
        _amountLab.textColor = kColor6B6B6B;
    }
    return _amountLab;
}



@end
