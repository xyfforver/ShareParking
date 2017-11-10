//
//  MyRequestRentView.m
//  SharedParking
//
//  Created by galaxy on 2017/11/9.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyRequestRentView.h"
@interface MyRequestRentView ()
@property (nonatomic , strong) UIView *infoBgView;
@property (nonatomic , strong) UIView *btnBgView;

@property (nonatomic , strong) UIView *lineView;

@property (nonatomic , strong) UIButton *deleteBtn;
@property (nonatomic , strong) UIButton *rentBtn;

@property (nonatomic , strong) UIView *greenLine;
@end

@implementation MyRequestRentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    [self addSubview:self.infoBgView];
    [self addSubview:self.btnBgView];
    [self addSubview:self.greenLine];
    [self.btnBgView addSubview:self.deleteBtn];
    [self.btnBgView addSubview:self.lineView];
    [self.btnBgView addSubview:self.rentBtn];
    
    
    [self.greenLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(kMargin15);
    }];
    
    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.bottom.mas_equalTo(self.greenLine.mas_top).offset(-kMargin15);
        make.height.mas_equalTo(50);
    }];
    
    [self.infoBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.btnBgView);
        make.top.mas_equalTo(kMargin10);
        make.bottom.mas_equalTo(self.btnBgView.mas_top).offset(-5);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(self.btnBgView.mas_width).multipliedBy(0.5);
    }];
    
    [self.rentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(self.deleteBtn);
        make.right.mas_equalTo(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kMargin15);
        make.left.mas_equalTo(self.deleteBtn.mas_right).offset(-1);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.btnBgView);
    }];

    CGFloat top = 30;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.backgroundColor = kColorRed;
        [self.infoBgView addSubview:imgView];
        
        UILabel *itemLab = [[UILabel alloc]init];
        itemLab.font = kFontSize15;
        itemLab.textColor = kColor333333;
        itemLab.text = @"哈哈哈哈或";
        [self.infoBgView addSubview:itemLab];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(top);
            make.width.height.mas_equalTo(20);
        }];
        
        [itemLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50);
            make.centerY.mas_equalTo(imgView.mas_centerY);
            make.right.mas_equalTo(-kMargin15);
        }];
        
        top = top + 35;
    }
    
}

#pragma mark ---------------event ---------------------/
- (void)deleteAction:(UIButton *)button{
    
}

- (void)rentAction:(UIButton *)button{
    
}


#pragma mark -----------------Lazy---------------------/
- (UIView *)infoBgView{
    if (!_infoBgView) {
        _infoBgView = [[UIView alloc]init];
        _infoBgView.backgroundColor = kColorWhite;
        _infoBgView.layer.cornerRadius = 5;
        _infoBgView.layer.masksToBounds = YES;
    }
    return _infoBgView;
}

- (UIView *)btnBgView{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc]init];
        _btnBgView.backgroundColor = kColorWhite;
        _btnBgView.layer.cornerRadius = 5;
        _btnBgView.layer.masksToBounds = YES;
    }
    return _btnBgView;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = kFontSize15;
        [_deleteBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (UIButton *)rentBtn{
    if (!_rentBtn) {
        _rentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rentBtn setTitle:@"重新求租" forState:UIControlStateNormal];
        _rentBtn.titleLabel.font = kFontSize15;
        [_rentBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_rentBtn addTarget:self action:@selector(rentAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rentBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kColor6B6B6B;
    }
    return _lineView;
}

- (UIView *)greenLine{
    if (!_greenLine) {
        _greenLine = [[UIView alloc]init];
        _greenLine.backgroundColor = kNavBarColor;
    }
    return _greenLine;
}


+ (CGFloat )getHeight{
    return 280;
}

@end
