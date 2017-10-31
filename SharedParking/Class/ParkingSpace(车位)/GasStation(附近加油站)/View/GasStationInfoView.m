//
//  GasStationInfoView.m
//  SharedParking
//
//  Created by galaxy on 2017/10/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//
#define kViewHeight 190
#import "GasStationInfoView.h"
@interface GasStationInfoView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *distanceLab;
@property (nonatomic , strong) UILabel *locationLab;
@property (nonatomic , strong) UIButton *GPSBtn;
@end

@implementation GasStationInfoView
- (instancetype)initWithConfirmBlock:(SelectBlock)confirmBlock{
    self = [super initWithFrame:CGRectMake(40, kBodyHeight, kScreenWidth - 40 * 2, 120)];
    if (self) {
        self.confirmBlock = [confirmBlock copy];
        
        [self initView];
    }
    return self;
}
- (void)setGasStationModel:(GasStationModel *)gasStationModel{
    _gasStationModel = gasStationModel;
    
    self.titleLab.text = gasStationModel.title;
    
    self.locationLab.text = gasStationModel.location;
    
    NSString *dis = [HelpTool stringWithDistance:(NSInteger )gasStationModel.distance];
    self.distanceLab.text = [NSString stringWithFormat:@"距您%@",dis];
}

#pragma mark ---------------event ---------------------/
#pragma mark - Master show/dismiss methods
- (void)show{
    [UIView animateWithDuration:0.2 animations:^{
        self.top = kBodyHeight - kViewHeight;
    }];
    
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.top = kScreenHeight;
    }];
}

- (void)selectGPSTypeAction:(UIButton *)button{
//    if (self.confirmBlock) {
//        self.confirmBlock(self.mapModel.carlat,self.mapModel.carlng);
//    }
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.backgroundColor = kColorWhite;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    [self addSubview:self.titleLab];
    [self addSubview:self.distanceLab];
    [self addSubview:self.locationLab];
    [self addSubview:self.GPSBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-120);
    }];
    
    [self.distanceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.right.mas_equalTo(-kMargin15);
        make.top.mas_equalTo(20);
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(kMargin10);
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-10);
    }];
    
    [self.GPSBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

#pragma mark -----------------Lazy---------------------/

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColorBlack;
        _titleLab.text = @"加油站";
    }
    return _titleLab;
}

- (UILabel *)distanceLab{
    if (!_distanceLab) {
        _distanceLab = [[UILabel alloc]init];
        _distanceLab.font = kFontSize15;
        _distanceLab.textColor = kColor333333;
        _distanceLab.text = @"据您330m";
        _distanceLab.textAlignment = NSTextAlignmentRight;
    }
    return _distanceLab;
}

- (UILabel *)locationLab{
    if (!_locationLab) {
        _locationLab = [[UILabel alloc]init];
        _locationLab.font = kFontSize15;
        _locationLab.textColor = kColor333333;
        _locationLab.numberOfLines = 2;
        _locationLab.text = @"金城路123号";
    }
    return _locationLab;
}


- (UIButton *)GPSBtn{
    if (!_GPSBtn) {
        _GPSBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_GPSBtn setTitle:@"导航" forState:UIControlStateNormal];
        _GPSBtn.backgroundColor = kNavBarColor;
        [_GPSBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_GPSBtn addTarget:self action:@selector(selectGPSTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _GPSBtn;
}

@end
