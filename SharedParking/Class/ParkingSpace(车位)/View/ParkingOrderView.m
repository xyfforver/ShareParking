//
//  ParkingOrderView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingOrderView.h"
#import "ParkingOrderReserveView.h"
#import "ParkingOrderTimeView.h"

#import "CarportPayVC.h"
#import "ReserveSuccessVC.h"
@interface ParkingOrderView ()
@property (nonatomic , strong) ParkingOrderReserveView *reserveView;
@property (nonatomic , strong) ParkingOrderTimeView *timeView;

@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *numberLab;
@property (nonatomic , strong) UIButton *locationBtn;
@property (nonatomic , strong) UILabel *locationLab;

@property (nonatomic , assign) BOOL isReserve;

@end

@implementation ParkingOrderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setReserveModel:(CarportReserveModel *)reserveModel{
    _reserveModel = reserveModel;
    
    self.isReserve = reserveModel.reserve_time > 0 && reserveModel.order_jintime == 0;
    self.reserveView.hidden = !self.isReserve;
    self.timeView.hidden = self.isReserve;
    
    if (self.isReserve) {
        self.reserveView.reserveTime = reserveModel.reserve_time;
    }else{
        //self.timeView.park_fee = reserveModel.park_fee;
        self.timeView.park_fee = self.price;
        self.timeView.startTime = reserveModel.order_jintime;
    }
    
    self.titleLab.text = reserveModel.park_title;
    self.numberLab.text = reserveModel.parking_number;
    self.locationLab.text = reserveModel.park_address;
    
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.numberLab];
    [self.bgView addSubview:self.locationBtn];
    [self.bgView addSubview:self.locationLab];
    [self zzh_addTapGestureWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self pushToDetail];
    }];
    
    [self addSubview:self.reserveView];
    [self addSubview:self.timeView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(15);
    }];
    
    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab);
        make.right.mas_equalTo(-20);
        make.left.mas_equalTo(self.titleLab.mas_right).offset(5);
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_left);
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(3);
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.top.mas_equalTo(self.locationBtn.mas_bottom).offset(3);
        make.right.mas_equalTo(-20);
    }];
    
    [self.reserveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(43);
    }];
    
    [self.timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(43);
    }];
    
    [self setNeedsLayout];
    
    
}

#pragma mark ---------------event ---------------------/
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bgView.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)UIColorHex(0xE2A12B).CGColor,
                       (id)UIColorHex(0xE27E27).CGColor, nil];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    [self.bgView.layer insertSublayer:gradient atIndex:0];
}

- (void)pushToDetail{
    if (self.isReserve) {
        //预订详情
        ReserveSuccessVC *vc = [[ReserveSuccessVC alloc]initWithReserveId:self.reserveModel.id];
        [self.Controller.navigationController pushViewController:vc animated:YES];
    }else{
        //结算详情
        CarportPayVC *vc = [[CarportPayVC alloc]initWithOrderId:self.reserveModel.id];
        kSelfWeak;
        vc.reloadBlock = ^{
            kSelfStrong;
            strongSelf.hidden = YES;
        };
        vc.park_type = self.reserveModel.park_type;
        [self.Controller.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -----------------Lazy---------------------/
- (ParkingOrderReserveView *)reserveView{
    if (!_reserveView) {
        _reserveView = [[ParkingOrderReserveView alloc]init];
        _reserveView.hidden = YES;
    }
    
    return _reserveView;
}

- (ParkingOrderTimeView *)timeView{
    if (!_timeView) {
        _timeView = [[ParkingOrderTimeView alloc]init];
        _timeView.hidden = YES;
    }
    return _timeView;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = kColorDD9900;
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
        _bgView.layer.shadowOffset = CGSizeMake(2,2);
        _bgView.layer.shadowOpacity = 0.5;
        _bgView.layer.shadowRadius = 2;
        
    }
    return _bgView;
}

- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize18;
        _titleLab.textColor = kColorWhite;
    }
    return _titleLab;
}

- (UILabel *)numberLab{
    if (!_numberLab) {
        _numberLab = [[UILabel alloc]init];
        _numberLab.font = kFontSize18;
        _numberLab.textColor = kColorWhite;
        _numberLab.textAlignment = NSTextAlignmentRight;
    }
    return _numberLab;
}

- (UIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setTitle:@"目的地：" forState:UIControlStateNormal];
        _locationBtn.titleLabel.font = kFontSize13;
        [_locationBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        _locationBtn.userInteractionEnabled = NO;
        [_locationBtn setImage:[UIImage imageNamed:@"home_loc"] forState:UIControlStateNormal];
        [_locationBtn lc_imageTitleHorizontalAlignmentWithSpace:3];
//        _locationBtn.backgroundColor = kColorBlue;
    }
    return _locationBtn;
}

- (UILabel *)locationLab{
    if (!_locationLab) {
        _locationLab = [[UILabel alloc]init];
        _locationLab.font = kFontSize13;
        _locationLab.textColor = kColorWhite;
    }
    return _locationLab;
}

+ (CGFloat)getHeight{
    return 140;
}
@end
