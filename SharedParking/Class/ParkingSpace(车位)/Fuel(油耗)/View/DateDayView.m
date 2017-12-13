//
//  DateDayView.m
//  mayixingBoss
//
//  Created by lingbao on 2017/8/7.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "DateDayView.h"
@interface DateDayView()
@property (nonatomic, strong)UIView *dateBgView;
@property (nonatomic, strong)UIDatePicker *datePick;
@property (nonatomic, strong)UIButton *confirmBtn;
@property (nonatomic, strong)UIButton *cancleBtn;
@property (nonatomic, copy) NSString *dateStr;

@end
@implementation DateDayView


- (instancetype)initWithConfirm:(SelectBlock)selectConfirm{
    
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _selectConfirm = [selectConfirm copy];
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.dateBgView];
    [self.dateBgView addSubview:self.datePick];
    [self.dateBgView addSubview:self.cancleBtn];
    [self.dateBgView addSubview:self.confirmBtn];
    
}

#pragma mark - Master show/dismiss methods
- (void)show
{
    if(!self.superview){
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            BOOL windowHasSubviews = window.subviews.count != 0;
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal && windowHasSubviews) {
                [window addSubview:self];
                break;
            }
        }
    } else {
        [self.superview bringSubviewToFront:self];
    }
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)confirmAction:(UIButton *)button{
    
    if ([NSString isNull:_dateStr]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [dateFormatter setTimeZone:timeZone];
        NSString *destDateString = [dateFormatter stringFromDate:[HelpTool getNowDateEast8]];
        _dateStr = destDateString;
    }
    
    DLog(@"%@",_dateStr);
    
    if (self.selectConfirm) {
        self.selectConfirm(_dateStr);
    }
    
    [self dismiss];
}

- (void)cancelAction:(UIButton *)button{
    [self dismiss];
}


- (void)tapGesture:(UITapGestureRecognizer *)tapGesture
{
    CGPoint tapPointInBgView = [tapGesture locationInView:self];
    CGRect collectionViewRect = self.dateBgView.frame;
    
    if (!CGRectContainsPoint(collectionViewRect, tapPointInBgView)) {
        [self dismiss];
    }
}

- (void)dataValueChanged:(UIDatePicker *)sender{
    UIDatePicker *dataPicker_one = (UIDatePicker *)sender;
    NSDate *date_one = dataPicker_one.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    _dateStr = [formatter stringFromDate:date_one];
    formatter = nil;
    
    DLog(@"------%@",_dateStr);
}

#pragma mark - Getters
- (UIView *)dateBgView{
    if (!_dateBgView) {
        _dateBgView = [[UIView alloc]init];
        _dateBgView.frame = CGRectMake(0, kScreenHeight - 216 - 50, kScreenWidth, 216 + 50);
        _dateBgView.backgroundColor = kColorWhite;
    }
    return _dateBgView;
}

- (UIDatePicker *)datePick {
    if (!_datePick) {
        _datePick = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 216)];
        _datePick.datePickerMode  = UIDatePickerModeDate;
        _datePick.backgroundColor = [UIColor whiteColor];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
        _datePick.locale = locale;
        
        NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
        [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
        NSDate *minDate = [formatter_minDate dateFromString:@"1920-01-01"];
        formatter_minDate = nil;
        NSDate *maxDate = [NSDate date];
        
        [_datePick setMinimumDate:minDate];
        [_datePick setMaximumDate:maxDate];
        
        [_datePick addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePick;
}

- (UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(20, _datePick.bottom, (kScreenWidth - 80)/2.0, 40);
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = kFontSizeBold15;
        [_cancleBtn setTitleColor:kColorDarkgray forState:UIControlStateNormal];
        [_cancleBtn setBackgroundColor:kBackGroundGrayColor];
        [_cancleBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        _cancleBtn.layer.cornerRadius = 5;
        _cancleBtn.layer.masksToBounds = YES;
    }
    return _cancleBtn;
}

- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(kScreenWidth/2.0 + 20, _datePick.bottom, (kScreenWidth - 80)/2.0, 40);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = kFontSizeBold15;
        [_confirmBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:kNavBarColor];
        [_confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.layer.cornerRadius = 5;
        _confirmBtn.layer.masksToBounds = YES;
    }
    return _confirmBtn;
}

@end
