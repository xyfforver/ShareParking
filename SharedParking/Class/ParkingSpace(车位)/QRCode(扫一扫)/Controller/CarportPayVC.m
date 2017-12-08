//
//  CarportPayVC.m
//  SharedParking
//
//  Created by galaxy on 2017/11/13.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "CarportPayVC.h"
#import "ParkingRecordModel.h"
#import "MZTimerLabel.h"
@interface CarportPayVC ()<MZTimerLabelDelegate>
@property (nonatomic , strong) UIImageView *bgView;
@property (nonatomic , strong) UIImageView *bgItemView;
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) MZTimerLabel *timeLab;
@property (nonatomic , strong) UILabel *priceLab;
@property (nonatomic , strong) UIButton *closeBtn;

@property (nonatomic , strong) NSDate *time;
@property (nonatomic , assign) NSInteger timeCount;
@property (nonatomic , strong) ParkingRecordModel *parkingModel;
@end

@implementation CarportPayVC
- (instancetype)initWithOrderId:(NSString *)orderId{
    self = [super init];
    if (self) {
        self.orderId = orderId;
    }
    return self;
}
#pragma mark ---------------LifeCycle-------------------------/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{
    self.title = @"结算";
    self.timeCount = 1;
    
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.bgItemView];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.timeLab];
    
    [self.view addSubview:self.priceLab];
    [self.view addSubview:self.closeBtn];
    
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(180);
    }];
    
    [self.bgItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.bgView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.centerX.mas_equalTo(self.bgView.mas_centerX).offset(-50);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(5);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(55);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
        make.top.mas_equalTo(self.priceLab.mas_bottom).offset(100);
        make.width.mas_equalTo(185);
        make.height.mas_equalTo(40);
    }];
    
//    self.priceLab.text = @"当前停车费：12元";
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    kSelfWeak;
    [ParkingRecordModel orderInfoWithOrderId:self.orderId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.parkingModel = statusModel.data;
            
            [strongSelf setParkingFee];
            
            strongSelf.time = [NSDate dateWithTimeIntervalSince1970:strongSelf.parkingModel.order_jintime];
            [strongSelf startTime];
            
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

- (void)lockCarportData{
    kSelfWeak;
    [ParkingRecordModel lockWithOrderId:self.orderId payType:@"blancepay" price:@"1" success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            [strongSelf.timeLab pause];
//            [[NSNotificationCenter defaultCenter]postNotificationName:kOpenParkingSpaceSuccessData object:nil];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [WSProgressHUD showImage:nil status:@"已上锁"];
                if (strongSelf.reloadBlock) {
                    strongSelf.reloadBlock();
                }
                [strongSelf backToSuperView];
            });
        }else{
            [WSProgressHUD showImage:nil status:statusModel.message];
        }
    }];
}

#pragma mark ---------------Event-------------------------/
- (void)closeAnAccount:(UIButton *)button{
    [UIAlertView alertViewWithTitle:@"提示" message:@"请确认您的爱车已开出停车位" cancelButtonTitle:@"还没有" otherButtonTitles:@[@"已开出"] onDismiss:^(int buttonIndex, NSString *buttonTitle) {
        [self lockCarportData];
    } onCancel:^{
        
    }];
}

- (void)startTime{
    NSDate *endD = [NSDate date];
    NSTimeInterval start = [self.time timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSInteger value = end - start;
    if (value > 0) {
        NSInteger time = value % (60 * 60 * 24);
        NSInteger day = value / (60 * 60 * 24);
        DLog(@"%ld---%ld",day,time);
        if (day > 0) {
            //超过一天
            self.titleLab.text = [NSString stringWithFormat:@"计时：%ld天 ",day];
        }else{
            self.titleLab.text = @"计时：";
        }
    }
    self.timeLab.startDate = self.time;
    [self.timeLab start];
}

- (void)setParkingFee{
    CGFloat price = self.timeCount * self.parkingModel.park_fee;
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",price];
    NSString *str = [NSString stringWithFormat:@"当前停车费：%@元",priceStr];
    NSMutableAttributedString *contentMuStr = [[NSMutableAttributedString alloc]initWithString:str];
    [contentMuStr addAttribute:NSForegroundColorAttributeName value:kColorDD9900 range:NSMakeRange(str.length - priceStr.length - 1, priceStr.length)];
    self.priceLab.attributedText = contentMuStr;
}

#pragma mark ---------------delegate ---------------------/
- (void)timerLabel:(MZTimerLabel *)timerLabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType{
    NSInteger count = time/60/60 + 1;
    
    if (count != self.timeCount) {
        self.timeCount = count;
        [self setParkingFee];
    }
}


#pragma mark ---------------Lazy-------------------------/
- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        _bgView.image = [UIImage imageNamed:@"carport_bg"];
    }
    return _bgView;
}

- (UIImageView *)bgItemView{
    if (!_bgItemView) {
        _bgItemView = [[UIImageView alloc]init];
        _bgItemView.image = [UIImage imageNamed:@"carport_bgirem"];
    }
    return _bgItemView;
}


- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSizeBold18;
        _titleLab.textColor = kColor333333;
        _titleLab.text = @"计时：";
        _titleLab.textAlignment = NSTextAlignmentRight;
    }
    return _titleLab;
}

- (MZTimerLabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[MZTimerLabel alloc] init];
        _timeLab.timerType = MZTimerLabelTypeStopWatch;
        //do some styling
        _timeLab.timeLabel.backgroundColor = [UIColor clearColor];
        _timeLab.timeLabel.font = kFontSizeBold18;
        _timeLab.timeLabel.textColor = kColorDD9900;
        _timeLab.timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLab.delegate = self;
    }
    return _timeLab;
}

- (UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.backgroundColor = kColorWhite;
        _priceLab.font = kFontSize18;
        _priceLab.textColor = kColor333333;
        _priceLab.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLab;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"点击上锁" forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = kFontSize15;
        [_closeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_closeBtn setBackgroundColor:kNavBarColor];
        [_closeBtn addTarget:self action:@selector(closeAnAccount:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.layer.cornerRadius = 20;
        _closeBtn.layer.masksToBounds = YES;
    }
    return _closeBtn;
}

@end
