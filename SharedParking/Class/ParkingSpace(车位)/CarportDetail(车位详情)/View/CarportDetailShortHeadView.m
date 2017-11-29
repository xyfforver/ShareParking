//
//  CarportDetailShortHeadView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/23.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportDetailShortHeadView.h"
@interface CarportDetailShortHeadView()
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *surplusTimeLab;
@property (nonatomic,strong) UIView *lineView;
@end
@implementation CarportDetailShortHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    self.backgroundColor = kColorWhite;
    
    
    [self addSubview:self.titleLab];
    [self addSubview:self.timeLab];
    [self addSubview:self.surplusTimeLab];
    [self addSubview:self.lineView];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(12);
    }];
    
    [self.surplusTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.timeLab);
        make.top.mas_equalTo(self.timeLab.mas_bottom).offset(3);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.titleLab.text = @"每小时：4元";
    self.timeLab.text = @"停车时间至~15：00";
    self.surplusTimeLab.text = @"剩余2小时59分";
}



#pragma mark ---------------lazy ---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColorBlack;
    }
    return _titleLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize15;
        _timeLab.textColor = kColor6B6B6B;
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

- (UILabel *)surplusTimeLab{
    if (!_surplusTimeLab) {
        _surplusTimeLab = [[UILabel alloc]init];
        _surplusTimeLab.font = kFontSize15;
        _surplusTimeLab.textColor = kColorDD9900;
        _surplusTimeLab.textAlignment = NSTextAlignmentRight;
    }
    return _surplusTimeLab;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kBackGroundGrayColor;
    }
    return _lineView;
}
@end
