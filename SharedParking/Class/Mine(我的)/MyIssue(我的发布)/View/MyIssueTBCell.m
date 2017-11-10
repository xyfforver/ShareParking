//
//  MyIssueTBCell.m
//  SharedParking
//
//  Created by galaxy on 2017/11/10.
//  Copyright © 2017年 galaxy. All rights reserved.
//

#import "MyIssueTBCell.h"
@interface MyIssueTBCell ()
@property (nonatomic , strong) UIView *infoBgView;
@property (nonatomic , strong) UIButton *locationBtn;
@property (nonatomic , strong) UIButton *objectBtn;
@property (nonatomic , strong) UIButton *carTypeBtn;
@property (nonatomic , strong) UIButton *priceBtn;

@property (nonatomic , strong) UIView *btnBgView;
@property (nonatomic , strong) UIView *lineView;
@property (nonatomic , strong) UIButton *deleteBtn;
@property (nonatomic , strong) UIButton *changeBtn;

@end

@implementation MyIssueTBCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initView];
        
    }
    return self;
}

#pragma mark -----------------LifeCycle---------------------/
- (void)initView{
    self.contentView.backgroundColor = kBackGroundGrayColor;
    [self.contentView addSubview:self.infoBgView];
    [self.infoBgView addSubview:self.locationBtn];
    [self.infoBgView addSubview:self.objectBtn];
    [self.infoBgView addSubview:self.carTypeBtn];
    [self.infoBgView addSubview:self.priceBtn];
    
    [self.contentView addSubview:self.btnBgView];
    [self.btnBgView addSubview:self.deleteBtn];
    [self.btnBgView addSubview:self.lineView];
    [self.btnBgView addSubview:self.changeBtn];
    
    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin15);
        make.right.mas_equalTo(-kMargin15);
        make.bottom.mas_equalTo(0);
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
    
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.mas_equalTo(self.deleteBtn);
        make.right.mas_equalTo(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kMargin15);
        make.left.mas_equalTo(self.deleteBtn.mas_right).offset(-1);
        make.width.mas_equalTo(1);
        make.centerY.mas_equalTo(self.btnBgView);
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(30);
    }];
    
    [self.objectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.locationBtn);
        make.top.mas_equalTo(self.locationBtn.mas_bottom).offset(kMargin15);
    }];
    
    [self.carTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.locationBtn);
        make.top.mas_equalTo(self.objectBtn.mas_bottom).offset(kMargin15);
    }];
    
    [self.priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.locationBtn);
        make.top.mas_equalTo(self.carTypeBtn.mas_bottom).offset(kMargin15);
    }];
    
    [_locationBtn setTitle:@"萧山区金城路" forState:UIControlStateNormal];
    [_objectBtn setTitle:@"出租对象：不限" forState:UIControlStateNormal];
    [_carTypeBtn setTitle:@"车位类型：小区" forState:UIControlStateNormal];
    [_priceBtn setTitle:@"出租价格：300元/月" forState:UIControlStateNormal];
}

#pragma mark ---------------event ---------------------/
- (void)deleteAction:(UIButton *)button{
    [UIAlertView alertViewWithTitle:@"提示" message:@"确定要删除此条发布信息？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] onDismiss:^(int buttonIndex, NSString *buttonTitle) {
        
    } onCancel:nil];
}

- (void)changeAction:(UIButton *)button{
    
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

- (UIButton *)locationBtn{
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.titleLabel.font = kFontSize15;
        [_locationBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_locationBtn setImage:[UIImage imageNamed:@"mine_location"] forState:UIControlStateNormal];
        _locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_locationBtn lc_imageTitleHorizontalAlignmentWithSpace:kMargin15];
    }
    return _locationBtn;
}

- (UIButton *)objectBtn{
    if (!_objectBtn) {
        _objectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _objectBtn.titleLabel.font = kFontSize15;
        [_objectBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_objectBtn setImage:[UIImage imageNamed:@"mine_object"] forState:UIControlStateNormal];
        _objectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_objectBtn lc_imageTitleHorizontalAlignmentWithSpace:kMargin15];
    }
    return _objectBtn;
}

- (UIButton *)carTypeBtn{
    if (!_carTypeBtn) {
        _carTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _carTypeBtn.titleLabel.font = kFontSize15;
        [_carTypeBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_carTypeBtn setImage:[UIImage imageNamed:@"mine_cartype"] forState:UIControlStateNormal];
        _carTypeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_carTypeBtn lc_imageTitleHorizontalAlignmentWithSpace:kMargin15];
    }
    return _carTypeBtn;
}

- (UIButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _priceBtn.titleLabel.font = kFontSize15;
        [_priceBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [_priceBtn setImage:[UIImage imageNamed:@"mine_price"] forState:UIControlStateNormal];
        _priceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_priceBtn lc_imageTitleHorizontalAlignmentWithSpace:kMargin15];
    }
    return _priceBtn;
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

- (UIButton *)changeBtn{
    if (!_changeBtn) {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeBtn setTitle:@"修改" forState:UIControlStateNormal];
        _changeBtn.titleLabel.font = kFontSize15;
        [_changeBtn setTitleColor:kColor333333 forState:UIControlStateNormal];

        [_changeBtn addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kColor6B6B6B;
    }
    return _lineView;
}


+ (CGFloat)getHeight{
    return 245;
}

@end
