//
//  MyRequestRentHeadView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyRequestRentHeadView.h"
@interface MyRequestRentHeadView ()
@property (nonatomic , strong) UILabel *titleLab;
@property (nonatomic , strong) UIButton *requestBtn;
@end

@implementation MyRequestRentHeadView

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
    [self addSubview:self.requestBtn];
    
    self.titleLab.frame = CGRectMake(kMargin15, 75, self.width - kMargin15 * 2, 20);
    self.requestBtn.frame = CGRectMake((self.width - 190) / 2.0, self.titleLab.bottom + 30, 190, 40);
}

#pragma mark ---------------event ---------------------/
- (void)requestAction:(UIButton *)button{
    
}

#pragma mark -----------------Lazy---------------------/
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.font = kFontSize14;
        _titleLab.textColor = kColor6B6B6B;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"当前没有您的求租车位信息";
    }
    return _titleLab;
}

- (UIButton *)requestBtn{
    if (!_requestBtn) {
        _requestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_requestBtn setTitle:@"求租车位" forState:UIControlStateNormal];
        _requestBtn.titleLabel.font = kFontSizeBold15;
        [_requestBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        [_requestBtn setBackgroundColor:kNavBarColor];
        [_requestBtn addTarget:self action:@selector(requestAction:) forControlEvents:UIControlEventTouchUpInside];
        _requestBtn.layer.cornerRadius = 20;
        _requestBtn.layer.masksToBounds = YES;
    }
    return _requestBtn;
}
@end
