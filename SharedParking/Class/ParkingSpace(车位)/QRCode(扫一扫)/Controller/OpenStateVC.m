//
//  OpenStateVC.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/7/7.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "OpenStateVC.h"

#import "CarportReserveModel.h"
@interface OpenStateVC ()
@property (nonatomic , strong) UIImageView *bgImgView;
@property (nonatomic , strong) UIImageView *lockImgView;
@property (nonatomic , strong) UILabel *progressLab;

@property (nonatomic , strong) UIView *bgWhiteView;
@property (nonatomic , strong) UILabel *stateLab;
@property (nonatomic , strong) UIButton *stateBtn;

@property (nonatomic , assign) BOOL isOpen;
@property (nonatomic , strong) NSTimer *timer;
@property (nonatomic , assign) NSInteger time;
@property (nonatomic , copy) NSString *message;

@end

@implementation OpenStateVC
#pragma mark ---------------LifeCycle-------------------------/
- (instancetype)initWithCarportId:(NSString *)carportId carNumId:(NSString *)carNumId{
    self = [super init];
    if (self) {
        self.carportId = carportId;
        self.carNumId = carNumId;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self loadData];
}

- (void)initView{
    self.view.backgroundColor = kColorWhite;
    self.title = @"正在开启";
    self.time = 0;
    self.isOpen = NO;
    
    [self.view addSubview:self.bgImgView];
    [self.view addSubview:self.lockImgView];
    [self.view addSubview:self.progressLab];
    
    [self.view addSubview:self.bgWhiteView];
    [self.bgWhiteView addSubview:self.stateLab];
    [self.bgWhiteView addSubview:self.stateBtn];
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
    [self.lockImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(-40);
    }];
    
    [self.progressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.lockImgView.mas_bottom).offset(15);
    }];
    
    [self.bgWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(-30);
        make.width.mas_equalTo(kScreenWidth - 140);
        make.height.mas_equalTo(115);
    }];
    
    [self.stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.bgWhiteView);
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.stateBtn.mas_top);
    }];
    

    
    
    self.progressLab.text = @"7%";
}

- (void)setIsOpen:(BOOL)isOpen{
    _isOpen = isOpen;
    
    if (isOpen) {
        //开启
        self.stateLab.text = @"开启成功";
        [self.stateBtn setTitle:@"知道了" forState:UIControlStateNormal];
    }else{
        //开启失败
        self.stateLab.text = [NSString stringWithFormat:@"开启失败\n%@",self.message];
        [self.stateBtn setTitle:@"重新开启" forState:UIControlStateNormal];
    
    }
}

#pragma mark ---------------NetWork-------------------------/
- (void)loadData{
    
    kSelfWeak;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        assert(weakSelf != nil);
        weakSelf.timer =[NSTimer scheduledTimerWithTimeInterval:0.1
                                                         target:weakSelf
                                                       selector:@selector(timeAction:)
                                                       userInfo:nil
                                                        repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });

    [CarportReserveModel openLockWithParkingId:self.carportId carNumId:self.carNumId success:^(StatusModel *statusModel) {
        kSelfStrong;
        if (statusModel.flag == kFlagSuccess) {
            strongSelf.isOpen = YES;
        }else {
            strongSelf.message = statusModel.message;
            strongSelf.isOpen = NO;
        }
    }];
}

#pragma mark ---------------Event-------------------------/
- (void)backToSuperView{
    [super backToSuperView];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kOpenParkingSpaceSuccessData object:nil];
    GetAPPDelegate.rootVC.selectedIndex = 0;
    
}

- (void)openAction{
    if (self.isOpen) {
        //跳回首页
        [self backToSuperView];
    }else{
        //重新开启
        [self loadData];
    }
}

- (void)timeAction:(NSTimer *)timer{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _time += 2;
        self.progressLab.text = [NSString stringWithFormat:@"%ld%%",self.time];
        if (_time == 100)
        {
            _time = 0;
            self.bgWhiteView.hidden = NO;
            [self stop];
        }
    });
    
}

- (void)stop
{
    _time = 0;
    self.bgWhiteView.hidden = NO;
    
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark ---------------Lazy-------------------------/
- (UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc]init];
        _bgImgView.image = [UIImage imageNamed:@"parking_stateBg"];
    }
    return _bgImgView;
}

- (UIImageView *)lockImgView{
    if (!_lockImgView) {
        _lockImgView = [[UIImageView alloc]init];
        _lockImgView.image = [UIImage imageNamed:@"parking_lock"];
    }
    return _lockImgView;
}

- (UILabel *)progressLab{
    if (!_progressLab) {
        _progressLab = [[UILabel alloc]init];
        _progressLab.font = kFontSizeBold20;
        _progressLab.textColor = kNavBarColor;
    }
    return _progressLab;
}

- (UIView *)bgWhiteView{
    if (!_bgWhiteView) {
        _bgWhiteView = [[UIView alloc]init];
        _bgWhiteView.backgroundColor = kBackGroundGrayColor;
        _bgWhiteView.layer.cornerRadius = 5;
        _bgWhiteView.layer.masksToBounds = YES;
//        _bgWhiteView.layer.shadowColor = kColor6B6B6B.CGColor;//shadowColor阴影颜色
//        _bgWhiteView.layer.shadowOffset = CGSizeMake(0,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//        _bgWhiteView.layer.shadowOpacity = 0.8;//阴影透明度，默认0
//        _bgWhiteView.layer.shadowRadius = 4;//阴影半径，默认3
        _bgWhiteView.hidden = YES;
    }
    return _bgWhiteView;
}

- (UILabel *)stateLab{
    if (!_stateLab) {
        _stateLab = [[UILabel alloc]init];
        _stateLab.font = kFontSizeBold18;
        _stateLab.textColor = kColorBlack;
        _stateLab.textAlignment = NSTextAlignmentCenter;
        _stateLab.numberOfLines = 2;
    }
    return _stateLab;
}

- (UIButton *)stateBtn{
    if (!_stateBtn) {
        _stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _stateBtn.titleLabel.font = kFontSize15;
        _stateBtn.backgroundColor = kNavBarColor;
        [_stateBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_stateBtn addTarget:self action:@selector(openAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stateBtn;
}











@end
