//
//  JMTitleTextView.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/9.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "JMTitleTextView.h"
@interface JMTitleTextView()


@end
@implementation JMTitleTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    [self addSubview:self.titleLab];
    [self addSubview:self.textView];
    self.backgroundColor = kColorWhite;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-kMargin15);
        make.left.mas_equalTo(self.titleLab.mas_right).offset(5);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.top.mas_equalTo(kMargin15);
//        make.right.mas_equalTo(self.textView.mas_left).offset(-5);
        make.width.mas_lessThanOrEqualTo(55);
    }];
}



#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize16;
        _titleLab.textColor = kColor333333;
//        _titleLab.backgroundColor = kColorRandom;
    }
    return _titleLab;
}

- (UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = kFontSize16;
        _textView.textColor = kColor333333;
        _textView.returnKeyType = UIReturnKeyDone;
//        _textView.backgroundColor = kColorRandom;
    }
    return _textView;
}

@end
