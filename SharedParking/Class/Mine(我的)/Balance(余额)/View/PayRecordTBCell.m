//
//  PayRecordTBCell.m
//  yimaxingtianxia
//
//  Created by galaxy on 2017/9/26.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "PayRecordTBCell.h"

@interface PayRecordTBCell()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *timeLab;
@property (nonatomic , strong) UILabel *infoLab;
@end

@implementation PayRecordTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setModel:(PayRecordModel *)model{
    _model = model;
    
    self.titleLab.text = model.type;
    self.timeLab.text = model.addtime;
    self.infoLab.text = [NSString stringWithFormat:@"%@%@元",model.event,model.price];
    if ([model.event isEqualToString:@"+"]) {
        self.infoLab.textColor = kColorGreen;
    }else{
        self.infoLab.textColor = kColorRed;
    }
}

- (void)initView{
    [self.contentView addSubview:self.timeLab];
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.infoLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(kMargin15);
        make.width.mas_equalTo(200);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.titleLab);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
    }];
    
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-kMargin15);
    }];
    
}

#pragma mark ---------------lazy ---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold15;
        _titleLab.textColor = kColor333333;
        //        _titleLab.backgroundColor = kColorRandom;
    }
    return _titleLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize13;
        _timeLab.textColor = kColor333333;
    }
    return _timeLab;
}

- (UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.font = kFontSizeBold15;
        _infoLab.textColor = kColorRed;
        //        _infoLab.backgroundColor = kColorRandom;
        _infoLab.textAlignment = NSTextAlignmentRight;
    }
    return _infoLab;
}




@end
