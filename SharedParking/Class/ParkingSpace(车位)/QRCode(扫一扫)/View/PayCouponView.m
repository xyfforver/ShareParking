//
//  PayCouponView.m
//  SharedParking
//
//  Created by 尉超 on 2018/1/31.
//  Copyright © 2018年 galaxy. All rights reserved.
//

#import "PayCouponView.h"
@interface PayCouponView ()
@property (nonatomic , strong) UILabel *moneyLab;
@property (nonatomic , strong) UILabel *useLab;
@property (nonatomic , strong) UIImageView *collectImg;
@end
@implementation PayCouponView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = kColorWhite;
    
    [self addSubview:self.collectImg];
    [self addSubview:self.useLab];
    [self addSubview:self.moneyLab];
    
    
    [self.collectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    [self.useLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectImg.mas_right).offset(10);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        //make.centerX.mas_equalTo(self);
        make.top.bottom.mas_equalTo(0);
    }];
    
    
}


-(UILabel *)moneyLab{
    if (!_moneyLab) {
        _moneyLab = [[UILabel alloc] init];
        _moneyLab.backgroundColor = kColorWhite;
        _moneyLab.font = kFontSize15;
        _moneyLab.textColor = kColor333333;
        NSString *priceStr = @"-5";
        NSString *str = [NSString stringWithFormat:@"内测专享%@元",priceStr];
        NSMutableAttributedString *contentMuStr = [[NSMutableAttributedString alloc]initWithString:str];
        [contentMuStr addAttribute:NSForegroundColorAttributeName value:kColorDD9900 range:NSMakeRange(str.length - priceStr.length - 1, priceStr.length)];
        _moneyLab.attributedText = contentMuStr;
    }
    return _moneyLab;
}

-(UILabel *)useLab{
    if (!_useLab) {
        _useLab = [[UILabel alloc]init];
        _useLab.backgroundColor = kColorWhite;
        _useLab.font = kFontSize15;
        _useLab.textColor = kColor333333;
        _useLab.text = @"使用优惠券";
    }
    return _useLab;
}

-(UIImageView *)collectImg{
    if (!_collectImg) {
        _collectImg = [[UIImageView alloc]init];
        _collectImg.image = [UIImage imageNamed:@"pay_select"];
    }
    return _collectImg;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
