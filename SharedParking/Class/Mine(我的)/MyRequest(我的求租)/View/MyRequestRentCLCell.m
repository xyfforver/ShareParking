//
//  MyRequestRentCLCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyRequestRentCLCell.h"
@interface MyRequestRentCLCell ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *infoLab;
@property (nonatomic , strong) UILabel *priceLab;
@property (nonatomic , strong) UILabel *typeLab;
@end

@implementation MyRequestRentCLCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setItemModel:(MyRequestItemModel *)itemModel{
    _itemModel = itemModel;
    
    self.titleLab.text = itemModel.park_address;
    self.infoLab.text = @"234m | 5天前 | 3次浏览";
    self.priceLab.text = @"400 元/月";
    self.typeLab.text = @"长租";
}


- (void)initView{
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.backgroundColor = kColorWhite;
    
    [self addSubview:self.titleLab];
    [self addSubview:self.infoLab];
    [self addSubview:self.priceLab];
    [self addSubview:self.typeLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-120);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(kMargin10);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin15);
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-7);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.priceLab);
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(5);
    }];
    

}

#pragma mark ---------------lazy ---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor333333;
    }
    return _titleLab;
}

- (UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = kFontSize13;
        _infoLab.textColor = kColor6B6B6B;
    }
    return _infoLab;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.font = kFontSize15;
        _priceLab.textColor = kColor333333;
        _priceLab.textAlignment = NSTextAlignmentRight;
    }
    return _priceLab;
}

- (UILabel *)typeLab{
    if (!_typeLab) {
        _typeLab = [[UILabel alloc]init];
        _typeLab.font = kFontSize12;
        _typeLab.textColor = kColor333333;
        _typeLab.textAlignment = NSTextAlignmentRight;
    }
    return _typeLab;
}
@end
