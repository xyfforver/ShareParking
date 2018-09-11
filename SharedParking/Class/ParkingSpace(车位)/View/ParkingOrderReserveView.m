//
//  ParkingOrderReserveView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/30.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "ParkingOrderReserveView.h"
#import "MZTimerLabel.h"

@interface ParkingOrderReserveView ()<MZTimerLabelDelegate>
{
    dispatch_source_t _timer;
}
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UILabel *timeLab;

@property (nonatomic , strong) MZTimerLabel *timeLabal;
@end

@implementation ParkingOrderReserveView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setReserveTime:(NSInteger)reserveTime{
    _reserveTime = reserveTime;
    
    NSInteger afterTime = reserveTime + 20 * 60;
    NSInteger value = afterTime - [HelpTool getNowTimestamp];
    value = value > 0 ? value : 0;
    [self startTimer:value];
//    [self.timeLabal setCountDownTime:value];
//    [self.timeLabal start];
}
- (void)startTimer:(NSInteger)timeCount
{
    if (_timer)
    {
        dispatch_source_cancel(_timer);
    }
    __block NSInteger count = timeCount;
    kSelfWeak;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if (count<=0)
        {
            dispatch_source_cancel(_timer);
        }
        else
        {
            count--;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf updateTimeLab:count];
        });
    });
    dispatch_resume(_timer);
}

- (void)updateTimeLab:(NSInteger)timeCount
{
    self.timeLab.text = [self getRemainingTime:timeCount];
}

- (NSString *)getRemainingTime:(NSInteger)time;
{
    if (time < 60)
    {
        return [NSString stringWithFormat:@"00:%02ld", time];
    }
    if (time >= 60 && time < 60 * 60)
    {
        NSInteger minute = (time / 60) % 60;
        NSInteger scond = time % 60;
        return [NSString stringWithFormat:@"%02ld:%02ld", minute, scond];
    }
    if (time >= 60 * 60 && time < 24 * 60 * 60)
    {
        NSInteger hour = (time / 60 / 60) % 24;
        NSInteger minute = (time / 60) % 60;
        NSInteger scond = time % 60;
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, minute, scond];
    }
    if (time >= 24 * 60 * 60)
    {
        NSInteger day = time / 60 / 60 / 24;
        NSInteger hour = (time / 60 / 60) % 24;
        NSInteger minute = (time / 60) % 60;
        NSInteger scond = time % 60;
        return [NSString stringWithFormat:@"%02ld %02ld:%02ld:%02ld", day, hour, minute, scond];
    }
    return @"";
}
#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.backgroundColor = kColorWhite;
    self.layer.cornerRadius = 2;
    self.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
    self.layer.shadowOffset = CGSizeMake(2,2);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 2;
    
    [self addSubview:self.titleLab];
    [self addSubview:self.timeLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.equalTo(self.mas_width).multipliedBy(0.55);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right);
        make.centerY.mas_equalTo(self.titleLab.mas_centerY);
        make.right.mas_equalTo(0);
    }];
    
    self.titleLab.text = @"剩余时间：";
    self.timeLab.text = @"00：00";
    
    self.timeLabal  = [[MZTimerLabel alloc]initWithLabel:self.timeLab andTimerType:MZTimerLabelTypeTimer];
    self.timeLabal.timeFormat = @"mm:ss";
    self.timeLabal.delegate = self;
}

#pragma mark ---------------event ---------------------/

#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize15;
        _titleLab.textColor = kColor6B6B6B;
        _titleLab.textAlignment = NSTextAlignmentRight;
    }
    return _titleLab;
}

- (UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.font = kFontSize15;
        _timeLab.textColor = kColorDD9900;
    }
    return _timeLab;
}
@end
