//
//  CarNumberListTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/16.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarNumberListTBCell.h"
@interface CarNumberListTBCell ()
@property (nonatomic , strong) UIView *infoBgView;
@property (nonatomic , strong) UILabel *carNumLab;
@property (nonatomic , strong) UILabel *endNumLab;
@property (nonatomic , strong) UIButton *deleteBtn;
@end

@implementation CarNumberListTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

- (void)setItemModel:(CarportShortItemModel *)itemModel{
    _itemModel = itemModel;
    
    self.carNumLab.text = itemModel.car_chepai;
    self.endNumLab.text = [NSString stringWithFormat:@"发动机尾号：%@",itemModel.car_fadongji];
}

- (void)initView{
    self.contentView.backgroundColor = kBackGroundGrayColor;
    
    [self.contentView addSubview:self.infoBgView];
    [self.infoBgView addSubview:self.carNumLab];
    [self.infoBgView addSubview:self.endNumLab];
    [self.contentView addSubview:self.deleteBtn];

    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];

    [self.infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.deleteBtn);
        make.top.mas_equalTo(kMargin10);
        make.bottom.mas_equalTo(self.deleteBtn.mas_top).offset(-5);
    }];
    
    [self.carNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(32);
    }];
    
    [self.endNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.carNumLab);
        make.top.mas_equalTo(self.carNumLab.mas_bottom).offset(25);
    }];

    
}

#pragma mark ---------------lazy ---------------------/
- (UIView *)infoBgView{
    if (!_infoBgView) {
        _infoBgView = [[UIView alloc]init];
        _infoBgView.backgroundColor = kColorWhite;
        _infoBgView.layer.cornerRadius = 3;
        _infoBgView.layer.masksToBounds = YES;
    }
    return _infoBgView;
}

- (UILabel *)carNumLab{
    if (!_carNumLab) {
        _carNumLab = [[UILabel alloc]init];
        _carNumLab.font = kFontSizeBold18;
        _carNumLab.textColor = kColorDD9900;
        _carNumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _carNumLab;
}

- (UILabel *)endNumLab{
    if (!_endNumLab) {
        _endNumLab = [[UILabel alloc]init];
        _endNumLab.font = kFontSize16;
        _endNumLab.textColor = kColorBlack;
        _endNumLab.textAlignment = NSTextAlignmentCenter;
    }
    return _endNumLab;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = kFontSize15;
        [_deleteBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        _deleteBtn.backgroundColor = kColorWhite;
        _deleteBtn.layer.cornerRadius = 3;
        _deleteBtn.layer.masksToBounds = YES;

    }
    return _deleteBtn;
}

@end
