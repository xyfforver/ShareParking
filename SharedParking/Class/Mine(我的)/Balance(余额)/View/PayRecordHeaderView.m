//
//  PayRecordHeaderView.m
//  yimaxingtianxia
//
//  Created by galaxy on 2017/9/26.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "PayRecordHeaderView.h"
@interface PayRecordHeaderView()
@property (nonatomic , strong) UIImageView *iconView;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UILabel *infoLab;
@property (nonatomic , strong) UIView *lineView;
@property (nonatomic , strong) UIImageView *imgView;
@end
@implementation PayRecordHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setGroupModel:(PayRecordGroupModel *)groupModel{
    _groupModel = groupModel;
    
    self.timeLab.text = [NSString stringWithFormat:@"%ld年%ld月",groupModel.year,groupModel.month];
    self.infoLab.text = [NSString stringWithFormat:@"支出：￥%.2f   收入：￥%.2f",[groupModel.zprice floatValue],[groupModel.sprice floatValue]];
}

- (void)initView{
    self.backgroundColor = kBackGroundGrayColor;
    
    [self addSubview:self.iconView];
    [self addSubview:self.timeLab];
    [self addSubview:self.infoLab];
    [self addSubview:self.lineView];
    [self addSubview:self.imgView];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(22);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).offset(12);
        make.top.mas_equalTo(kMargin10);
        make.right.mas_equalTo(-50);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLab);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(3);
        make.right.mas_equalTo(-50);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    
    
    self.timeLab.text = @"2017年7月";
    self.infoLab.text = @"支出：￥120.00   收入：￥200.00";
}


#pragma mark ---------------lazy ---------------------/
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.image = [UIImage imageNamed:@"pay_date"];
    }
    return _iconView;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSizeBold14;
        _timeLab.textColor = kColor333333;
    }
    return _timeLab;
}

- (UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = kFontSize13;
        _infoLab.textColor = kColor333333;
        //        _infoLab.backgroundColor = kColorRandom;
    }
    return _infoLab;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kColor6B6B6B;
    }
    return _lineView;
}

- (UIImageView *)imgView{
    if (!_imgView ){
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"pay_jiantou"];
    }
    return _imgView;
}
@end
