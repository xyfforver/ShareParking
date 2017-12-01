//
//  MicCountDownButton.m
//  EasyGo
//
//  Created by 徐佳琦 on 16/8/31.
//  Copyright © 2016年 Jackie. All rights reserved.
//

#import "JKCountDownButton.h"

#define kDefaultTime 120
#define kDefaultNoramlTitle @"验证"

@interface JKCountDownButton()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIActivityIndicatorView *activity;
@property (nonatomic, assign) NSInteger tempTime;
@end

@implementation JKCountDownButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.titleLabel.font = kFontSize16;
    
    [self setTitle:kDefaultNoramlTitle forState:UIControlStateNormal];
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.time = kDefaultTime;
}

- (void)setNormalTitle:(NSString *)normalTitle
{
    _normalTitle = normalTitle;
    [self setTitle:_normalTitle forState:UIControlStateNormal];
}

- (void)setTime:(NSInteger)time
{
    if (time > 0)
    {
        _time = time;
        _tempTime = time;
    }
}

- (void)buttonClick:(id)button
{
    if (_buttonClickedBlock)
    {
        _buttonClickedBlock();
    }
}

- (void)start
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    if ([_activity isAnimating])
    {
        [_activity stopAnimating];
        [self setTitle:_normalTitle ? _normalTitle : kDefaultNoramlTitle forState:UIControlStateNormal];
    }
    
    _time = _tempTime;
    [self setTitle:[NSString stringWithFormat:@"%@秒后重发", @(self.time)] forState:UIControlStateDisabled];

    kSelfWeak;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        assert(weakSelf != nil);
        weakSelf.enabled = NO;
        weakSelf.timer =[NSTimer scheduledTimerWithTimeInterval:1.0
                                                           target:weakSelf
                                                         selector:@selector(timeAction:)
                                                         userInfo:nil
                                                          repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)timeAction:(NSTimer *)timer
{
    --_time ;
    
    [self setTitle:[NSString stringWithFormat:@"%@秒后重发", @(_time)] forState:UIControlStateDisabled];
    
    if (_time == 0)
    {
        [self stop];
    }
}

- (void)stop
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }

    self.enabled = YES;
    
    if ([_activity isAnimating])
    {
        [_activity stopAnimating];
        
        [self setTitle:_normalTitle ? _normalTitle : kDefaultNoramlTitle forState:UIControlStateNormal];
    }
}

- (void)showActivity
{
    CGFloat h = 15;
    if (!_activity)
    {
        _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((self.width - h) / 2, (self.height - h) / 2, h, h)];
        _activity.color = [UIColor grayColor];
        [self addSubview:_activity];
    }
    [self setTitle:nil forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateDisabled];
    self.enabled = NO;
    [_activity startAnimating];
}

@end
