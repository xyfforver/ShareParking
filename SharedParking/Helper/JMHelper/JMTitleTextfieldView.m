//
//  JMTitleTextfieldView.m
//  yimaxingtianxia
//
//  Created by lingbao on 2017/6/9.
//  Copyright © 2017年 lingbao. All rights reserved.
//

#import "JMTitleTextfieldView.h"
@interface JMTitleTextfieldView()


@end
@implementation JMTitleTextfieldView

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
    [self addSubview:self.textField];
    [self addSubview:self.lineView];

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLab.mas_right).offset(5);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(-kMargin15);
        make.bottom.top.mas_equalTo(0);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.centerY.mas_equalTo(self.mas_centerY);
//        make.right.mas_equalTo(self.textField.mas_left).offset(-5);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
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

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = kFontSize16;
        _textField.textColor = kColor333333;
        _textField.returnKeyType = UIReturnKeyDone;
//        _textField.backgroundColor = kColorRandom;
    }
    return _textField;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kBackGroundGrayColor;
    }
    return _lineView;
}

@end
